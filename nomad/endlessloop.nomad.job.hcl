job "endlessloop_job" {
  datacenters = ["dc1"]

  group "endlessloop_group" {
    task "endlessloop_task" {
      driver = "java"
      config {
        class = "EndlessLoopWithWaitAndMethod"
        class_path = "local/EndlessLoopWithWaitAndMethod.jar"
        args = [
          "-Xmx768m"
        ]
      }
      artifact {
        source = "http://com.rfdinc.performance.static.content.s3.amazonaws.com/test/EndlessLoopWithWaitAndMethod.jar"

      }
      env {
        EASYTRAVEL_HOME = "${NOMAD_TASK_DIR}/easytravel"
      }
    }
  }
}
