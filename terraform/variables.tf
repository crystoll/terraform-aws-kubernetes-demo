variable "aws_region" {}

variable "aws_shared_credentials_file" {}

variable "aws_profile" {}

variable "k8s-version" {
  default     = "1.11"
  type        = "string"
  description = "Required K8s version"
}

//default     = "m4.large"
variable "node-instance-type" {
  default     = "t2.micro"
  type        = "string"
  description = "Worker Node EC2 instance type"
}

variable "desired-capacity" {
  default     = 2
  type        = "string"
  description = "Autoscaling Desired node capacity"
}

variable "max-size" {
  default     = 5
  type        = "string"
  description = "Autoscaling maximum node capacity"
}

variable "min-size" {
  default     = 1
  type        = "string"
  description = "Autoscaling Minimum node capacity"
}

variable "cluster-name" {
  default = "eks-demo-cluster"
  type    = "string"
}

variable "app_name" {
  description = "Simple name for this complete application, used as part of name for structures that are created."
  default = "eks-demo"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default = "80"
}

variable "az_count" {
  description = "Number of availability zones to use for containers"
  default = "2"
}

locals {
  timestamp = "${timeadd(timestamp(),"720h")}"
  day = "${substr(local.timestamp,8,2)}"
  month = "${substr(local.timestamp,5,2)}"
  year = "${substr(local.timestamp,2,2)}"
  duedate = "${local.year}-${local.month}-${local.day}"
  common_tags = {
    Owner = "arto.santala@solita.fi"
    Duedate = "${local.duedate}"
  }
}

