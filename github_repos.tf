module "ansible" {
  source = "./modules/github_repo"

  name        = "ansible"
  description = "Home Ansible configuration"

  pipeline_name            = "ansible-lint"
  pipeline_webhook_enabled = true
}
