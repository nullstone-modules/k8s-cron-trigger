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

variable "timezone" {
  type        = string
  default     = "" // "Etc/UTC"
  description = <<EOF
By default, this is set to "" which uses the cluster's local time.

Kubernetes prefers "<Region>/<City>" format for time zones rather than abbreviations.
For a list of valid time zones, refer to the "TZ identifer" column at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones.
Examples: "America/New_York", "Asia/Tokyo", "Europe/London", "Etc/UTC", etc.
EOF
}
