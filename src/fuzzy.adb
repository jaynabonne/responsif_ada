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

   function Fuzzy_Rem (A, B : Fuzzy_Value) return Fuzzy_Value is
   begin
      return (if A < B then A else 1.0);
   end Fuzzy_Rem;

   function Fuzzy_Difference (A, B : Fuzzy_Value) return Fuzzy_Value is
   begin
      return Fuzzy_Value'Min (abs (A - B), 1.0);
   end Fuzzy_Difference;

   function Fuzzy_Adjust (
      Value : Fuzzy_Value;
      Target : Fuzzy_Value;
      Increment : Fuzzy_Value := 0.5
   ) return Fuzzy_Value is
      New_Value : constant Fuzzy_Value := Value + (Target - Value) * Increment;
   begin
      return (
         if abs (Target - New_Value) < 0.005
            then Target
            else New_Value
      );
   end Fuzzy_Adjust;

   function Fuzzy_More (
      Value : Fuzzy_Value;
      Increment : Fuzzy_Value := 0.5
   ) return Fuzzy_Value is
   begin
      return Fuzzy_Adjust (Value, 1.0, Increment);
   end Fuzzy_More;

   function Fuzzy_Less (
      Value : Fuzzy_Value;
      Increment : Fuzzy_Value := 0.5
   ) return Fuzzy_Value is
   begin
      return Fuzzy_Adjust (Value, -1.0, Increment);
   end Fuzzy_Less;
end Fuzzy;
