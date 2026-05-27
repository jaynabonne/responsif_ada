with AUnit.Assertions; use AUnit.Assertions;
with AUnit.Test_Cases; use AUnit.Test_Cases;
with Test_Helpers; use Test_Helpers;

with Expression.Compilation; use Expression.Compilation;

package body Expression.Test_Compilation is
   --  Test for splitting an empty expression
   procedure Test_Uncompiled_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Components : constant Compilation.Component_Vectors.Vector :=
         Compilation.Components_Of ("");
   begin
      Assert (Components.Is_Empty, "should be empty");
   end Test_Uncompiled_Expression;

   overriding procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (
         T, Test_Uncompiled_Expression'Access,
         "Test splitting an empty expression"
      );
   end Register_Tests;

   overriding function Name
     (T : Test_Case with Unreferenced) return AUnit.Message_String
   is
   begin
      return AUnit.Format ("Expression compilation tests");
   end Name;

end Expression.Test_Compilation;
