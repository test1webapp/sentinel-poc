terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "skylark"

    workspaces {
      name = "terrasent"
    }
  }
}

variable "tfe_token" {}

variable "tfe_hostname" {
  description = "The domain where your TFE is hosted."
  default     = "app.terraform.io"
}

variable "tfe_organization" {
  description = "The TFE organization to apply your changes to."
  default     = "example_corp"
}

provider "tfe" {
  hostname = "${var.tfe_hostname}"
  token    = "${var.tfe_token}"
  version  = "~> 0.6"
}

data "tfe_workspace_ids" "all" {
  names        = ["*"]
  organization = "${var.tfe_organization}"
}

data "tfe_oauth_client" "client" {
  oauth_client_id = "d56bab77653b18c6fb93"
}

locals {
  workspaces = "${data.tfe_workspace_ids.all.external_ids}" # map of names to IDs
}

resource "tfe_policy_set" "global" {
  name         = "global"
  description  = "Policies that should be enforced on ALL infrastructure."
  organization = "${var.tfe_organization}"
  policies_path = "staging/"
  workspace_ids = local.workspaces
  vcs_repo {
    identifier         = "skylark/sentinel-stage"
    branch             = "main"
    oauth_token_id     = tfe_oauth_client.client.oauth_token_id
  }
}
