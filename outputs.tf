output "cron_jobs" {
  value = [
    {
      name                          = "${local.app_name}-cron-${random_string.resource_suffix.result}"
      labels                        = local.k8s_labels
      schedule                      = var.schedule
      concurrency_policy            = "Allow"
      suspend                       = false
      failed_jobs_history_limit     = 1
      successful_jobs_history_limit = 3
      timezone                      = "Etc/UTC"
      starting_deadline_seconds     = 0
    }
  ]
}
