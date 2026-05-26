with AUnit.Run;
with AUnit.Reporter.Text;
with Test_Suite;

procedure Test_Runner is
   procedure Run is new AUnit.Run.Test_Runner (Test_Suite.Suite);

   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Test_Runner;
