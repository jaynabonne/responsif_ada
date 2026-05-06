package Fuzzy is
   subtype Fuzzy_Value is Float range -1.0 .. 1.0;
   function Fuzzy_Not (V : Fuzzy_Value) return Fuzzy_Value;
   function Fuzzy_Un (V : Fuzzy_Value) return Fuzzy_Value;
   function Fuzzy_Equals (V1, V2 : Fuzzy_Value) return Fuzzy_Value;
   function Fuzzy_Or (V1, V2 : Fuzzy_Value) return Fuzzy_Value;
   function Fuzzy_And (V1, V2 : Fuzzy_Value) return Fuzzy_Value;
   function Fuzzy_Xor (V1, V2 : Fuzzy_Value) return Fuzzy_Value;
end Fuzzy;