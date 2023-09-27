job "easytravel" {
  datacenters = ["dc1"]

  group "weblauncher" {
    network {
      mode = "bridge"
      port "frontend" {
        to = 8094
      }

      port "backend" {
        to = 8095
      }
    }
    task "weblauncher" {
      driver = "raw_exec"
      config {
        command = "/usr/bin/java"
        args = [
          "-Xmx768m",
          "-Dcom.dynatrace.easytravel.install.dir.correction=easytravel/",
          "-Dorg.eclipse.rap.rwt.enableUITests=true",
          "-Djava.security.auth.login.config=${EASYTRAVEL_HOME}/resources/login-module.config",
          "-jar ./com.dynatrace.easytravel.weblauncher.jar"
        ]
      }
      artifact {
        source = "http://com.rfdinc.performance.static.content.s3.amazonaws.com/test/com.dynatrace.easytravel.weblauncher.jar"

      }
      env {
        EASYTRAVEL_HOME = "${NOMAD_TASK_DIR}/easytravel"
      }
    }
  }
}
