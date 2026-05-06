package body Fuzzy is

   function Fuzzy_Not (F : Fuzzy_Value) return Fuzzy_Value is
   begin
      return Fuzzy_Value'Min (1.0 - F, 1.0);
   end Fuzzy_Not;

   function Fuzzy_Un (F : Fuzzy_Value) return Fuzzy_Value is
   begin
      return 0.0 - F;
   end Fuzzy_Un;

end Fuzzy;
