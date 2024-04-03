variable "vpc_cidr" {
  description = "vpc cidr block"
  type        = string
}

variable "vpc_public_subnet" {
  description = "vpc public subnet cidr"
  type        = list(string)
}