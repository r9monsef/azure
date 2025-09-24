
storage_account_name            = "rezashamsiprod"
container_app_environment_name  = "container-app-env"


containers = {
  backend = {
    name                      = "backend"
    image                     = "rezashamsimonsef/back:latest"
    cpu                       = 0.25
    memory                    = "0.5Gi"
    min_replicas              = 1
    max_replicas              = 1
    mount_volume              = true
    volume_name               = "backend-storage"
    environment_storage_name  = "backend-storage-mount"
    file_share_name           = "backend-share"          
    file_share_quota          = 20
    mount_path                = "/opt/data"
    expose_internet           = false
    port                     = 8000
    allowed_source_ips        = ["*"]
    ingress_transport         = "tcp" 

  },
    frontend = {
    name                      = "frontend"
    image                     = "rezashamsimonsef/frontend:latest"
    cpu                       = 0.25
    memory                    = "0.5Gi"
    min_replicas              = 1
    max_replicas              = 1
    mount_volume              = true
    volume_name               = "front-storage"
    environment_storage_name  = "front-storage-mount"
    file_share_name           = "front-share"          
    file_share_quota          = 20
    mount_path                = "/opt/data"
    expose_internet           = true
    port                     = 5000
    allowed_source_ips        = ["*"]
    ingress_transport         = "http" 
  }
}