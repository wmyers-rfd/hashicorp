job "easytravel" {
  datacenters = ["dc1"]

  group "weblauncher" {
    task "weblauncher" {
      driver = "java"
      config {
        # TODO - Figure out if this is the actual class 
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
      # TODO - Add this the final jar
        source = "https://github.com/membrane/service-proxy/releases/download/v4.7.3/membrane-service-proxy-4.7.3.zip"
      }
      env {
        EASYTRAVEL_HOME = "${NOMAD_TASK_DIR}/easytravel"
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
