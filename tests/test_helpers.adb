with AUnit.Assertions; use AUnit.Assertions;

package body Test_Helpers is

   procedure Assert_GreaterThan (
      Actual, Expected : Float;
      Msg : String := ""
   ) is
   begin
      Assert
      (Actual > Expected,
         Msg &
         ": expected " & Float'Image (Actual) &
         " to be greater than "  & Float'Image (Expected));
   end Assert_GreaterThan;

   procedure Assert_LessThan (
      Actual, Expected : Float;
      Msg : String := ""
   ) is
   begin
      Assert
      (Actual < Expected,
         Msg &
         ": expected " & Float'Image (Actual) &
         " to be less than "  & Float'Image (Expected));
   end Assert_LessThan;

end Test_Helpers;
