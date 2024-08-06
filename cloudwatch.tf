# Create a CloudWatch log group
resource "aws_cloudwatch_log_group" "my_log_group" {
  name              = "/aws/s3/my-bucket-logs"
  retention_in_days = 14 # Adjust retention period as needed
}

# Create a CloudWatch Log Group for SNS delivery status logging
resource "aws_cloudwatch_log_group" "sns_delivery_status" {
  name              = "/aws/sns/${aws_sns_topic.my_topic.name}/delivery-status"
  retention_in_days = 14 # Adjust as needed
}
