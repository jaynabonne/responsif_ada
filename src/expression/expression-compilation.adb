with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Expression.Compilation is

   type Token_Type is (None, Space, Identifier, Special);

   function Is_Identifier (C : Character) return Boolean is
      ((C in 'A' .. 'Z') or else
         (C in 'a' .. 'z') or else
         (C in '0' .. '9') or else
         (C in '_' | '.' | '$' | ':'));

   function Is_Space (C : Character) return Boolean is
      (C = ' ');

   function Type_Of (C : Character) return Token_Type is
   (
      if Is_Space (C) then
         Space
      elsif Is_Identifier (C) then
         Identifier
      else
          Special
   );

   function Components_Of (Source : String)
         return Component_Vectors.Vector is

      Result : Component_Vectors.Vector;
      Token : Unbounded_String;
      Current_Type : Token_Type := None;

      procedure Flush_Part is
         S : constant String := To_String (Token);
         Trimmed : constant String := Trim (S, Ada.Strings.Both);
      begin
         if Trimmed /= "" then
            Result.Append (Trimmed);
         end if;
         Current_Type := None;
         Token := Null_Unbounded_String;
      end Flush_Part;

      procedure Handle_Next (C : Character) is
         This_Type : constant Token_Type := Type_Of (C);
      begin
         if This_Type /= Current_Type then
            Flush_Part;
            Current_Type := This_Type;
         end if;
         Append (Token, C);
      end Handle_Next;

   begin
      for Index in Source'Range loop
         Handle_Next (Source (Index));
      end loop;
      Flush_Part;
      return Result;
   end Components_Of;

end Expression.Compilation;
