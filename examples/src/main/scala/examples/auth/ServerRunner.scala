package examples.auth

import java.io.{BufferedReader, BufferedWriter, InputStreamReader, OutputStreamWriter}

import scala.concurrent.ExecutionContext.global
import scala.concurrent.duration.Duration

object ServerRunner extends App {
  val timeout = Duration.Inf

  val server = new java.net.ServerSocket(1330)

  while(true) {
    val mon = server.accept()

    val monIn = new BufferedWriter(new OutputStreamWriter(mon.getOutputStream))
    val monOut = new BufferedReader(new InputStreamReader(mon.getInputStream))
    Server(monIn, monOut)(global, timeout)
    println("Server closed. Restarting...")
  }
}
