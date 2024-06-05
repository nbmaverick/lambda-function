resource "aws_lambda_function" "remove_unused_sg" {
  filename         = "lambda_function_payload.zip"
  function_name    = "RemoveUnusedSecurityGroups"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "app.lambda_handler"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
  runtime          = "python3.9"
}

resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name                = "lambda-schedule"
  description         = "Schedule to run Lambda function every week"
  schedule_expression = "rate(7 days)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_schedule.name
  target_id = "lambda_target"
  arn       = aws_lambda_function.remove_unused_sg.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.remove_unused_sg.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_schedule.arn
}