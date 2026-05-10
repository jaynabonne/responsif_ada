package body Expression is

   type Expression_Data is null record;

   function Is_Compiled (Expr : Compiled_Expression) return Boolean is
   begin
      return Expr.Data /= null;
   end Is_Compiled;

   procedure Compile (
      Source : String;
      Expr   : in out Compiled_Expression
   ) is begin
      null;
   end Compile;

   function Evaluate (
      Expr    : Compiled_Expression
      --  Context : Evaluation_Context
   ) return Float is begin
      return 0.0;
   end Evaluate;

end Expression;
