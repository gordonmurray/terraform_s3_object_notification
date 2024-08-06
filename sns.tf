

# Create an SNS topic
resource "aws_sns_topic" "my_topic" {
  name           = "s3-event-notification-topic"
  tracing_config = "Active"


  delivery_policy = jsonencode({
    http = {
      defaultHealthyRetryPolicy = {
        minDelayTarget     = 20
        maxDelayTarget     = 20
        numRetries         = 3
        numMaxDelayRetries = 0
        numNoDelayRetries  = 0
        numMinDelayRetries = 0
        backoffFunction    = "linear"
      }
      disableSubscriptionOverrides = false
    }
  })

}

# Subscribe SQS to SNS
resource "aws_sns_topic_subscription" "sns_to_sqs" {
  topic_arn = aws_sns_topic.my_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.my_queue.arn
}

# SNS topic policy
resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.my_topic.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowS3ToPublishToSNS"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action   = "sns:Publish"
        Resource = aws_sns_topic.my_topic.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = aws_s3_bucket.my_bucket.arn
          }
        }
      },
      {
        Sid    = "AllowSNSToWriteToCloudWatchLogs"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.sns_delivery_status_role.arn
        }
        Action = [
          "sns:Publish",
          "sns:GetTopicAttributes"
        ]
        Resource = aws_sns_topic.my_topic.arn
      }
    ]
  })
}