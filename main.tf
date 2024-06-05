# # Lambda function
# resource "aws_lambda_function" "my_lambda_function" {
#   filename         = "lambda_function_payload.zip"
#   function_name    = "MyLambdaFunction"
#   role             = aws_iam_role.lambda_exec_role.arn
#   handler          = "app.lambda_handler"
#   source_code_hash = filebase64sha256("lambda_function_payload.zip")
#   runtime          = "python3.9"
# }

# # Test event for the Lambda function
# resource "aws_lambda_event_source_mapping" "test_event_mapping" {
#   event_source_arn  = aws_lambda_function.my_lambda_function.arn
#   function_name     = aws_lambda_function.my_lambda_function.function_name
#   enabled           = true
# }

# # Test event payload
# resource "aws_cloudwatch_event_rule" "test_event_rule" {
#   name                = "test-event-rule"
#   description         = "Test event rule for Lambda function"
#   schedule_expression = "cron(0 12 * * ? *)" # Runs every day at 12:00 UTC
# }

# resource "aws_cloudwatch_event_target" "test_event_target" {
#   rule      = aws_cloudwatch_event_rule.test_event_rule.name
#   target_id = "test-event-target"
#   arn       = aws_lambda_function.my_lambda_function.arn
# }

# Permission for CloudWatch Events to invoke the Lambda function
# resource "aws_lambda_permission" "allow_test_cloudwatch" {
#   statement_id  = "AllowExecutionFromCloudWatchForTest"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.my_lambda_function.function_name
#   principal     = "events.amazonaws.com"
#   source_arn    = aws_cloudwatch_event_rule.test_event_rule.arn
# }


