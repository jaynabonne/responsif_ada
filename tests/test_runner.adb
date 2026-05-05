with AUnit.Run;
with AUnit.Reporter.Text;
with My_Tests;

procedure Test_Runner is
   procedure Run is new AUnit.Run.Test_Runner (My_Tests.Suite);

   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Test_Runner;
