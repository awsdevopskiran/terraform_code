resource "aws_iam_role" "terrafrom_role" {
  name = "terrafrom_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
    name        = "test-policy"
    description = "A test policy"
  
    policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:*",
          "s3-object-lambda:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
  }


resource "aws_iam_role_policy_attachment" "role_attachement" {
  role       = aws_iam_role.terrafrom_role.name
  policy_arn = aws_iam_policy.terraform_ec2_read_policy.arn
}

resource "aws_iam_instance_profile" "terraform_role_ec2_attachment" {
  name = "terraform_role_ec2_attachment"
  role = aws_iam_role.terrafrom_role.name
}


#enter iam instance profile in compute.tf file
