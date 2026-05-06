package body Fuzzy is

   function Fuzzy_Not (V : Fuzzy_Value) return Fuzzy_Value is
   begin
      return Fuzzy_Value'Min (1.0 - V, 1.0);
   end Fuzzy_Not;

   function Fuzzy_Un (V : Fuzzy_Value) return Fuzzy_Value is
   begin
      return 0.0 - V;
   end Fuzzy_Un;

   function Fuzzy_Equals (V1, V2 : Fuzzy_Value) return Fuzzy_Value is
   begin
      return 1.0 - abs (V1 - V2);
   end Fuzzy_Equals;

      function Fuzzy_Or (V1, V2 : Fuzzy_Value) return Fuzzy_Value is
      begin
         return Fuzzy_Value'Max (V1, V2);
      end Fuzzy_Or;

   function Fuzzy_And (V1, V2 : Fuzzy_Value) return Fuzzy_Value is
   begin
      return Fuzzy_Value'Min (V1, V2);
   end Fuzzy_And;

   function Fuzzy_Xor (V1, V2 : Fuzzy_Value) return Fuzzy_Value is
   begin
      --  (A and not B) or (B and not A)
      return Fuzzy_Value'Max (
         Fuzzy_Value'Max (
            Fuzzy_Value'Min (1.0 - V1, V2),
            Fuzzy_Value'Min (V1, 1.0 - V2)
         ),
         0.0
      );
   end Fuzzy_Xor;
end Fuzzy;
