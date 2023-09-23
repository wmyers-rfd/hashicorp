job "easytravel" {
  datacenters = ["dc1"]

  group "weblauncher" {
    task "weblauncher" {
      driver = "java"
      config {
        class = "com.dynatrace.easytravel.weblauncher"
        class_path = "${EASYTRAVEL_HOME}/resources:${EASYTRAVEL_HOME}/com.dynatrace.easytravel.weblauncher.jar"
        args = [
          "-Xmx768m",
          "-Dcom.dynatrace.easytravel.install.dir.correction=../../easytravel/",
          "-Dorg.eclipse.rap.rwt.enableUITests=true",
          "-Djava.security.auth.login.config=${EASYTRAVEL_HOME}/resources/login-module.config"
        ]
      }
      artifact {
        source = "http://com.rfdinc.performance.static.content.s3.amazonaws.com/test/com.dynatrace.easytravel.weblauncher.jar"

      }
      env {
        EASYTRAVEL_HOME = "${NOMAD_TASK_DIR}/easytravel"
      }
    }
    network {
      port "frontend" {
        static = 8094
      }

      port "backend" {
        static = 8095
      }
    }
  }
}
