with AUnit.Assertions; use AUnit.Assertions;
with AUnit.Test_Cases; use AUnit.Test_Cases;
with Test_Helpers; use Test_Helpers;
with Test_Generics; use Test_Generics;

with Expression.Compilation; use Expression.Compilation;

package body Expression.Test_Compilation is
   procedure Assert_Equal is new Test_Generics.Generic_Assert_Equal
     (T     => Component_Vectors.Vector,
      Image => Component_Vectors.Vector'Image,
      Equal =>  Component_Vectors."=");

   procedure Test_Empty_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Actual : constant Component_Vectors.Vector :=
         Components_Of ("");
      Expected : constant Component_Vectors.Vector :=
         Component_Vectors.Empty_Vector;
   begin
      Assert_Equal (Actual, Expected, "should be empty");
   end Test_Empty_Expression;

   procedure Test_Identifier_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Actual : constant Component_Vectors.Vector :=
         Components_Of ("var1");
      Expected : constant Component_Vectors.Vector := ["var1"];
   begin
      Assert_Equal (Actual, Expected, "should contain the identifier");
   end Test_Identifier_Expression;

   procedure Test_Identifier_Expression_With_Whitespace
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Actual : constant Component_Vectors.Vector :=
         Components_Of (" var1 ");
      Expected : constant Component_Vectors.Vector := ["var1"];
   begin
      Assert_Equal (Actual, Expected, "should contain the identifier");
   end Test_Identifier_Expression_With_Whitespace;

   procedure Test_Expression_With_Unary_Operator
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Actual : constant Component_Vectors.Vector :=
         Components_Of ("not var1 ");
      Expected : constant Component_Vectors.Vector := ["not", "var1"];
   begin
      Assert_Equal (Actual, Expected, "should contain the unary operator and identifier");
   end Test_Expression_With_Unary_Operator;

   procedure Test_Expression_With_Binary_Operator
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Actual : constant Component_Vectors.Vector :=
         Components_Of ("var1+var2 ");
      Expected : constant Component_Vectors.Vector := ["var1", "+", "var2"];
   begin
      Assert_Equal (Actual, Expected, "should contain the binary operator and identifiers");
   end Test_Expression_With_Binary_Operator;

   --  ---------------------------------------------------------------------

   overriding procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (
         T, Test_Empty_Expression'Access,
         "Test splitting an empty expression"
      );
      Register_Routine (
         T, Test_Identifier_Expression'Access,
         "Test splitting an identifier"
      );
      Register_Routine (
         T, Test_Identifier_Expression_With_Whitespace'Access,
         "Test splitting an identifier with whitespace"
      );
      Register_Routine (
         T, Test_Expression_With_Unary_Operator'Access,
         "Test splitting an expression with a unary operator"
      );
      Register_Routine (
         T, Test_Expression_With_Binary_Operator'Access,
         "Test splitting an expression with a binary operator"
      );
   end Register_Tests;

   overriding function Name
     (T : Test_Case with Unreferenced) return AUnit.Message_String
   is
   begin
      return AUnit.Format ("Expression compilation tests");
   end Name;

end Expression.Test_Compilation;
