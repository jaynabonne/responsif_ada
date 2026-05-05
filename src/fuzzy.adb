package body Fuzzy is

   function FuzzyNot (F : Float) return Float is
   begin
      return Float'Max (Float'Min (1.0 - F, 1.0), 0.0);
   end FuzzyNot;

end Fuzzy;
