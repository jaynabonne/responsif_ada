--  with AUnit.Assertions; use AUnit.Assertions;
with AUnit.Test_Cases; use AUnit.Test_Cases;
with Test_Helpers; use Test_Helpers;

with Expression; use Expression;

package body Test_Expression is

   --  Tests for Fuzzy_Not
   procedure Test_Something
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
      Compiled : Compiled_Expression;
   begin
      Compile ("not 1.0", Compiled);
      Assert_Equal (Evaluate (Compiled), 0.0, "should return 0");
   end Test_Something;

   overriding procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Something'Access, "Test_Something");
   end Register_Tests;

   overriding function Name
     (T : Test_Case) return AUnit.Message_String
   is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Expression tests");
   end Name;

end Test_Expression;
