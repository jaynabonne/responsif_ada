with Ada.Strings.Unbounded;
with Ada.Containers.Indefinite_Vectors;

private package Expression.Steps is
   use Ada.Strings.Unbounded;

   type Compiled_Step_Kind is (
      Variable_Step,
      Numeric_Step,
      Not_Step,
      Un_Step,
      More_Step,
      Less_Step,
      Unary_Minus_Step,
      Unary_Plus_Step,
      Multiply_Step,
      Divide_Step,
      Mod_Step,
      Fuzzy_Mod_Step,
      Fuzzy_Rem_Step
   );

   type Compiled_Step (Kind : Compiled_Step_Kind) is record
      case Kind is
         when Variable_Step =>
            Name : Unbounded_String := Null_Unbounded_String;
         when Numeric_Step =>
            Value : Float := 0.0;
         when others => null;
      end case;
   end record;

   function Create_Variable_Step (Name : String) return Compiled_Step is
      (Kind => Variable_Step, Name => To_Unbounded_String (Name));

   function Create_Numeric_Step (Number : Float) return Compiled_Step is
      (Kind => Numeric_Step, Value => Number);

   function Create_Not_Step return Compiled_Step is
      (Kind => Not_Step);

   function Create_Un_Step return Compiled_Step is
      (Kind => Un_Step);

   function Create_More_Step return Compiled_Step is
      (Kind => More_Step);

   function Create_Less_Step return Compiled_Step is
      (Kind => Less_Step);

   function Create_Unary_Minus_Step return Compiled_Step is
      (Kind => Unary_Minus_Step);

   function Create_Unary_Plus_Step return Compiled_Step is
      (Kind => Unary_Plus_Step);

   function Create_Multiply_Step return Compiled_Step is
      (Kind => Multiply_Step);

   function Create_Divide_Step return Compiled_Step is
      (Kind => Divide_Step);

   function Create_Mod_Step return Compiled_Step is
      (Kind => Mod_Step);

   function Create_Fuzzy_Mod_Step return Compiled_Step is
      (Kind => Fuzzy_Mod_Step);

   function Create_Fuzzy_Rem_Step return Compiled_Step is
      (Kind => Fuzzy_Rem_Step);

   package Steps_Vectors is new Ada.Containers.Indefinite_Vectors (
      Index_Type   => Positive,
      Element_Type => Compiled_Step
   );

   subtype Compiled_Steps is Steps_Vectors.Vector;

end Expression.Steps;
