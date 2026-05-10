with Ada.Finalization;

package Expression is

   type Compiled_Expression is limited private;

   function Is_Compiled (Expr : Compiled_Expression) return Boolean;

   procedure Compile (
      Source : String;
      Expr   : in out Compiled_Expression
   );

   function Evaluate (
      Expr    : Compiled_Expression
      --  Context : Evaluation_Context
   ) return Float;

private

   type Expression_Data;
   type Expression_Data_Access is access Expression_Data;

   type Compiled_Expression is
      new Ada.Finalization.Limited_Controlled with record
         Data : Expression_Data_Access := null;
      end record;

end Expression;
