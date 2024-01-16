# resource "aws_s3_bucket" "mybucket" {
#   bucket =  = "aws-wp-demo415"
#   versioning {
#       enabled = true
#   }
#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }
# }

# resource "aws_dynamodb_table" "statelock" {
#   name             = "state-lock"
#   hash_key         = "LockID"
#   billing_mode     = "PAY_PER_REQUEST"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }