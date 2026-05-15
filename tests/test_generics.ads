package Test_Generics is

   generic
      type T is private;
      with function Image (X : T) return String;
      with function Equal (L, R : T) return Boolean is <>;
   procedure Generic_Assert_Equal (
      Actual, Expected : T;
      Msg : String := ""
   );

   generic
      Epsilon : Float := 1.0E-6;
   function Generic_Float_Equal (Actual, Expected : Float) return Boolean;

end Test_Generics;