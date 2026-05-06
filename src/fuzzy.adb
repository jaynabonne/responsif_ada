package body Fuzzy is

   function Fuzzy_Not (A : Fuzzy_Value) return Fuzzy_Value is
   begin
      return Fuzzy_Value'Min (1.0 - A, 1.0);
   end Fuzzy_Not;

   function Fuzzy_Un (A : Fuzzy_Value) return Fuzzy_Value is
   begin
      return 0.0 - A;
   end Fuzzy_Un;

   function Fuzzy_Equals (A, B : Fuzzy_Value) return Fuzzy_Value is
   begin
      return 1.0 - abs (A - B);
   end Fuzzy_Equals;

      function Fuzzy_Or (A, B : Fuzzy_Value) return Fuzzy_Value is
      begin
         return Fuzzy_Value'Max (A, B);
      end Fuzzy_Or;

   function Fuzzy_And (A, B : Fuzzy_Value) return Fuzzy_Value is
   begin
      return Fuzzy_Value'Min (A, B);
   end Fuzzy_And;

   function Fuzzy_Xor (A, B : Fuzzy_Value) return Fuzzy_Value is
   begin
      --  (A and not B) or (B and not A)
      return Fuzzy_Value'Max (
         Fuzzy_Value'Max (
            Fuzzy_Value'Min (1.0 - A, B),
            Fuzzy_Value'Min (A, 1.0 - B)
         ),
         0.0
      );
   end Fuzzy_Xor;

   function Fuzzy_Mod (A, B : Fuzzy_Value) return Fuzzy_Value is
   begin
      return (if A > B then A else 0.0);
   end Fuzzy_Mod;
end Fuzzy;
