with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body Expression.Compilation is

   type Token_Type is (None, Space, Identifier, Special);

   function Is_Identifier (C : Character) return Boolean is
   begin
      return
         (C in 'A' .. 'Z') or else
         (C in 'a' .. 'z') or else
         (C in '0' .. '9') or else
         (C in '_' | '.' | '$' | ':');
   end Is_Identifier;

   function Is_Space (C : Character) return Boolean is
   begin
      return C = ' ';
   end Is_Space;

   function Type_Of (C : Character) return Token_Type is
   begin
      if Is_Space (C) then
         return Space;
      elsif Is_Identifier (C) then
         return Identifier;
      else
         return Special;
      end if;
   end Type_Of;

   function Components_Of (Source : String)
         return Component_Vectors.Vector
   is
      Result : Component_Vectors.Vector;
      Token : String (1 .. Source'Length);
      Token_Index : Natural := Token'First - 1;
      Current_Type : Token_Type := None;

      procedure Flush_Part
      is
         S : constant String := Token (Token'First .. Token_Index);
         Trimmed : constant String := Trim (S, Ada.Strings.Both);
      begin
         if Trimmed /= "" then
            Result.Append (Trimmed);
         end if;
         Token_Index := Token'First - 1;
         Current_Type := None;
      end Flush_Part;

      procedure Handle_Next(C : Character) is
         This_Type : constant Token_Type := Type_Of (C);
      begin
         if This_Type /= Current_Type then
            Flush_Part;
            Current_Type := This_Type;
         end if;
         Token_Index := Token_Index + 1;
         Token (Token_Index) := C;
      end Handle_Next;
   begin
      for Index in Source'Range loop
         Handle_Next (Source (Index));
      end loop;
      if Token_Index > 0 then
         Flush_Part;
      end if;
      return Result;
   end Components_Of;

end Expression.Compilation;
