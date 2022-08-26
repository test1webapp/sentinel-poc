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
  description = "The TFE organization"
  
}

variable "oauth_token_id" {
  description = "The TFE organization to apply your changes to."
  
}
provider "tfe" {
  hostname = var.tfe_hostname
  token    = var.tfe_token
}


resource "tfe_policy_set" "policy_set_1" {
  name          = "security_team_sentinel_policies"
  description   = "Policies that should be enforced on ALL infrastructure."
  organization  = "skylark"
  policies_path = "staging/"
  workspace_ids = ["ws-P7vBaSH4VYauZTm1","ws-jN3s8WtSqfyL2dad","ws-LZzs8vC5coGs1ho8"]

}
resource "tfe_policy_set" "policy_set_2" {
  name          = "security_team_sentinel_policies"
  description   = "Policies that should be enforced on ALL infrastructure."
  organization  = "pigeon"
  policies_path = "staging/"
  workspace_ids = ["ws-ARQa89snaZJRLQQi"]
  vcs_repo {
    identifier         = "test1webapp/sentinel-stage"
    branch             = "main"
    ingress_submodules = false
    oauth_token_id     = var.oauth_token_id
  }
}

}


resource "tfe_policy_set" "policy_set_3" {
  name          = "security_team_sentinel_policies"
  description   = "Policies that should be enforced on ALL infrastructure."
  organization  = "snail"
  policies_path = "staging/"
  workspace_ids = ["ws-nWTHbC4juL3Ltv67"]

}


resource "tfe_policy_set" "policy_set_4" {
  name          = "security_team_sentinel_policies"
  description   = "Policies that should be enforced on ALL infrastructure."
  organization  = "kili"
  policies_path = "staging/"
  workspace_ids = ["ws-Y4QeVXVeVew8Skmq"]

}
