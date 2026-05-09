with AUnit.Assertions; use AUnit.Assertions;

package body Test_Generics is

   function Generic_Float_Equal (Actual, Expected : Float) return Boolean
   is
   begin
      return abs (Actual - Expected) <= Epsilon;
   end Generic_Float_Equal;

   procedure Generic_Assert_Equal
   (Actual, Expected : T;
      Msg : String := "")
   is
   begin
      Assert
      (Equal (Actual, Expected),
         Msg &
         ": expected=" & Image (Expected) &
         ", actual="   & Image (Actual));
   end Generic_Assert_Equal;

end Test_Generics;