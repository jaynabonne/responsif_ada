with AUnit.Test_Suites;
with Test_Topics;

package body My_Tests is

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        AUnit.Test_Suites.New_Suite;
   begin
      Result.Add_Test (new Test_Topics.Test_Case);

      return Result;
   end Suite;

end My_Tests;
