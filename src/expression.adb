with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;

package body Expression is
   use Ada.Strings.Unbounded;

   type Expression_Step_Type is (
      None,
      Variable_Expression,
      Numeric_Expression
   );

   type Expression_Step (
      Expression_Kind : Expression_Step_Type := None
   ) is record
      case Expression_Kind is
         when None =>
            null;
         when Variable_Expression =>
            Variable : Unbounded_String := Null_Unbounded_String;
         when Numeric_Expression =>
            Value : Float := 0.0;
      end case;
   end record;

   package Steps_Vectors is new Ada.Containers.Vectors (
      Index_Type   => Positive,
      Element_Type => Expression_Step
   );

   type Expression_Data is
   record
      Steps : Steps_Vectors.Vector;
   end record;

   function Is_Compiled (Expr : Compiled_Expression) return Boolean is
   begin
      return Expr.Data /= null;
   end Is_Compiled;

   function Is_Digit (C : Character) return Boolean is
   begin
      return C >= '0' and then C <= '9';
   end Is_Digit;

   procedure Compile (
      Source : String;
      Expr   : in out Compiled_Expression
   ) is
   begin
      if Source = "" then
         return;
      end if;

      Expr.Data := new Expression_Data;

      if Is_Digit (Source (Source'First)) then
         Expr.Data.Steps.Append (Expression_Step'(
            Expression_Kind => Numeric_Expression,
            Value => Float'Value (Source)
         ));
         return;
      end if;

      Expr.Data.Steps.Append (Expression_Step'(
         Expression_Kind => Variable_Expression,
         Variable => To_Unbounded_String (Source)
      ));
   end Compile;

   function Evaluate (
      Expr    : Compiled_Expression;
      Lookup  : Lookup_Function
   ) return Float is begin
      if not Is_Compiled (Expr) then
         raise Program_Error with "Expression not compiled";
      end if;

      case Expr.Data.Steps (1).Expression_Kind is
         when None =>
            raise Program_Error with "Expression has no steps";
         when Numeric_Expression =>
            return Expr.Data.Steps (1).Value;
         when Variable_Expression =>
            null; --  handled below
         declare
            Variable : constant String :=
               To_String (Expr.Data.Steps (1).Variable);
            Result : constant Lookup_Result := Lookup.all (Variable);
         begin
            if Result.Found then
               return Result.Value;
            else
               raise Program_Error with "Variable not found: " & Variable;
            end if;
         end;
      end case;

   end Evaluate;
end Expression;
