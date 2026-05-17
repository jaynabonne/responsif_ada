with Expression.Steps; use Expression.Steps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;

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
