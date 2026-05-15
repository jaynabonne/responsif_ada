with Ada.Strings.Unbounded;

package body Expression is
   use Ada.Strings.Unbounded;

   type Expression_Data is record
      Variable : Unbounded_String := Null_Unbounded_String;
   end record;

   function Is_Compiled (Expr : Compiled_Expression) return Boolean is
   begin
      return Expr.Data /= null;
   end Is_Compiled;

   procedure Compile (
      Source : String;
      Expr   : in out Compiled_Expression
   ) is begin
      if Source = "" then
         null;
      else
         Expr.Data := new Expression_Data;
         Expr.Data.Variable := To_Unbounded_String (Source);
      end if;
   end Compile;

   function Evaluate (
      Expr    : Compiled_Expression;
      Lookup  : Lookup_Function
   ) return Float is begin
      if not Is_Compiled (Expr) then
         raise Program_Error with "Expression not compiled";
      end if;
      declare
         Variable : constant String := To_String (Expr.Data.Variable);
         Result : constant Lookup_Result := Lookup.all (Variable);
      begin
         if Result.Found then
            return Result.Value;
         else
            raise Program_Error with "Variable not found: " & Variable;
         end if;
      end;
   end Evaluate;

end Expression;
