# Create an SQS queue
resource "aws_sqs_queue" "my_queue" {
  name = "s3-event-notification-queue"
}


# Allow SNS to send messages to SQS
resource "aws_sqs_queue_policy" "my_sqs_policy" {
  queue_url = aws_sqs_queue.my_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Allow-SNS-SendMessage"
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = aws_sqs_queue.my_queue.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.my_topic.arn
          }
        }
      }
    ]
  })
}