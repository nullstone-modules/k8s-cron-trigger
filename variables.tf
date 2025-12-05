variable "app_metadata" {
  description = <<EOF
Nullstone automatically injects metadata from the app module into this module through this variable.
This variable is a reserved variable for capabilities.
EOF

  type    = map(string)
  default = {}
}

variable "schedule" {
  type        = string
  default     = "@daily"
  description = <<EOF
A cron or rate expression that determines when to trigger the Kubernetes job.
Default = @daily, every day at midnight UTC - cron(0 0 * * ? *)
Format: minutes, hours, day-of-month, month, day-of-week, year
Available aliases: @yearly, @monthly, @weekly, @daily, @hourly
See https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#writing-a-cronjob-spec
EOF
}
