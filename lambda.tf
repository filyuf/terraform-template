#get
data "archive_file" "lambda_get" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/lks_get"
  output_path = "${path.module}/lambda/lks_get.zip"
}

resource "aws_lambda_function" "get_lambda" {
  function_name    = "lks-get"
  filename         = "${path.module}/lambda/lks_get.zip"
  source_code_hash = data.archive_file.lambda_get.output_base64sha256
  handler          = "index.handler"
  runtime          = "python3.13"
  role             = "arn:aws:iam::891376950962:role/LabRole"

  environment {
    variables = {
      DB_HOST     = "crud.c9que2kyccgm.us-east-1.rds.amazonaws.com"
      DB_USER     = "admin"
      DB_PASSWORD = "admin123"
      DB_NAME     = "crud"
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id]
    security_group_ids = [aws_security_group.sgapps.id]
  }
}


#lks-get-id
data "archive_file" "lambda_get_id" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/lks_get_id"
  output_path = "${path.module}/lambda/lks_get_id.zip"
}

resource "aws_lambda_function" "get_id_lambda" {
  function_name    = "lks-get-id"
  filename         = "${path.module}/lambda/lks_get_id.zip"
  source_code_hash = data.archive_file.lambda_get_id.output_base64sha256
  handler          = "index.handler"
  runtime          = "python3.13"
  role             = "arn:aws:iam::891376950962:role/LabRole"

  environment {
    variables = {
      DB_HOST     = "crud.c9que2kyccgm.us-east-1.rds.amazonaws.com"
      DB_USER     = "admin"
      DB_PASSWORD = "admin123"
      DB_NAME     = "crud"
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id]
    security_group_ids = [aws_security_group.sgapps.id]
  }
}

#lks-delete
data "archive_file" "lambda_delete" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/lks_delete"
  output_path = "${path.module}/lambda/lks_delete.zip"
}

resource "aws_lambda_function" "delete_lambda" {
  function_name    = "lks-delete"
  filename         = "${path.module}/lambda/lks_delete.zip"
  source_code_hash = data.archive_file.lambda_delete.output_base64sha256
  handler          = "index.handler"
  runtime          = "python3.13"
  role             = "arn:aws:iam::891376950962:role/LabRole"

  environment {
    variables = {
      DB_HOST     = "crud.c9que2kyccgm.us-east-1.rds.amazonaws.com"
      DB_USER     = "admin"
      DB_PASSWORD = "admin123"
      DB_NAME     = "crud"
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id]
    security_group_ids = [aws_security_group.sgapps.id]
  }
}

#lks-put
data "archive_file" "lambda_put" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/lks_put"
  output_path = "${path.module}/lambda/lks_put.zip"
}

resource "aws_lambda_function" "put_lambda" {
  function_name    = "lks-put"
  filename         = "${path.module}/lambda/lks_put.zip"
  source_code_hash = data.archive_file.lambda_put.output_base64sha256
  handler          = "index.handler"
  runtime          = "python3.13"
  role             = "arn:aws:iam::891376950962:role/LabRole"

  environment {
    variables = {
      DB_HOST     = "crud.c9que2kyccgm.us-east-1.rds.amazonaws.com"
      DB_USER     = "admin"
      DB_PASSWORD = "admin123"
      DB_NAME     = "crud"
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id]
    security_group_ids = [aws_security_group.sgapps.id]
  }
}

#lks-post
data "archive_file" "lambda_post" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/lks_post"
  output_path = "${path.module}/lambda/lks_post.zip"
}

resource "aws_lambda_function" "post_lambda" {
  function_name    = "lks-post"
  filename         = "${path.module}/lambda/lks_post.zip"
  source_code_hash = data.archive_file.lambda_post.output_base64sha256
  handler          = "index.handler"
  runtime          = "python3.13"
  role             = "arn:aws:iam::891376950962:role/LabRole"

  environment {
    variables = {
      DB_HOST     = "crud.c9que2kyccgm.us-east-1.rds.amazonaws.com"
      DB_USER     = "admin"
      DB_PASSWORD = "admin123"
      DB_NAME     = "crud"
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1b.id]
    security_group_ids = [aws_security_group.sgapps.id]
  }
}

