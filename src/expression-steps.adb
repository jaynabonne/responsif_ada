package body Expression.Steps is

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
end Expression.Steps;
