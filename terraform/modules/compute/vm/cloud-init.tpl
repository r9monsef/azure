#cloud-config

bootcmd:
  - mkdir -p /opt/bootstrap

write_files:
  - path: /opt/bootstrap/common.sh
    permissions: '0755'
    content: |
      ${common_script}

%{ if nginx_enabled }
  - path: /opt/bootstrap/nginx.sh
    permissions: '0755'
    content: |
      ${nginx_script}
%{ endif }

%{ if docker_enabled }
  - path: /opt/bootstrap/docker.sh
    permissions: '0755'
    content: |
      ${docker_script}
%{ endif }

%{ if monitor_enabled }
  - path: /opt/bootstrap/monitor.sh
    permissions: '0755'
    content: |
      ${monitor_script}
%{ endif }

runcmd:
  - [ bash, /opt/bootstrap/common.sh ]
%{ if nginx_enabled }
  - [ bash, /opt/bootstrap/nginx.sh ]
%{ endif }
%{ if docker_enabled }
  - [ bash, /opt/bootstrap/docker.sh ]
%{ endif }
%{ if monitor_enabled }
  - [ bash, /opt/bootstrap/monitor.sh ]
%{ endif }
