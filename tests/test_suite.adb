with AUnit.Test_Suites;
with Test_Fuzzy;
with Test_Expression;
with Expression.Test_Evaluate;

package body Test_Suite is

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        AUnit.Test_Suites.New_Suite;
   begin
      Result.Add_Test (new Test_Fuzzy.Test_Case);
      Result.Add_Test (new Test_Expression.Test_Case);
      Result.Add_Test (new Expression.Test_Evaluate.Test_Case);
      return Result;
   end Suite;

end Test_Suite;
