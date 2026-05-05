with AUnit.Assertions; use AUnit.Assertions;

package body Test_Helpers is
   procedure Assert_Equal (
      Actual, Expected : Float;
      Msg : String := ""
   ) is
      Epsilon : constant Float := 1.0E-6;
   begin
      Assert
      (abs (Actual - Expected) <= Epsilon,
         Msg &
         ": expected=" & Float'Image (Expected) &
         ", actual="   & Float'Image (Actual));
   end Assert_Equal;

end Test_Helpers;
