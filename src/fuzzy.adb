package body Fuzzy is

   function Fuzzy_Not (F : Fuzzy_Value) return Fuzzy_Value is
   begin
      return Fuzzy_Value'Min (1.0 - F, 1.0);
   end Fuzzy_Not;

end Fuzzy;
