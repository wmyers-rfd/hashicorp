# Commented out server naming so that this config can be used for all nomad servers
# name = "nomad_server_a"

# Directory to store agent state
data_dir = "/etc/nomad.d/data"

bind_addr = "0.0.0.0" # the default

advertise {
}

ports {
  http = 4646
  rpc  = 4647
  serf = 4648
}

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
log_level = "DEBUG"
log_file  = "/etc/nomad.d/java_docker_testing.server.log"

server {
  enabled          = true
  bootstrap_expect = 1

  server_join {
    retry_join = ["provider=aws tag_key=nomad_cluster_id tag_value=us-east-2"]
  }
}

client {
  enabled          = false
}
