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

   function Create_Variable_Step (Name : String) return Compiled_Step is
      (Kind => Variable_Step, Name => To_Unbounded_String (Name));

   function Create_Numeric_Step (Number : Float) return Compiled_Step is
      (Kind => Numeric_Step, Value => Number);

   function Execute_Step  (
      Step   : Compiled_Step;
      Lookup : Expression.Lookup_Function
   ) return Float;

end Expression.Steps;
