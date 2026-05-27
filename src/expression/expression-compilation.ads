with Ada.Containers.Indefinite_Vectors;

private package Expression.Compilation is

   package Component_Vectors is new Ada.Containers.Indefinite_Vectors
   (Index_Type   => Positive,
      Element_Type => String);

   function Components_Of (Source : String)
         return Component_Vectors.Vector;

end Expression.Compilation;
