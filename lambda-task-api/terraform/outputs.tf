output "api_url" {
  value = aws_apigatewayv2_api.http_api.api_endpoint
}

output "tasks_table_name" {
  value = aws_dynamodb_table.tasks.name
}
