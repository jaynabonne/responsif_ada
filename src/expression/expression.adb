with Expression.Steps;
with Expression.Evaluate;

package body Expression is
   use Expression.Steps;

   type Expression_Data is
   record
      Steps : Compiled_Steps;
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
         Expr.Data.Steps.Append (Create_Numeric_Step (Float'Value (Source)));
         return;
      end if;

      Expr.Data.Steps.Append (Create_Variable_Step (Source));
   end Compile;

   function Eval (
      Expr    : Compiled_Expression;
      Lookup  : Lookup_Function
   ) return Float is begin
      if not Is_Compiled (Expr) then
         raise Program_Error with "Expression not compiled";
      end if;

      return Expression.Evaluate.Evaluate_Expression (
         Expr.Data.Steps,
         Lookup => Lookup
      );
   end Eval;
end Expression;
