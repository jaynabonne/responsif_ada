with Ada.Strings.Unbounded;
with Ada.Containers.Indefinite_Vectors;

package body Expression is
   use Ada.Strings.Unbounded;

   type Expression_Kind is (
      Variable_Expression,
      Numeric_Expression
   );

   type Expression_Step (
      Kind : Expression_Kind
   ) is record
      case Kind is
         when Variable_Expression =>
            Variable : Unbounded_String := Null_Unbounded_String;
         when Numeric_Expression =>
            Value : Float := 0.0;
      end case;
   end record;

   package Steps_Vectors is new Ada.Containers.Indefinite_Vectors (
      Index_Type   => Positive,
      Element_Type => Expression_Step
   );

   type Expression_Data is
   record
      Steps : Steps_Vectors.Vector;
   end record;

   function Is_Digit (C : Character) return Boolean is
   begin
      return C >= '0' and then C <= '9';
   end Is_Digit;

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
   begin
      if Source = "" then
         return;
      end if;

      Expr.Data := new Expression_Data;

      if Is_Digit (Source (Source'First)) then
         Expr.Data.Steps.Append (Expression_Step'(
            Kind => Numeric_Expression,
            Value => Float'Value (Source)
         ));
         return;
      end if;

      Expr.Data.Steps.Append (Expression_Step'(
         Kind => Variable_Expression,
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

      case Expr.Data.Steps (1).Kind is
         when Numeric_Expression =>
            return Expr.Data.Steps (1).Value;
         when Variable_Expression =>
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
