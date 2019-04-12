resource "aws_iam_role" "eks-role" {
  name = "${var.app_name}-eks-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "default-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.eks-role.name}"
}

resource "aws_iam_role_policy_attachment" "default-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.eks-role.name}"
}


# Security group to control networking access to Kubernetes masters

resource "aws_security_group" "cluster" {
  name        = "${var.cluster-name}"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.default.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}"
  }
}


resource "aws_eks_cluster" "default" {
  name            = "${var.cluster-name}"
  role_arn        = "${aws_iam_role.eks-role.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.cluster.id}"]
    subnet_ids = ["${aws_subnet.public.*.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.default-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.default-AmazonEKSServicePolicy",
  ]
}



