with AUnit.Assertions; use AUnit.Assertions;
with AUnit.Test_Cases; use AUnit.Test_Cases;
with Test_Helpers; use Test_Helpers;

with Expression; use Expression;

package body Test_Expression is

   function Test_Lookup (Name : String) return Lookup_Result is
   begin
      if Name = "var1" then
         return (Found => True, Value => 10.0);
      elsif Name = "var2" then
         return (Found => True, Value => 5.0);
      else
         return (Found => False);
      end if;
   end Test_Lookup;

   --  Test for compiling an empty expression
   procedure Test_Uncompiled_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Compiled : Compiled_Expression;
   begin
      Compile ("", Compiled);
      Assert (not Is_Compiled (Compiled), "should not be compiled");
   end Test_Uncompiled_Expression;

   --  Test for compiling a variable
   procedure Test_Variable_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Compiled : Compiled_Expression;
      Result : Float;
   begin
      Compile ("var1", Compiled);
      Assert (Is_Compiled (Compiled), "should be compiled");

      Result := Evaluate (Compiled, Test_Lookup'Access);
      Assert_Equal (Result, 10.0, "should evaluate to the variable's value");
   end Test_Variable_Expression;

   --  Test for compiling a number
   procedure Test_Numeric_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Compiled : Compiled_Expression;
      Result : Float;
   begin
      Compile ("314", Compiled);
      Assert (Is_Compiled (Compiled), "should be compiled");

      Result := Evaluate (Compiled, Test_Lookup'Access);
      Assert_Equal (Result, 314.0, "should evaluate to the number's value");
   end Test_Numeric_Expression;

   overriding procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (
         T, Test_Uncompiled_Expression'Access,
         "Does not compile an empty expression"
      );
      Register_Routine (
         T, Test_Variable_Expression'Access,
         "Should compile a variable"
      );
      Register_Routine (
         T, Test_Numeric_Expression'Access,
         "Should compile a number"
      );
   end Register_Tests;

   overriding function Name
     (T : Test_Case with Unreferenced) return AUnit.Message_String
   is
   begin
      return AUnit.Format ("Expression tests");
   end Name;

end Test_Expression;
