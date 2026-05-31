with Expression.Steps;
with Expression.Compilation; use Expression.Compilation;
with Expression.Evaluation;

with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Hash;

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

   function Build_Operator_Map return Operator_Maps.Map is
      Map : Operator_Maps.Map;
   begin
      Map.Insert ("not", (
         Precedence => 3,
         Unary => True,
         Create => Create_Not_Step'Access)
      );
      Map.Insert ("more", (
         Precedence => 3,
         Unary => True,
         Create => Create_More_Step'Access)
      );
      return Map;
   end Build_Operator_Map;

   Operator_Map : constant Operator_Maps.Map := Build_Operator_Map;

   type Expression_Data is
   record
      Steps : Compiled_Steps;
   end record;

   function Is_Digit (C : Character) return Boolean is
      (C >= '0' and then C <= '9');

   function Is_Operator (Component : String) return Boolean is
      (Operator_Map.Contains (Component));

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
      Pending_Step : Compiled_Step;
   begin
      if Components.Is_Empty then
         return;
      end if;

      Expr.Data := new Expression_Data;
      for Component of Components loop
         if Is_Operator (Component) then
            Pending_Step := Operator_Map (Component).Create.all;
         elsif Is_Digit (Component (Component'First)) then
            Expr.Data.Steps.Append (
               Create_Numeric_Step (Float'Value (Component))
            );
         else
            Expr.Data.Steps.Append (Create_Variable_Step (Component));
         end if;
      end loop;
      if Pending_Step.Kind /= No_Step then
         Expr.Data.Steps.Append (Pending_Step);
      end if;
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
