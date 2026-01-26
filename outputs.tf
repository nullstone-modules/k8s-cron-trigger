output "cron_jobs" {
  value = [
    {
      name                          = "${local.app_name}-cron"
      labels                        = local.k8s_labels
      schedule                      = var.schedule
      concurrency_policy            = "Allow"
      suspend                       = false
      failed_jobs_history_limit     = 1
      successful_jobs_history_limit = 3
      timezone                      = var.timezone
      starting_deadline_seconds     = 0
      ttl_seconds_after_finished    = var.ttl_after_finished
    }
  ]
}
