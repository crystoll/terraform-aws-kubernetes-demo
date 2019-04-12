#
# Workstation External IP
#
# This configuration is not required and is
# only provided as an example to easily fetch
# the external IP of your local workstation to
# configure inbound EC2 Security Group access
# to the Kubernetes cluster.
#

data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

# Override with variable or hardcoded value if necessary
locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}

# OPTIONAL: Allow inbound traffic from your local workstation external IP
#           to the Kubernetes. You will need to replace A.B.C.D below with
#           your real IP. Services like icanhazip.com can help you find this.
//resource "aws_security_group_rule" "demo-cluster-ingress-workstation-https" {
//  cidr_blocks       = ["${local.workstation-external-cidr}"]
//  description       = "Allow workstation to communicate with the cluster API Server"
//  from_port         = 443
//  protocol          = "tcp"
//  security_group_id = "${aws_security_group.cluster.id}"
//  to_port           = 443
//  type              = "ingress"
//}