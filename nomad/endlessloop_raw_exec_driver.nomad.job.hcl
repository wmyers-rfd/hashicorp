job "endlessloop_raw_exec_job" {
  datacenters = ["dc1"]

  group "endlessloop_raw_exec_group" {
    network {
      mode = "bridge"
      port "frontend" {
        to = 8094
      }

      port "backend" {
        to = 8095
      }
    }
    task "endlessloop_raw_exec_task" {
      driver = "raw_exec"
      config {
        command = "/usr/bin/java"
        args = [
          "-cp",
          "${NOMAD_TASK_DIR}/EndlessLoopWithWaitAndMethod.jar",
          "EndlessLoopWithWaitAndMethod"
        ]
      }
      artifact {
        source = "http://com.rfdinc.performance.static.content.s3.amazonaws.com/test/EndlessLoopWithWaitAndMethod.jar"
        destination = "local"
      }
    }
  }
}
