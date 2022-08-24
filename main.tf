terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "skylark"

    workspaces {
      name = "sentinel-stage"
    }
  }
}


variable "tfe_hostname" {
  description = "The domain where your TFE is hosted."
  default     = "app.terraform.io"
}

variable "tfe_organization" {
  description = "The TFE organization to apply your changes to."
  default     = "example_corp"
}

variable "tfe_token" {
  description = "The TFE organization to apply your changes to."
  
}

variable "oauth_token_id" {
  description = "The TFE organization to apply your changes to."
  
}
provider "tfe" {
  hostname = var.tfe_hostname
  token    = var.tfe_token
}


resource "tfe_policy_set" "policy_set_1" {
  name          = "security team sentinel policies"
  description   = "Policies that should be enforced on ALL infrastructure."
  organization  = "skylark"
  policies_path = "staging/"
  workspace_ids = ["ws-tGEWkng5AxjnKZTk","ws-jN3s8WtSqfyL2dad","ws-LZzs8vC5coGs1ho8"]

}
resource "tfe_policy_set" "policy_set_2" {
  name          = "security team sentinel policies"
  description   = "Policies that should be enforced on ALL infrastructure."
  organization  = "pigeon"
  policies_path = "staging/"
  workspace_ids = ["ws-ARQa89snaZJRLQQi"]

}

