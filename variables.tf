# add variables here 
variable "region" {
  default     = "us-east-1"
  description = "region"
}
variable "access_key" {
  default     = "##########add-your-access-key"
  description = "access key"
}

variable "secret_key" {
  default     = "#########add-your-secret-key"
  description = "secret key"
}

variable "db_username" {
  default     = "username"
  description = "db username"
}

variable "db_pass" {
  default     = "password"
  description = "db password"
}
