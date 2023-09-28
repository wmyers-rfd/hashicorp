job "easytravel_raw_exec_job" {
  datacenters = ["dc1"]

  group "weblauncher_raw_exec_group" {
    network {
      mode = "bridge"
      port "frontend" {
        to = 8094
      }

      port "backend" {
        to = 8095
      }
    }
    task "weblauncher_raw_exec_task" {
      driver = "raw_exec"
      config {
        command = "/usr/bin/java"
        args = [
          "-Xmx768m",
          "-Dcom.dynatrace.easytravel.install.dir.correction=easytravel/",
          "-Dorg.eclipse.rap.rwt.enableUITests=true",
          "-Djava.security.auth.login.config=easytravel/resources/login-module.config",
          "-jar=./com.dynatrace.easytravel.weblauncher.jar"
        ]
      }
      artifact {
        source = "http://com.rfdinc.performance.static.content.s3.amazonaws.com/test/com.dynatrace.easytravel.weblauncher.jar"
        destination = "local"

      }
    }
  }
}
