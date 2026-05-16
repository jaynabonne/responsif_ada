with Ada.Strings.Unbounded;

private package Expression.Steps is
   use Ada.Strings.Unbounded;

   type Compiled_Step_Kind is (
      Variable_Step,
      Numeric_Step
   );

   type Compiled_Step (Kind : Compiled_Step_Kind) is record
      case Kind is
         when Variable_Step =>
            Name : Unbounded_String := Null_Unbounded_String;
         when Numeric_Step =>
            Value : Float := 0.0;
      end case;
   end record;

end Expression.Steps;
