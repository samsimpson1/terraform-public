variable "name" {
  type = string
  description = "Name of the GitHub repository"
}

variable "pipeline_webhook_enabled" {
  type = bool
  default = false
  description = "Enable Concourse pipeline webhook"
}

variable "pipeline_team" {
  type = string
  description = "Name of the Concourse team that owns the pipeline"
  default = "main"
}

variable "pipeline_name" {
  type = string
  description = "Name of a Concourse pipeine for webhook notifications"
  nullable = true
}
