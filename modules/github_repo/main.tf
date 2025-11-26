variable "name" {
  type        = string
  description = "Name of the GitHub repository"
}

variable "description" {
  type        = string
  description = "Description of the GitHub repository"
  default     = ""
}

variable "visiblity" {
  type        = string
  description = "Visibility of GitHub repository"
  default     = "public"
}

variable "pipeline_webhook_enabled" {
  type        = bool
  default     = false
  description = "Enable Concourse pipeline webhook"
}

variable "pipeline_team" {
  type        = string
  description = "Name of the Concourse team that owns the pipeline"
  default     = "main"
}

variable "pipeline_name" {
  type        = string
  description = "Name of a Concourse pipeine for webhook notifications"
  nullable    = true
}

variable "pipeline_resource_name" {
  type        = string
  description = "Name of the resource in the pipeline to send webhook to"
  default     = "pull-request"
}

data "vault_kv_secret_v2" "secret" {
  mount = "concourse"
  name  = "${var.pipeline_team}/${var.pipeline_name}/webhook"
}

resource "github_repository" "repo" {
  name        = var.name
  description = var.description

  visibility = var.visiblity
}

resource "github_repository_webhook" "repo" {
  count      = var.pipeline_webhook_enabled == true ? 1 : 0
  repository = github_repository.repo.name

  configuration {
    url          = "https://ci.srv.simpson.id/api/v1/teams/${var.pipeline_team}/pipelines/${var.pipeline_name}/resources/${var.pipeline_resource_name}/check/webhook?webhook_token=${data.vault_kv_secret_v2.secret.data.token}"
    content_type = "form"
  }

  events = ["push", "pull_request"]
}
