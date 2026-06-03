with Ada.Containers.Indefinite_Vectors;
with Expression.Steps;
with Expression.Compilation; use Expression.Compilation;
with Expression.Evaluation;

with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Hash;
--  with Ada.Text_IO; use Ada.Text_IO;

package body Expression is
   use Expression.Steps;

   type Step_Factory is access function return Compiled_Step;

   type Operator_Info is record
      Precedence : Natural;
      Unary : Boolean := False;
      Create : Step_Factory;
   end record;

   package Operator_Maps is new Ada.Containers.Indefinite_Hashed_Maps
   (Key_Type        => String,
      Element_Type    => Operator_Info,
      Hash            => Ada.Strings.Hash,
      Equivalent_Keys => "=");

   package Step_Vectors is new Ada.Containers.Indefinite_Vectors
   (Index_Type       => Natural,
      Element_Type    => Compiled_Step);

   function Build_Operator_Map return Operator_Maps.Map is
      Map : Operator_Maps.Map;
   begin
      Map.Insert ("unary not", (
         Precedence => 1,
         Unary => True,
         Create => Create_Not_Step'Access)
      );
      Map.Insert ("unary un", (
         Precedence => 1,
         Unary => True,
         Create => Create_Un_Step'Access)
      );
      Map.Insert ("unary more", (
         Precedence => 1,
         Unary => True,
         Create => Create_More_Step'Access)
      );
      Map.Insert ("unary less", (
         Precedence => 1,
         Unary => True,
         Create => Create_Less_Step'Access)
      );
      Map.Insert ("unary -", (
         Precedence => 1,
         Unary => True,
         Create => Create_Unary_Minus_Step'Access)
      );
      Map.Insert ("unary +", (
         Precedence => 1,
         Unary => True,
         Create => Create_Unary_Plus_Step'Access)
      );
      Map.Insert ("and", (
         Precedence => 11,
         Unary => False,
         Create => Create_And_Step'Access)
      );
      Map.Insert ("or", (
         Precedence => 12,
         Unary => False,
         Create => Create_Or_Step'Access)
      );
      Map.Insert ("xor", (
         Precedence => 12,
         Unary => False,
         Create => Create_Xor_Step'Access)
      );
      Map.Insert ("*", (
         Precedence => 3,
         Unary => False,
         Create => Create_Multiply_Step'Access)
      );
      Map.Insert ("/", (
         Precedence => 3,
         Unary => False,
         Create => Create_Divide_Step'Access)
      );
      Map.Insert ("+", (
         Precedence => 4,
         Unary => False,
         Create => Create_Add_Step'Access)
      );
      Map.Insert ("-", (
         Precedence => 4,
         Unary => False,
         Create => Create_Subtract_Step'Access)
      );
      return Map;
   end Build_Operator_Map;

   Operator_Map : constant Operator_Maps.Map := Build_Operator_Map;

   Pending_Operators : Step_Vectors.Vector;

   type Expression_Data is
   record
      Steps : Compiled_Steps;
   end record;

   function Is_Digit (C : Character) return Boolean is
      (C >= '0' and then C <= '9');

   function Is_Operator (Component : String) return Boolean is
      (Operator_Map.Contains (Component) or else
      Operator_Map.Contains ("unary " & Component));

   ---
   ---  Public interface implementations
   ---

   function Is_Compiled (Expr : Compiled_Expression) return Boolean is
   begin
      return Expr.Data /= null;
   end Is_Compiled;

   procedure Compile (
      Source : String;
      Expr   : in out Compiled_Expression
   ) is
      Components : constant Component_Vectors.Vector :=
         Compilation.Components_Of (Source);

      Last_Was_Operand : Boolean := False;

      procedure Push_Remaining_Operators is
      begin
         while not Pending_Operators.Is_Empty loop
            Expr.Data.Steps.Append (
               Pending_Operators (Pending_Operators.Last)
            );
            Pending_Operators.Delete_Last;
         end loop;
      end Push_Remaining_Operators;

      function Get_Operator (Operator : String) return Operator_Info is
      (if Last_Was_Operand then
            Operator_Map (Operator)
         else
            Operator_Map ("unary " & Operator)
      );

      procedure Push_Operator_Step (Component : String) is
         Info : constant Operator_Info := Get_Operator (Component);
      begin
         Pending_Operators.Append (Info.Create.all);
         Last_Was_Operand := False;
      end Push_Operator_Step;

      procedure Push_Numeric_Step (Component : String) is
         Number : constant Float := Float'Value (Component);
      begin
         Expr.Data.Steps.Append (Create_Numeric_Step (Number));
         Last_Was_Operand := True;
      end Push_Numeric_Step;

      procedure Push_Variable_Step (Name : String) is
      begin
         Expr.Data.Steps.Append (Create_Variable_Step (Name));
         Last_Was_Operand := True;
      end Push_Variable_Step;

   begin
      if Components.Is_Empty then
         return;
      end if;

      Expr.Data := new Expression_Data;

      for Component of Components loop
         if Is_Operator (Component) then
            Push_Operator_Step (Component);
         elsif Is_Digit (Component (Component'First)) then
            Push_Numeric_Step (Component);
         else
            Push_Variable_Step (Component);
         end if;
      end loop;
      Push_Remaining_Operators;

      --  Put_Line ("Compiled " & Source & " to " & Expr.Data.Steps'Image);
   end Compile;

   function Eval (
      Expr    : Compiled_Expression;
      Lookup  : Lookup_Function
   ) return Float is begin
      if not Is_Compiled (Expr) then
         raise Program_Error with "Expression not compiled";
      end if;

      return Expression.Evaluation.Evaluate_Expression (
         Expr.Data.Steps,
         Lookup => Lookup
      );
   end Eval;
end Expression;
