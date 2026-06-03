with Ada.Strings.Unbounded;
with Ada.Containers.Indefinite_Vectors;

private package Expression.Steps is
   use Ada.Strings.Unbounded;

   type Compiled_Step_Kind is (
      No_Step,
      Variable_Step,
      Numeric_Step,
      Unary_Not_Step,
      Unary_Un_Step,
      Unary_More_Step,
      Unary_Less_Step,
      Unary_Minus_Step,
      Unary_Plus_Step,
      Multiply_Step,
      Divide_Step,
      Mod_Step,
      Fuzzy_Mod_Step,
      Fuzzy_Rem_Step,
      Add_Step,
      Subtract_Step,
      Fuzzy_Difference_Step,
      Greater_Than_Step,
      Greater_Than_Or_Equal_Step,
      Less_Than_Step,
      Less_Than_Or_Equal_Step,
      Fuzzy_Equals_Step,
      Equals_Step,
      Not_Equals_Step,
      And_Step,
      Or_Step,
      Xor_Step
   );

   type Compiled_Step (Kind : Compiled_Step_Kind := No_Step) is record
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
      (Kind => Unary_Not_Step);

   function Create_Un_Step return Compiled_Step is
      (Kind => Unary_Un_Step);

   function Create_More_Step return Compiled_Step is
      (Kind => Unary_More_Step);

   function Create_Less_Step return Compiled_Step is
      (Kind => Unary_Less_Step);

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

   function Create_Add_Step return Compiled_Step is
      (Kind => Add_Step);

   function Create_Subtract_Step return Compiled_Step is
      (Kind => Subtract_Step);

   function Create_Fuzzy_Difference_Step return Compiled_Step is
      (Kind => Fuzzy_Difference_Step);

   function Create_Greater_Than_Step return Compiled_Step is
      (Kind => Greater_Than_Step);

   function Create_Greater_Than_Or_Equal_Step return Compiled_Step is
      (Kind => Greater_Than_Or_Equal_Step);

   function Create_Less_Than_Step return Compiled_Step is
      (Kind => Less_Than_Step);

   function Create_Less_Than_Or_Equal_Step return Compiled_Step is
      (Kind => Less_Than_Or_Equal_Step);

   function Create_Fuzzy_Equals_Step return Compiled_Step is
      (Kind => Fuzzy_Equals_Step);

   function Create_Equals_Step return Compiled_Step is
      (Kind => Equals_Step);

   function Create_Not_Equals_Step return Compiled_Step is
      (Kind => Not_Equals_Step);

   function Create_And_Step return Compiled_Step is
      (Kind => And_Step);

   function Create_Or_Step return Compiled_Step is
      (Kind => Or_Step);

   function Create_Xor_Step return Compiled_Step is
      (Kind => Xor_Step);

   package Steps_Vectors is new Ada.Containers.Indefinite_Vectors (
      Index_Type   => Positive,
      Element_Type => Compiled_Step
   );

   subtype Compiled_Steps is Steps_Vectors.Vector;

end Expression.Steps;
