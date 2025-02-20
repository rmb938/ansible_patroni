# {{ ansible_managed }}

vault {
  address = "http://127.0.0.1:8100"
  renew_token = false
  retry {
    # Settings to 0 for unlimited retries.
    attempts = 0
  }
}

consul {
  address = "127.0.0.1:8500"
  retry {
    # Settings to 0 for unlimited retries.
    attempts = 0
  }
}

# Unsure if this is needed tbh
wait {
  min = "15s"
  max = "30s"
}

# Patroni Config
template {
  source = "/etc/consul-template/templates/postgres/patroni-config.yml.ctmpl"
  destination = "/etc/patroni/config.yml"
  create_dest_dirs = false
  perms = "0600"
  exec {
    command = "sudo systemctl reload-or-restart patroni || true"
  }
}

# Patroni Client CA
template {
  source = "/etc/consul-template/templates/postgres/patroni-client-ca.crt.ctmpl"
  destination = "/etc/patroni/patroni-client-ca.crt"
  create_dest_dirs = false
  perms = "0644"
  exec {
    command = "sudo systemctl reload-or-restart patroni || true"
  }
}

# Patroni Client
template {
  source = "/etc/consul-template/templates/postgres/patroni-client.ctmpl"
  destination = "/etc/patroni/patroni-client.ctmpl.rendered"
  create_dest_dirs = false
  perms = "0644"
  exec {
    command = "sudo systemctl reload-or-restart patroni || true"
  }
}

# Postgres Client CA
template {
  source = "/etc/consul-template/templates/postgres/postgres-client-ca.crt.ctmpl"
  destination = "/etc/patroni/postgres-client-ca.crt"
  create_dest_dirs = false
  perms = "0644"
  exec {
    command = "sudo systemctl reload-or-restart patroni || true"
  }
}

# Postgres Client CA for PG Bouncer
template {
  source = "/etc/consul-template/templates/postgres/postgres-client-ca.crt.ctmpl"
  destination = "/etc/pgbouncer/postgres-client-ca.crt"
  create_dest_dirs = false
  perms = "0644"
  exec {
    command = "sudo systemctl reload-or-restart pgbouncer || true"
  }
}

# Postgres Users
template {
  source = "/etc/consul-template/templates/postgres/postgres-user-postgres.ctmpl"
  destination = "/etc/patroni/postgres-user-postgres.rendered"
  create_dest_dirs = false
  perms = "0600"
  exec {
    command = "sudo systemctl reload-or-restart patroni || true"
  }
}

template {
  source = "/etc/consul-template/templates/postgres/postgres-user-replicator.ctmpl"
  destination = "/etc/patroni/postgres-user-replicator.rendered"
  create_dest_dirs = false
  perms = "0600"
  exec {
    command = "sudo systemctl reload-or-restart patroni || true"
  }
}

template {
  source = "/etc/consul-template/templates/postgres/postgres-user-rewind.ctmpl"
  destination = "/etc/patroni/postgres-user-rewind.rendered"
  create_dest_dirs = false
  perms = "0600"
  exec {
    command = "sudo systemctl reload-or-restart patroni || true"
  }
}
