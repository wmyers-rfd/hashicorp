# Commented out server naming so that this config can be used for all nomad servers
# name = "nomad_server_a"

log_level = "DEBUG"

# Directory to store agent state
data_dir = "/etc/nomad.d/data"

bind_addr = "{{ GetInterfaceIP \"eth0\" }}" # the default

advertise {
  http = "{{ GetInterfaceIP \"eth0\" }}"
  rpc  = "{{ GetInterfaceIP \"eth0\" }}"
  serf = "{{ GetInterfaceIP \"eth0\" }}"
}

# Commented this out to align with TEA-provided Nomad server/client config
# ports {
#   http = 4646
#   rpc  = 4647
#   serf = 4648
# }

# TLS configurations
tls {
  http = false
  rpc  = false

  ca_file   = "/etc/certs/ca.crt"
  cert_file = "/etc/certs/nomad.crt"
  key_file  = "/etc/certs/nomad.key"
}

# Specify the datacenter the agent is a member of
datacenter = "dc1"

# Logging Configurations
log_level = "INFO"
log_file  = "/etc/nomad.d/java_docker_testing.client.log"

server {
  enabled       = false
}

client {
  enabled       = true

  server_join {
    retry_join = ["provider=aws tag_key=nomad_cluster_id tag_value=us-east-2"]
  }

  options {
    "driver.allowlist" = "docker,java"
  }
  chroot_env {
    "/bin" = "/bin"
    "/etc" = "/etc"
    "/lib" = "/lib"
    "/lib64" = "/lib64"
    "/run/resolvconf" = "/run/resolvconf"
    "/sbin" = "/sbin"
    "/usr" = "/usr"
    "home/ec2-user/easytravel" = "/easytravel"
  }
}

