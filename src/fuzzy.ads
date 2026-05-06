package Fuzzy is
   subtype Fuzzy_Value is Float range -1.0 .. 1.0;
   function Fuzzy_Not (F : Fuzzy_Value) return Fuzzy_Value;
   function Fuzzy_Un (F : Fuzzy_Value) return Fuzzy_Value;

end Fuzzy;