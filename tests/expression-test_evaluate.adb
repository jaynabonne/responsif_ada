with AUnit.Test_Cases; use AUnit.Test_Cases;
with Test_Helpers; use Test_Helpers;

with Expression.Evaluate; use Expression.Evaluate;
with Expression.Steps; use Expression.Steps;
with Fuzzy; use Fuzzy;

package body Expression.Test_Evaluate is

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

   procedure Test_Evaluate_Variable_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Variable_Step ("var1"));
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, 10.0, "should evaluate to 10.0");
   end Test_Evaluate_Variable_Expression;

   procedure Test_Evaluate_Numeric_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (314.0));
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, 314.0, "should evaluate to 314.0");
   end Test_Evaluate_Numeric_Expression;

   procedure Test_Evaluate_Not_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (0.0));
      Steps.Append (Expression.Steps.Create_Not_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, Fuzzy_Not (0.0), "should evaluate fuzzy not");
   end Test_Evaluate_Not_Expression;

   procedure Test_Evaluate_Un_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (0.5));
      Steps.Append (Expression.Steps.Create_Un_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, Fuzzy_Un (0.5), "should evaluate fuzzy un");
   end Test_Evaluate_Un_Expression;

   procedure Test_Evaluate_More_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (0.5));
      Steps.Append (Expression.Steps.Create_More_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, Fuzzy_More (0.5), "should evaluate fuzzy more");
   end Test_Evaluate_More_Expression;

   procedure Test_Evaluate_Less_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (0.5));
      Steps.Append (Expression.Steps.Create_Less_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, Fuzzy_Less (0.5), "should evaluate fuzzy less");
   end Test_Evaluate_Less_Expression;

   overriding procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (
         T, Test_Evaluate_Variable_Expression'Access,
         "Evaluates a compiled variable expression"
      );
      Register_Routine (
         T, Test_Evaluate_Numeric_Expression'Access,
         "Evaluates a compiled numeric expression"
      );
      Register_Routine (
         T, Test_Evaluate_Not_Expression'Access,
         "Evaluates a compiled not expression"
      );
      Register_Routine (
         T, Test_Evaluate_Un_Expression'Access,
         "Evaluates a compiled un expression"
      );
      Register_Routine (
         T, Test_Evaluate_More_Expression'Access,
         "Evaluates a compiled more expression"
      );
      Register_Routine (
         T, Test_Evaluate_Less_Expression'Access,
         "Evaluates a compiled less expression"
      );

   end Register_Tests;

   overriding function Name
     (T : Test_Case with Unreferenced) return AUnit.Message_String
   is
   begin
      return AUnit.Format ("Expression tests");
   end Name;

end Expression.Test_Evaluate;
