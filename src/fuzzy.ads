package Fuzzy is
   subtype Fuzzy_Value is Float range -1.0 .. 1.0;
   function Fuzzy_Not (A : Fuzzy_Value) return Fuzzy_Value;
   function Fuzzy_Un (A : Fuzzy_Value) return Fuzzy_Value;
   function Fuzzy_Equals (A, B : Fuzzy_Value) return Fuzzy_Value;
   function Fuzzy_Or (A, B : Fuzzy_Value) return Fuzzy_Value;
   function Fuzzy_And (A, B : Fuzzy_Value) return Fuzzy_Value;
   function Fuzzy_Xor (A, B : Fuzzy_Value) return Fuzzy_Value;
   --  Fuzzy truncation
   function Fuzzy_Mod (A, B : Fuzzy_Value) return Fuzzy_Value;
   --  Fuzzy round
   function Fuzzy_Rem (A, B : Fuzzy_Value) return Fuzzy_Value;
   function Fuzzy_Difference (A, B : Fuzzy_Value) return Fuzzy_Value;
end Fuzzy;