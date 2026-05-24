with Expression.Steps; use Expression.Steps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;

with Fuzzy; use Fuzzy;

package body Expression.Evaluate is
   package Stack_Containers is new Ada.Containers.Vectors (
      Index_Type   => Natural,
      Element_Type => Float
   );

   subtype Evaluation_Stack is Stack_Containers.Vector;

   procedure Execute_Step  (
      Step   : Compiled_Step;
      Lookup : Expression.Lookup_Function;
      Stack  : in out Evaluation_Stack
   ) is
      function Pop (S : in out Evaluation_Stack) return Float is
         Top : constant Float := S (S.Last);
      begin
         S.Delete_Last;
         return Top;
      end Pop;

   begin
      case Step.Kind is
         when Variable_Step =>
            declare
               Variable : constant String := To_String (Step.Name);
               Result : constant Lookup_Result := Lookup.all (Variable);
            begin
               if Result.Found then
                  Stack.Append (Result.Value);
               else
                  raise Program_Error with "Variable not found: " & Variable;
               end if;
            end;
         when Numeric_Step => Stack.Append (Step.Value);
         when Not_Step =>
            Stack.Append (Fuzzy_Not (Pop (Stack)));
         when Un_Step =>
            Stack.Append (Fuzzy_Un (Pop (Stack)));
         when More_Step =>
            Stack.Append (Fuzzy_More (Pop (Stack)));
         when Less_Step =>
            Stack.Append (Fuzzy_Less (Pop (Stack)));
         when Unary_Minus_Step =>
            Stack.Append (-Pop (Stack));
         when Unary_Plus_Step =>
            Stack.Append (Pop (Stack));
         when Multiply_Step =>
               declare
                  Right : constant Float := Pop (Stack);
                  Left : constant Float := Pop (Stack);
               begin
                  Stack.Append (Left * Right);
               end;
         when Divide_Step =>
               declare
                  Right : constant Float := Pop (Stack);
                  Left : constant Float := Pop (Stack);
               begin
                  if Right = 0.0 then
                     raise Program_Error with "Division by zero in Divide";
                  end if;
                  Stack.Append (Left / Right);
               end;
         when Mod_Step =>
               declare
                  Right : constant Float := Pop (Stack);
                  Left : constant Float := Pop (Stack);
               begin
                  if Right = 0.0 then
                     raise Program_Error with "Division by zero in Mod";
                  end if;
                  Stack.Append (Left - Right * Float'Floor (Left / Right));
               end;
         when Fuzzy_Mod_Step =>
               declare
                  Right : constant Float := Pop (Stack);
                  Left : constant Float := Pop (Stack);
               begin
                  Stack.Append (Fuzzy.Fuzzy_Mod (Left, Right));
               end;
         when Fuzzy_Rem_Step =>
               declare
                  Right : constant Float := Pop (Stack);
                  Left : constant Float := Pop (Stack);
               begin
                  Stack.Append (Fuzzy.Fuzzy_Rem (Left, Right));
               end;
         when Add_Step =>
               declare
                  Right : constant Float := Pop (Stack);
                  Left : constant Float := Pop (Stack);
               begin
                  Stack.Append (Left + Right);
               end;
         when Subtract_Step =>
               declare
                  Right : constant Float := Pop (Stack);
                  Left : constant Float := Pop (Stack);
               begin
                  Stack.Append (Left - Right);
               end;
         when Fuzzy_Difference_Step =>
               declare
                  Right : constant Float := Pop (Stack);
                  Left : constant Float := Pop (Stack);
               begin
                  Stack.Append (Fuzzy.Fuzzy_Difference (Left, Right));
               end;
         when Greater_Than_Step =>
               declare
                  Right : constant Float := Pop (Stack);
                  Left : constant Float := Pop (Stack);
               begin
                  Stack.Append (if Left > Right then 1.0 else 0.0);
               end;
         when Greater_Than_Or_Equal_Step =>
               declare
                  Right : constant Float := Pop (Stack);
                  Left : constant Float := Pop (Stack);
               begin
                  Stack.Append (if Left >= Right then 1.0 else 0.0);
               end;
         when Less_Than_Step =>
               declare
                  Right : constant Float := Pop (Stack);
                  Left : constant Float := Pop (Stack);
               begin
                  Stack.Append (if Left < Right then 1.0 else 0.0);
               end;
         when Less_Than_Or_Equal_Step =>
               declare
                  Right : constant Float := Pop (Stack);
                  Left : constant Float := Pop (Stack);
               begin
                  Stack.Append (if Left <= Right then 1.0 else 0.0);
               end;
         when others =>
            Stack.Append (-1.0);
      end case;
   end Execute_Step;

   function Evaluate_Expression  (
      Steps : Expression.Steps.Compiled_Steps;
      Lookup : Expression.Lookup_Function
   ) return Float is
      Stack : Evaluation_Stack := Stack_Containers.Empty_Vector;
   begin
      if Steps.Length = 0 then
         raise Program_Error with "No steps to evaluate";
      end if;
      for Step of Steps loop
         Execute_Step (Step, Lookup => Lookup, Stack => Stack);
      end loop;
      return Stack (Stack.Last);
   end Evaluate_Expression;

end Expression.Evaluate;
