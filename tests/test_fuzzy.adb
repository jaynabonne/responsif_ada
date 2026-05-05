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
      Assert_Equal (FuzzyNot (1.0), 0.0, "should return 0 for 1");
      Assert_Equal (FuzzyNot (0.0), 1.0, "should return 1 for 0");
      Assert_Equal (
         FuzzyNot (-1.0),
         1.0,
         "should return 1 for negative value"
      );
      Assert_Equal (
         FuzzyNot (3.0),
         0.0,
         "should return 0 for value greater than 1"
      );
   end Test_Not;

   overriding procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Not'Access, "FuzzyNot");
   end Register_Tests;

   overriding function Name
     (T : Test_Case) return AUnit.Message_String
   is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Fuzzy tests");
   end Name;

end Test_Fuzzy;