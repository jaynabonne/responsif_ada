--  with AUnit.Assertions; use AUnit.Assertions;
with AUnit.Test_Cases; use AUnit.Test_Cases;
with Test_Helpers; use Test_Helpers;

with Fuzzy; use Fuzzy;

package body Test_Fuzzy is

   procedure Test_Not
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
   begin
      Assert_Equal (Fuzzy_Not (1.0), 0.0, "should return 0 for 1");
      Assert_Equal (Fuzzy_Not (0.0), 1.0, "should return 1 for 0");
      Assert_Equal (
         Fuzzy_Not (-1.0),
         1.0,
         "should return 1 for negative value"
      );
   end Test_Not;

   procedure Test_Un
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
   begin
      Assert_Equal (Fuzzy_Un (0.0), 0.0, "should return 0.0 for 0");
      Assert_Equal (Fuzzy_Un (1.0), -1.0, "should return -1 for 1");
   end Test_Un;

   overriding procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Not'Access, "Fuzzy_Not");
      Register_Routine (T, Test_Un'Access, "Fuzzy_Un");
   end Register_Tests;

   overriding function Name
     (T : Test_Case) return AUnit.Message_String
   is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Fuzzy tests");
   end Name;

end Test_Fuzzy;