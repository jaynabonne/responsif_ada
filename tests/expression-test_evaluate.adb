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

   procedure Test_Evaluate_Unary_Minus_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (5.0));
      Steps.Append (Expression.Steps.Create_Unary_Minus_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, -5.0, "should evaluate unary minus");
   end Test_Evaluate_Unary_Minus_Expression;

   procedure Test_Evaluate_Unary_Plus_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (5.0));
      Steps.Append (Expression.Steps.Create_Unary_Plus_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, 5.0, "should evaluate unary plus");
   end Test_Evaluate_Unary_Plus_Expression;

   procedure Test_Evaluate_Multiply_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (5.0));
      Steps.Append (Expression.Steps.Create_Numeric_Step (6.0));
      Steps.Append (Expression.Steps.Create_Multiply_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, 30.0, "should evaluate multiply");
   end Test_Evaluate_Multiply_Expression;

   procedure Test_Evaluate_Divide_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (30.0));
      Steps.Append (Expression.Steps.Create_Numeric_Step (6.0));
      Steps.Append (Expression.Steps.Create_Divide_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, 5.0, "should evaluate divide");
   end Test_Evaluate_Divide_Expression;

   procedure Test_Evaluate_Mod_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (12.0));
      Steps.Append (Expression.Steps.Create_Numeric_Step (5.0));
      Steps.Append (Expression.Steps.Create_Mod_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, 2.0, "should evaluate mod");
   end Test_Evaluate_Mod_Expression;

   procedure Test_Evaluate_Fuzzy_Mod_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (0.25));
      Steps.Append (Expression.Steps.Create_Numeric_Step (0.6));
      Steps.Append (Expression.Steps.Create_Fuzzy_Mod_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (
         Result, Fuzzy.Fuzzy_Mod (0.25, 0.6), "should evaluate fuzzy mod"
      );
   end Test_Evaluate_Fuzzy_Mod_Expression;

   procedure Test_Evaluate_Fuzzy_Rem_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (0.25));
      Steps.Append (Expression.Steps.Create_Numeric_Step (0.6));
      Steps.Append (Expression.Steps.Create_Fuzzy_Rem_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (
         Result, Fuzzy.Fuzzy_Rem (0.25, 0.6), "should evaluate fuzzy rem"
      );
   end Test_Evaluate_Fuzzy_Rem_Expression;

   procedure Test_Evaluate_Add_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (5.0));
      Steps.Append (Expression.Steps.Create_Numeric_Step (6.0));
      Steps.Append (Expression.Steps.Create_Add_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, 11.0, "should evaluate add");
   end Test_Evaluate_Add_Expression;

   procedure Test_Evaluate_Subtract_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (8.0));
      Steps.Append (Expression.Steps.Create_Numeric_Step (6.0));
      Steps.Append (Expression.Steps.Create_Subtract_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (Result, 2.0, "should evaluate subtract");
   end Test_Evaluate_Subtract_Expression;

   procedure Test_Evaluate_Fuzzy_Difference_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (0.7));
      Steps.Append (Expression.Steps.Create_Numeric_Step (0.4));
      Steps.Append (Expression.Steps.Create_Fuzzy_Difference_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (
         Result, Fuzzy.Fuzzy_Difference (0.7, 0.4),
         "should evaluate fuzzy difference"
      );
   end Test_Evaluate_Fuzzy_Difference_Expression;

   procedure Test_Greater_Than (Left : Float; Right : Float; Msg : String) is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (Left));
      Steps.Append (Expression.Steps.Create_Numeric_Step (Right));
      Steps.Append (Expression.Steps.Create_Greater_Than_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (
         Result, (if Left > Right then 1.0 else 0.0),
         Msg
      );
   end Test_Greater_Than;

   procedure Test_Evaluate_Greater_Than_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
   begin
      Test_Greater_Than (0.7, 0.4, "should evaluate 0.7 > 0.4");
      Test_Greater_Than (0.7, 0.7, "should evaluate 0.7 > 0.7");
      Test_Greater_Than (0.4, 0.7, "should evaluate 0.4 > 0.7");
   end Test_Evaluate_Greater_Than_Expression;

   procedure Test_Greater_Than_Or_Equal (
      Left : Float;
      Right : Float;
      Msg : String
   ) is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (Left));
      Steps.Append (Expression.Steps.Create_Numeric_Step (Right));
      Steps.Append (Expression.Steps.Create_Greater_Than_Or_Equal_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (
         Result, (if Left >= Right then 1.0 else 0.0),
         Msg
      );
   end Test_Greater_Than_Or_Equal;

   procedure Test_Evaluate_Greater_Than_Or_Equal_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
   begin
      Test_Greater_Than_Or_Equal (0.7, 0.4, "should evaluate 0.7 >= 0.4");
      Test_Greater_Than_Or_Equal (0.7, 0.7, "should evaluate 0.7 >= 0.7");
      Test_Greater_Than_Or_Equal (0.4, 0.7, "should evaluate 0.4 >= 0.7");
   end Test_Evaluate_Greater_Than_Or_Equal_Expression;

   procedure Test_Less_Than (Left : Float; Right : Float; Msg : String) is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (Left));
      Steps.Append (Expression.Steps.Create_Numeric_Step (Right));
      Steps.Append (Expression.Steps.Create_Less_Than_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (
         Result, (if Left < Right then 1.0 else 0.0),
         Msg
      );
   end Test_Less_Than;

   procedure Test_Evaluate_Less_Than_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
   begin
      Test_Less_Than (0.4, 0.7, "should evaluate 0.4 < 0.7");
      Test_Less_Than (0.7, 0.7, "should evaluate 0.7 < 0.7");
      Test_Less_Than (0.7, 0.4, "should evaluate 0.7 < 0.4");
   end Test_Evaluate_Less_Than_Expression;

   procedure Test_Less_Than_Or_Equal (
      Left : Float;
      Right : Float;
      Msg : String
   ) is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (Left));
      Steps.Append (Expression.Steps.Create_Numeric_Step (Right));
      Steps.Append (Expression.Steps.Create_Less_Than_Or_Equal_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (
         Result, (if Left <= Right then 1.0 else 0.0),
         Msg
      );
   end Test_Less_Than_Or_Equal;

   procedure Test_Evaluate_Less_Than_Or_Equal_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
   begin
      Test_Less_Than_Or_Equal (0.4, 0.7, "should evaluate 0.4 <= 0.7");
      Test_Less_Than_Or_Equal (0.7, 0.7, "should evaluate 0.7 <= 0.7");
      Test_Less_Than_Or_Equal (0.7, 0.4, "should evaluate 0.7 <= 0.4");
   end Test_Evaluate_Less_Than_Or_Equal_Expression;

   procedure Test_Fuzzy_Equals (
      Left : Float;
      Right : Float;
      Msg : String
   ) is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (Left));
      Steps.Append (Expression.Steps.Create_Numeric_Step (Right));
      Steps.Append (Expression.Steps.Create_Fuzzy_Equals_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (
         Result, Fuzzy.Fuzzy_Equals (Left, Right),
         Msg
      );
   end Test_Fuzzy_Equals;

   procedure Test_Evaluate_Fuzzy_Equals_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
   begin
      Test_Fuzzy_Equals (0.4, 0.7, "should evaluate 0.4 fuzzy equals 0.7");
      Test_Fuzzy_Equals (0.7, 0.7, "should evaluate 0.7 fuzzy equals 0.7");
      Test_Fuzzy_Equals (0.7, 0.4, "should evaluate 0.7 fuzzy equals 0.4");
   end Test_Evaluate_Fuzzy_Equals_Expression;

   procedure Test_Equals (
      Left : Float;
      Right : Float;
      Msg : String
   ) is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (Left));
      Steps.Append (Expression.Steps.Create_Numeric_Step (Right));
      Steps.Append (Expression.Steps.Create_Equals_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (
         Result, (if Left = Right then 1.0 else 0.0),
         Msg
      );
   end Test_Equals;

   procedure Test_Evaluate_Equals_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
   begin
      Test_Equals (0.4, 0.7, "should evaluate 0.4 equals 0.7");
      Test_Equals (0.7, 0.7, "should evaluate 0.7 equals 0.7");
      Test_Equals (0.7, 0.4, "should evaluate 0.7 equals 0.4");
   end Test_Evaluate_Equals_Expression;

   procedure Test_Not_Equals (
      Left : Float;
      Right : Float;
      Msg : String
   ) is
      Steps : Expression.Steps.Compiled_Steps;
      Result : Float;
   begin
      Steps.Append (Expression.Steps.Create_Numeric_Step (Left));
      Steps.Append (Expression.Steps.Create_Numeric_Step (Right));
      Steps.Append (Expression.Steps.Create_Not_Equals_Step);
      Result := Expression.Evaluate.Evaluate_Expression (
         Steps, Test_Lookup'Access
      );
      Assert_Equal (
         Result, (if Left /= Right then 1.0 else 0.0),
         Msg
      );
   end Test_Not_Equals;

   procedure Test_Evaluate_Not_Equals_Expression
     (T : in out AUnit.Test_Cases.Test_Case'Class with Unreferenced)
   is
   begin
      Test_Not_Equals (0.4, 0.7, "should evaluate 0.4 not equals 0.7");
      Test_Not_Equals (0.7, 0.7, "should evaluate 0.7 not equals 0.7");
      Test_Not_Equals (0.7, 0.4, "should evaluate 0.7 not equals 0.4");
   end Test_Evaluate_Not_Equals_Expression;

   --  -----------------
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
      Register_Routine (
         T, Test_Evaluate_Unary_Minus_Expression'Access,
         "Evaluates a compiled unary minus expression"
      );
      Register_Routine (
         T, Test_Evaluate_Unary_Plus_Expression'Access,
         "Evaluates a compiled unary plus expression"
      );
      Register_Routine (
         T, Test_Evaluate_Multiply_Expression'Access,
         "Evaluates a compiled multiply expression"
      );
      Register_Routine (
         T, Test_Evaluate_Divide_Expression'Access,
         "Evaluates a compiled divide expression"
      );
      Register_Routine (
         T, Test_Evaluate_Mod_Expression'Access,
         "Evaluates a compiled mod expression"
      );
      Register_Routine (
         T, Test_Evaluate_Fuzzy_Mod_Expression'Access,
         "Evaluates a compiled fuzzy mod expression"
      );
      Register_Routine (
         T, Test_Evaluate_Fuzzy_Rem_Expression'Access,
         "Evaluates a compiled fuzzy rem expression"
      );
      Register_Routine (
         T, Test_Evaluate_Add_Expression'Access,
         "Evaluates a compiled add expression"
      );
      Register_Routine (
         T, Test_Evaluate_Subtract_Expression'Access,
         "Evaluates a compiled subtract expression"
      );
      Register_Routine (
         T, Test_Evaluate_Fuzzy_Difference_Expression'Access,
         "Evaluates a compiled fuzzy difference expression"
      );
      Register_Routine (
         T, Test_Evaluate_Greater_Than_Expression'Access,
         "Evaluates a compiled greater than expression"
      );
      Register_Routine (
         T, Test_Evaluate_Greater_Than_Or_Equal_Expression'Access,
         "Evaluates a compiled greater than or equal expression"
      );
      Register_Routine (
         T, Test_Evaluate_Less_Than_Expression'Access,
         "Evaluates a compiled less than expression"
      );
      Register_Routine (
         T, Test_Evaluate_Less_Than_Or_Equal_Expression'Access,
         "Evaluates a compiled less than or equal expression"
      );
      Register_Routine (
         T, Test_Evaluate_Fuzzy_Equals_Expression'Access,
         "Evaluates a compiled fuzzy equals expression"
      );
      Register_Routine (
         T, Test_Evaluate_Equals_Expression'Access,
         "Evaluates a compiled equals expression"
      );
      Register_Routine (
         T, Test_Evaluate_Not_Equals_Expression'Access,
         "Evaluates a compiled not equals expression"
      );
   end Register_Tests;

   overriding function Name
     (T : Test_Case with Unreferenced) return AUnit.Message_String
   is
   begin
      return AUnit.Format ("Expression tests");
   end Name;

end Expression.Test_Evaluate;
