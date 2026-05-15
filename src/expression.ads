with Ada.Finalization;

package Expression is

   type Compiled_Expression is limited private;
   type Lookup_Result (Found : Boolean := False) is record
      case Found is
         when True =>
            Value : Float;
         when False =>
            null;
      end case;
   end record;

   type Lookup_Function is access function (Name : String)
      return Lookup_Result;

   function Is_Compiled (Expr : Compiled_Expression) return Boolean;

   procedure Compile (
      Source : String;
      Expr   : in out Compiled_Expression
   );

   function Evaluate (
      Expr    : Compiled_Expression;
      Lookup  : Lookup_Function
   ) return Float;

private

   type Expression_Data;
   type Expression_Data_Access is access Expression_Data;

   type Compiled_Expression is
      new Ada.Finalization.Limited_Controlled with record
         Data : Expression_Data_Access := null;
      end record;

end Expression;
