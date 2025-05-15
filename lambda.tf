data "archive_file" "lambda_get" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/folder_lambda_get" #adjust it to your path
  output_path = "${path.module}/lambda/folder_lambda_get.zip"
}

resource "aws_lambda_function" "lambda_get" {
  function_name    = "lks-get"
  filename         = "${path.module}/lambda/folder_lambda_get.zip"
  source_code_hash = data.archive_file.lambda_get.output_base64sha256
  handler          = "index.handler"
  runtime          = "python3.13"
  role             = "arn:aws:iam::YOUR_ACCOUNT_ID:role/YOUR_ROLE_NAME"

  environment {
    variables = {
      DB_HOST     = "your_endpoint_db"
      DB_USER     = "your_username"
      DB_PASSWORD = "your_password"
      DB_NAME     = "your_database"
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id]
    security_group_ids = [aws_security_group.your_sg.id]
  }
}
