variable "vpc_cidr" {
  description = "vpc cidr block"
  type        = string
}

variable "vpc_private_subnet" {
  description = "vpc private subnet cidr"
  type        = list(string)
}
variable "vpc_public_subnet" {
  description = "vpc public subnet cidr"
  type        = list(string)
}