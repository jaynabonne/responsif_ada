with Test_Generics;

package Test_Helpers is

   function Float_Equal is new Test_Generics.Generic_Float_Equal;

   procedure Assert_Equal is new Test_Generics.Generic_Assert_Equal
     (T     => Float,
      Image => Float'Image,
      Equal => Float_Equal);

   procedure Assert_GreaterThan (
      Actual, Expected : Float;
      Msg : String := ""
   );

   procedure Assert_LessThan (
      Actual, Expected : Float;
      Msg : String := ""
   );

end Test_Helpers;
