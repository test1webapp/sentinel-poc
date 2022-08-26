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
  description = "The TFE organization"
  
}

variable "kili_token" {
  description = "The TFE organization"
}

data "tfe_slug" "test" {
  // point to the local directory where the policies are located.
  source_path = "staging"
}

provider "tfe" {
  hostname = var.tfe_hostname
  token    = var.tfe_token
}


resource "tfe_policy_set" "skylark" {
  name          = "security_team_sentinel_policies"
  description   = "Policies that should be enforced on ALL infrastructure."
  organization  = "skylark"
  policies_path = "staging/"
  workspace_ids = ["ws-P7vBaSH4VYauZTm1","ws-jN3s8WtSqfyL2dad","ws-LZzs8vC5coGs1ho8"]
  slug = data.tfe_slug.test
}

resource "tfe_policy_set" "snail" {
  name          = "security_team_sentinel_policies"
  description   = "Policies that should be enforced on ALL infrastructure."
  organization  = "snail"
  policies_path = "staging/"
  workspace_ids = ["ws-nWTHbC4juL3Ltv67"]
  slug = data.tfe_slug.test
}
  
 resource "tfe_policy_set" "kili" {
  name          = "security_team_sentinel_policies"
  description   = "Policies that should be enforced on ALL infrastructure."
  organization  = "kili"
  policies_path = "staging/"
  workspace_ids = ["ws-Y4QeVXVeVew8Skmq"]
  slug = data.tfe_slug.test
}

resource "tfe_policy_set" "pigeon" {
  name          = "security_team_sentinel_policies"
  description   = "Security team sentinel policies"
  organization  = "pigeon"
  workspace_ids = ["ws-ARQa89snaZJRLQQi"]

  // reference the tfe_slug data source.
  slug = data.tfe_slug.test
}
