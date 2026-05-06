--  with AUnit.Assertions; use AUnit.Assertions;
with AUnit.Test_Cases; use AUnit.Test_Cases;
with Test_Helpers; use Test_Helpers;

with Fuzzy; use Fuzzy;

package body Test_Fuzzy is

   --  Tests for Fuzzy_Not
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

   --  Tests for Fuzzy_Un
   procedure Test_Un
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
   begin
      Assert_Equal (Fuzzy_Un (0.0), 0.0, "should return 0.0 for 0");
      Assert_Equal (Fuzzy_Un (1.0), -1.0, "should return -1 for 1");
   end Test_Un;

   --  Tests for Fuzzy_Equals
   procedure Test_Equals
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
   begin
      Assert_Equal (
         Fuzzy_Equals (1.0, 1.0), 1.0,
         "should return 1.0 for two equals numbers"
      );
      Assert_Equal (
         Fuzzy_Equals (0.0, 1.0), 0.0,
         "should return 0 for X and not X"
      );
      Assert_Equal (
         Fuzzy_Equals (1.0, -1.0), -1.0,
         "should return -1 for X and un X"
      );
   end Test_Equals;

   --  Tests for Fuzzy_Or
   procedure Test_Or
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
   begin
      Assert_Equal (
         Fuzzy_Or (1.0, 1.0), 1.0,
         "should return the max of two values"
      );
      Assert_Equal (
         Fuzzy_Or (1.0, 0.0), 1.0,
         "should return the max of two values"
      );
      Assert_Equal (
         Fuzzy_Or (0.0, 1.0), 1.0,
         "should return the max of two values"
      );
      Assert_Equal (
         Fuzzy_Or (0.0, 0.0), 0.0,
         "should return the max of two values"
      );
      Assert_Equal (
         Fuzzy_Or (0.0, -1.0), 0.0,
         "should return the max of two values"
      );
      Assert_Equal (
         Fuzzy_Or (0.5, -0.5), 0.5,
         "should return the max of two values"
      );
   end Test_Or;

   --  Tests for Fuzzy_And
   procedure Test_And
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
   begin
      Assert_Equal (
         Fuzzy_And (1.0, 1.0), 1.0,
         "should return the min of two values"
      );
      Assert_Equal (
         Fuzzy_And (1.0, 0.0), 0.0,
         "should return the min of two values"
      );
      Assert_Equal (
         Fuzzy_And (0.0, 1.0), 0.0,
         "should return the min of two values"
      );
      Assert_Equal (
         Fuzzy_And (0.0, 0.0), 0.0,
         "should return the min of two values"
      );
      Assert_Equal (
         Fuzzy_And (0.0, -1.0), -1.0,
         "should return the min of two values"
      );
      Assert_Equal (
         Fuzzy_And (0.5, -0.5), -0.5,
         "should return the min of two values"
      );
   end Test_And;

   --  Tests for Fuzzy_Xor
   procedure Test_Xor
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
   begin
   --  should return the (A and not B) or (B and not A)
   --  for the values A and B
      Assert_Equal (Fuzzy_Xor (1.0, 0.0), 1.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (0.0, 1.0), 1.0, "should return xor");

      Assert_Equal (Fuzzy_Xor (1.0, 1.0), 0.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (0.75, 0.75), 0.25, "should return xor");
      Assert_Equal (Fuzzy_Xor (0.5, 0.5), 0.5, "should return xor");
      Assert_Equal (Fuzzy_Xor (0.25, 0.25), 0.25, "should return xor");
      Assert_Equal (Fuzzy_Xor (0.5, 0.0), 0.5, "should return xor");
      Assert_Equal (Fuzzy_Xor (0.0, 0.0), 0.0, "should return xor");

      Assert_Equal (Fuzzy_Xor (1.0, -1.0), 1.0, "should return xor");

      Assert_Equal (Fuzzy_Xor (-0.25, -0.1), 0.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (-0.25, -0.25), 0.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (-0.5, -0.55), 0.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (-0.75, -0.75), 0.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (-1.0, -0.1), 0.0, "should return xor");

      Assert_Equal (Fuzzy_Xor (-1.0, -1.0), 0.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (-1.0, -0.5), 0.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (0.0, -1.0), 0.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (0.5, -0.5), 0.5, "should return xor");
      Assert_Equal (Fuzzy_Xor (-0.5, -0.5), 0.0, "should return xor");

      Assert_Equal (Fuzzy_Xor (0.0, -1.0), 0.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (0.0, -0.25), 0.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (0.0, -0.5), 0.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (0.0, -0.75), 0.0, "should return xor");
      Assert_Equal (Fuzzy_Xor (0.0, -1.0), 0.0, "should return xor");

   end Test_Xor;

   --  Tests for Fuzzy_Mod
   procedure Test_Mod
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
   begin
   --  should return the (A and not B) or (B and not A)
   --  for the values A and B
      Assert_Equal (Fuzzy_Mod (0.5, 0.4), 0.5, "should truncate");
      Assert_Equal (Fuzzy_Mod (0.4, 0.4), 0.0, "should truncate");
      Assert_Equal (Fuzzy_Mod (0.3, 0.4), 0.0, "should truncate");

   end Test_Mod;

   --  Tests for Fuzzy_Rem
   procedure Test_Rem
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
   begin
   --  should return the (A and not B) or (B and not A)
   --  for the values A and B
      Assert_Equal (Fuzzy_Rem (0.5, 0.4), 1.0, "should round");
      Assert_Equal (Fuzzy_Rem (0.4, 0.4), 1.0, "should round");
      Assert_Equal (Fuzzy_Rem (0.3, 0.4), 0.3, "should round");

   end Test_Rem;

   --  Tests for Fuzzy_Difference
   procedure Test_Difference
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
   begin
   --  should return the (A and not B) or (B and not A)
   --  for the values A and B
      Assert_Equal (
         Fuzzy_Difference (0.4, 0.4), 0.0,
         "should return 0 for the same value"
      );
      Assert_Equal (
         Fuzzy_Difference (0.7, 0.4), 0.3,
         "should return difference for decreasing values"
      );
      Assert_Equal (
         Fuzzy_Difference (0.2, 0.8), 0.6,
         "should return difference for increasing values"
      );
      Assert_Equal (
         Fuzzy_Difference (0.6, -0.8), 1.0,
         "should return maximum difference of 1"
      );

   end Test_Difference;

   overriding procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Not'Access, "Fuzzy_Not");
      Register_Routine (T, Test_Un'Access, "Fuzzy_Un");
      Register_Routine (T, Test_Equals'Access, "Fuzzy_Equals");
      Register_Routine (T, Test_Or'Access, "Fuzzy_Or");
      Register_Routine (T, Test_And'Access, "Fuzzy_And");
      Register_Routine (T, Test_Xor'Access, "Fuzzy_Xor");
      Register_Routine (T, Test_Mod'Access, "Fuzzy_Mod");
      Register_Routine (T, Test_Rem'Access, "Fuzzy_Rem");
      Register_Routine (T, Test_Difference'Access, "Fuzzy_Difference");
   end Register_Tests;

   overriding function Name
     (T : Test_Case) return AUnit.Message_String
   is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Fuzzy tests");
   end Name;

end Test_Fuzzy;