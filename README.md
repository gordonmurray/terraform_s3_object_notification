# S3 Event Notification System with SNS and SQS

## Project Overview

This Terraform project sets up a robust event notification system using AWS services. It's designed to capture S3 bucket events, publish them to SNS, and then route them to SQS for further processing.

## Key Components

- S3 Bucket: Source of events (e.g., file uploads)
- SNS Topic: Publishes S3 events
- SQS Queue: Receives events from SNS for processing

## Usage

1. Clone the repository
2. Update the Terraform variables as needed
3. Run `terraform init`, `terraform plan`, and `terraform apply`

This project provides a scalable and observable foundation for event-driven architectures on AWS.

### Diagram

```
graph TD
    A[S3 Bucket] -->|Object Created Event| B[SNS Topic]
    B -->|Notification| C[SQS Queue]
    C -->|Process Message| D[Your Application]
    D -->|Log Event| E[CloudWatch Logs]

    style A fill:#ff9900,stroke:#232F3E,stroke-width:2px
    style B fill:#ff4f8b,stroke:#232F3E,stroke-width:2px
    style C fill:#ff9900,stroke:#232F3E,stroke-width:2px
    style D fill:#232F3E,stroke:#232F3E,stroke-width:2px,color:#ffffff
    style E fill:#6bab6b,stroke:#232F3E,stroke-width:2px
```


### Estimated cost

Assuming 100 files uploaded per day for a month

```
Project: main

 Name                                                 Monthly Qty  Unit                        Monthly Cost

 aws_cloudwatch_log_group.my_log_group
 ├─ Data ingested                             Monthly cost depends on usage: $0.57 per GB
 ├─ Archival Storage                          Monthly cost depends on usage: $0.03 per GB
 └─ Insights queries data scanned             Monthly cost depends on usage: $0.0057 per GB

 aws_s3_bucket.my_bucket
 └─ Standard
    ├─ Storage                                Monthly cost depends on usage: $0.023 per GB
    ├─ PUT, COPY, POST, LIST requests         Monthly cost depends on usage: $0.005 per 1k requests
    ├─ GET, SELECT, and all other requests    Monthly cost depends on usage: $0.0004 per 1k requests
    ├─ Select data scanned                    Monthly cost depends on usage: $0.002 per GB
    └─ Select data returned                   Monthly cost depends on usage: $0.0007 per GB

 aws_sns_topic.my_topic
 ├─ API requests (over 1M)                    Monthly cost depends on usage: $0.50 per 1M requests
 ├─ HTTP/HTTPS notifications (over 100k)      Monthly cost depends on usage: $0.06 per 100k notifications
 ├─ Email/Email-JSON notifications (over 1k)  Monthly cost depends on usage: $2.00 per 100k notifications
 ├─ Kinesis Firehose notifications            Monthly cost depends on usage: $0.19 per 1M notifications
 ├─ Mobile Push notifications                 Monthly cost depends on usage: $0.50 per 1M notifications
 ├─ MacOS notifications                       Monthly cost depends on usage: $0.50 per 1M notifications
 └─ SMS notifications (over 100)              Monthly cost depends on usage: $0.75 per 100 notifications

 aws_sqs_queue.my_queue
 └─ Requests                                  Monthly cost depends on usage: $0.40 per 1M requests

 OVERALL TOTAL                                                                                       $0.00

*Usage costs were estimated using infracost-usage.yml, see docs for other options.

──────────────────────────────────
9 cloud resources were detected:
∙ 4 were estimated
∙ 5 were free

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━┓
┃ Project                                            ┃ Baseline cost ┃ Usage cost* ┃ Total cost ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━╋━━━━━━━━━━━━┫
┃ main                                               ┃         $0.00 ┃       $0.00 ┃      $0.00 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━┛
```