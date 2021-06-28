variable "env" {
  description = "The name of the environment."
  type        = string
  default     = "dev"
}

variable "service" {
  description = "The name of the micro-service the application is running"
  type        = string
  default     = "web"
}

variable "github_team" {
  description = "The slug name of the Github team."
  type        = string
}

variable "policies" {
  description = "List of ACL policies to bind to group"
  type        = list(string)
  default     = ["default"]

  validation {
    condition     = !contains(var.policies, "admin")
    error_message = "It is prohibited to bind to the admin policy."
  }
}

variable "mount_accessor" {
  description = "The Accessor ID of the Approle Auth Backend."
  type        = string
}
