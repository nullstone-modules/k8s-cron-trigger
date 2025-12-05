terraform {
  required_providers {
    ns = {
      source = "nullstone-io/ns"
    }
  }
}

data "ns_workspace" "this" {}

data "ns_app_env" "this" {
  stack_id = data.ns_workspace.this.stack_id
  app_id   = data.ns_workspace.this.block_id
  env_id   = data.ns_workspace.this.env_id
}

// Generate a random suffix to ensure uniqueness of resources
resource "random_string" "resource_suffix" {
  length  = 5
  lower   = true
  upper   = false
  numeric = false
  special = false
}

locals {
  app_name    = data.ns_workspace.this.block_name
  app_version = coalesce(data.ns_app_env.this.version, "latest")

  match_labels = {
    "nullstone.io/stack"     = data.ns_workspace.this.stack_name
    "nullstone.io/block-ref" = data.ns_workspace.this.block_ref
    "nullstone.io/env"       = data.ns_workspace.this.env_name
  }
  k8s_labels = merge({
    // k8s-recommended labels
    "app.kubernetes.io/name"       = local.app_name
    "app.kubernetes.io/version"    = local.app_version
    "app.kubernetes.io/component"  = "cron-${random_string.resource_suffix.result}"
    "app.kubernetes.io/part-of"    = data.ns_workspace.this.stack_name
    "app.kubernetes.io/managed-by" = "nullstone"
    // nullstone labels
    "nullstone.io/block" = local.app_name
  }, local.match_labels)
}
