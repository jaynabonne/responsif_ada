package Test_Helpers is

   procedure Assert_Equal (
      Actual, Expected : Float;
      Msg : String := ""
   );

   procedure Assert_GreaterThan (
      Actual, Expected : Float;
      Msg : String := ""
   );

   procedure Assert_LessThan (
      Actual, Expected : Float;
      Msg : String := ""
   );

end Test_Helpers;
