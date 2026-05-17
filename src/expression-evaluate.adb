with Expression.Steps; use Expression.Steps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers; use Ada.Containers;

package body Expression.Evaluate is
   function Execute_Step  (
      Step   : Compiled_Step;
      Lookup : Expression.Lookup_Function
   ) return Float is
   begin
      case Step.Kind is
         when Variable_Step =>
            declare
               Variable : constant String := To_String (Step.Name);
               Result : constant Lookup_Result := Lookup.all (Variable);
            begin
               if Result.Found then
                  return Result.Value;
               else
                  raise Program_Error with "Variable not found: " & Variable;
               end if;
            end;
         when Numeric_Step =>
            return Step.Value;
      end case;
   end Execute_Step;

   function Evaluate_Expression  (
      Steps : Expression.Steps.Compiled_Steps;
      Lookup : Expression.Lookup_Function
   ) return Float is
   begin
      if Steps.Length = 0 then
         raise Program_Error with "No steps to evaluate";
      end if;
      return Execute_Step (Steps (1), Lookup => Lookup);
   end Evaluate_Expression;

end Expression.Evaluate;
