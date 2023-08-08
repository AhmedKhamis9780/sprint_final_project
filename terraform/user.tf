resource "aws_iam_user" "jenkins_user" {

  name = "jenkins_user"

}

resource "aws_iam_access_key" "AccK" {

  user = aws_iam_user.jenkins_user.name

    provisioner "local-exec" {
        command= "( echo [default] ; echo aws_access_key_id = $AWS_ID ; echo aws_secret_access_key = $AWS_SECRET ) >Credit.txt"
        environment = {
            AWS_ID = "${self.id}"
            AWS_SECRET = "${self.secret}"
        }
    }
}

resource "aws_iam_user_policy" "iam" {

  name = "ListBuckets"

  user = aws_iam_user.jenkins_user.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF

}