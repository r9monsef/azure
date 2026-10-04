locals {
  fileshare = {
    "rezateststgacc/nfs" = {
      storage_account_key = "rezateststgacc"
      share_name          = "nfs"
      quota_in_gb         = 5120
      access_tier         = "Cool"
    }
    "rezateststgacc/tetttttttt" = {
      storage_account_key = "rezateststgacc"
      share_name          = "tetttttttt"
      quota_in_gb         = 1024
      access_tier         = "Cool"
    }
  }
}
