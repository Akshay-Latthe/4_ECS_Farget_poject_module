
# Define the AWS IAM policies
resource "aws_iam_policy" "policy1" {
  name        = var.policy1_name
  description = "Permissions for ECR and CloudWatch Logs"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_policy" "policy2" {
  name        = var.policy2_name 
  description = "Permissions for Amazon EFS"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "elasticfilesystem:DescribeAccessPoints",
          "elasticfilesystem:CreateAccessPoint",
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
        ],
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_policy" "policy3" {
  name        = var.policy3_name
  description = "Permissions for AWS Secrets Manager and KMS"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "VisualEditor0",
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "kms:Decrypt",
        ],
        Resource = "arn:aws:secretsmanager:us-east-1:${data.aws_caller_identity.current.account_id}:secret:*",
      },
    ],
  })
}

resource "aws_iam_policy" "policy4" {
  name        =  var.policy4_name
  description = "Permissions for AWS SSM Messages"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel",
        ],
        Resource = "*",
      },
    ],
  })
}

# Define the IAM role
resource "aws_iam_role" "ecs_task_role" {
  name =  var.ecs_task_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com",
        },
      },
    ],
  })
}

# Attach policies to the IAM role
resource "aws_iam_role_policy_attachment" "attach-policy1" {
  policy_arn = aws_iam_policy.policy1.arn
  role       = aws_iam_role.ecs_task_role.name
}

resource "aws_iam_role_policy_attachment" "attach-policy2" {
  policy_arn = aws_iam_policy.policy2.arn
  role       = aws_iam_role.ecs_task_role.name
}

resource "aws_iam_role_policy_attachment" "attach-policy3" {
  policy_arn = aws_iam_policy.policy3.arn
  role       = aws_iam_role.ecs_task_role.name
}

resource "aws_iam_role_policy_attachment" "attach-policy4" {
  policy_arn = aws_iam_policy.policy4.arn
  role       = aws_iam_role.ecs_task_role.name
}

## Reference links
##https://medium.com/@bradford_hamilton/deploying-containers-on-amazons-ecs-using-fargate-and-terraform-part-2-2e6f6a3a957f
# # =====================================================Secret Manager Policy ==================================
# ### AWS ROLE FOR cloudwatch_full_access_role ECS clutser  
# # https://docs.aws.amazon.com/mediaconnect/latest/ug/iam-policy-examples-asm-secrets.html

# # === ECS Execute Policy ========================================================================
# # This policy grants permission for executing ECS commands.
# # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html

# # aws ecs fargate can't fetch secret manager  ====================================================
# # https://stackoverflow.com/questions/55568371/aws-ecs-fargate-cant-fetch-secret-manager
# # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/secrets-app-secrets-manager.html

# # === EFS Access Policy ===
# # This policy allows access to Elastic File System (EFS).
# # https://docs.aws.amazon.com/efs/latest/ug/accessing-fs-create-access-point.html
#ECS Logging with Cloudwatch ########################################################
# 1 Attach Policy
#  https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-using-import-tool-cli-cloudwatch-iam-role.html
