with AUnit.Assertions; use AUnit.Assertions;
with AUnit.Test_Cases; use AUnit.Test_Cases;

package body Test_Topics is

   overriding procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine
        (T,
         Test_Decay'Access,
         "Decay works");
   end Register_Tests;

   overriding function Name
     (T : Test_Case) return AUnit.Message_String
   is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Topic tests");
   end Name;

   procedure Test_Decay
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
   begin
      Assert (True, "placeholder");
   end Test_Decay;

end Test_Topics;
