package examples.auth

import java.io.{BufferedReader, BufferedWriter, InputStreamReader, OutputStreamWriter}


import scala.concurrent.ExecutionContext.global
import scala.concurrent.duration.Duration

object ServerRunner extends App {
  val timeout = Duration.Inf

  val server = new java.net.ServerSocket(1330)
  var count = args(0).toInt

  println(s"Started server for ${count} iterations!")
  while(count > 0) {
    val mon = server.accept()

    val monIn = new BufferedWriter(new OutputStreamWriter(mon.getOutputStream))
    val monOut = new BufferedReader(new InputStreamReader(mon.getInputStream))
    Server(monIn, monOut)(global, timeout)
    monIn.close(); monOut.close()
//    println("Server closed. Restarting...")
    count -= 1
  }
}
