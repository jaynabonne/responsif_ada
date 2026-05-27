with Expression.Steps;

private package Expression.Evaluation is

   function Evaluate_Expression  (
      Steps : Expression.Steps.Compiled_Steps;
      Lookup : Expression.Lookup_Function
   ) return Float;

end Expression.Evaluation;
