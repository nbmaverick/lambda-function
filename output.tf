output "lambda_function_arn" {
  value = aws_lambda_function.remove_unused_sg.arn
}