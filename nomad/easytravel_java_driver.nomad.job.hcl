job "easytravel_java_job" {
  datacenters = ["dc1"]

  group "weblauncher_java_group" {
    network {
      mode = "host"
      port "frontend" {
        static = 8094
        to = 8094
      }

      port "backend" {
        static = 8095
        to = 8095
      }
    }
    task "weblauncher_java_task" {
      driver = "java"
      config {
        class = "com.dynatrace.easytravel.weblauncher.RunLauncherTomcat"
        class_path = "easytravel/com.dynatrace.easytravel.weblauncher.jar"
        jar_path = "easytravel/com.dynatrace.easytravel.weblauncher.jar"
        args = [
          "-Xmx768m",
          "-Dcom.dynatrace.easytravel.install.dir.correction=easytravel/",
          "-Dorg.eclipse.rap.rwt.enableUITests=true",
          "-Djava.security.auth.login.config=easytravel/resources/login-module.config"
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
