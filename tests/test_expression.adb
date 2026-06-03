with AUnit.Assertions; use AUnit.Assertions;
with AUnit.Test_Cases; use AUnit.Test_Cases;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Test_Helpers; use Test_Helpers;
with Fuzzy; use Fuzzy;

with Expression; use Expression;

package body Test_Expression is

   Fuzzy_Test_Value : constant Fuzzy_Value := 0.75;
   function Test_Lookup (Name : String) return Lookup_Result is
   begin
      if Name = "var1" then
         return (Found => True, Value => 10.0);
      elsif Name = "var2" then
         return (Found => True, Value => 5.0);
      elsif Name = "fuzzyvar" then
         return (Found => True, Value => Fuzzy_Test_Value);
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

   type Expression_Test_Case is record
      Expression : Unbounded_String;
      Expected : Float;
   end record;

   type Expression_Test_Cases is
      array (Natural range <>) of Expression_Test_Case;

   function TC (Expression : String; Expected : Float)
      return Expression_Test_Case is
      (Expression => To_Unbounded_String (Expression), Expected => Expected);

   The_Expression_Test_Cases : constant Expression_Test_Cases := [
      TC ("var1", 10.0),
      TC ("314.0", 314.0),
      TC ("not var1", Fuzzy_Not (1.0)),
      TC ("un fuzzyvar", Fuzzy_Un (Fuzzy_Test_Value)),
      TC ("more fuzzyvar", Fuzzy_More (Fuzzy_Test_Value)),
      TC ("less fuzzyvar", Fuzzy_Less (Fuzzy_Test_Value)),
      TC ("not not var1", Fuzzy_Not (Fuzzy_Not (1.0))),
      TC ("0.3 and 0.6", Fuzzy_And (0.3, 0.6)),
      TC ("0.3 or 0.6", Fuzzy_Or (0.3, 0.6)),
      TC ("0.3 xor 0.6", Fuzzy_Xor (0.3, 0.6)),
      TC ("4 + var1", 14.0),
      TC ("var1-6", 4.0),
      TC ("4 * var1", 40.0),
      TC ("var1 / var2", 2.0),
      TC ("-var1", -10.0),
      TC ("+var2", 5.0)
   ];

   procedure Test_Expression (Test_Case : Expression_Test_Case) is
      Compiled : Compiled_Expression;
      Result : Float;
      Expression : constant String := To_String (Test_Case.Expression);
   begin
      Compile (Expression, Compiled);
      Assert (Is_Compiled (Compiled), "should be compiled");
      Result := Eval (Compiled, Test_Lookup'Access);
      Assert_Equal (
         Result,
         Test_Case.Expected,
         "should evaluate to the expected value for " & Expression
      );
   end Test_Expression;

   procedure Test_Expressions
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
   begin
      for Test_Case of The_Expression_Test_Cases loop
         Test_Expression (Test_Case);
      end loop;
   end Test_Expressions;

   overriding procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (
         T, Test_Uncompiled_Expression'Access,
         "Does not compile an empty expression"
      );
      Register_Routine (
         T, Test_Expressions'Access,
         "Should properly compile and evaluate various expressions"
      );
   end Register_Tests;

   overriding function Name
     (T : Test_Case with Unreferenced) return AUnit.Message_String
   is
   begin
      return AUnit.Format ("Expression tests");
   end Name;

end Test_Expression;
