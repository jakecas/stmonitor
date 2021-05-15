package examples.splitauth

import java.io.{BufferedReader, BufferedWriter, InputStreamReader, OutputStreamWriter}
import java.net.{ConnectException, Socket}

import scala.concurrent.ExecutionContext.global
import scala.concurrent.duration.Duration

object ServerRunner extends App {
  var mon : Socket = _
  val timeout = Duration.Inf

  val server = new java.net.ServerSocket(1330)
  var count = args(0).toInt

  println(s"Started server for ${count} iterations!")
  while(count > 0) {
    val client = server.accept()

    var notconnected = true
    while (notconnected){
      try {
        Thread.sleep(1000)
        mon = new Socket("127.0.0.1", 1331)
        notconnected = false;
      } catch {
        case _: ConnectException => println("Socket exception, trying again..."); Thread.sleep(100)
      }
    }

    val clientIn = new BufferedWriter(new OutputStreamWriter(client.getOutputStream))
    val clientOut = new BufferedReader(new InputStreamReader(client.getInputStream))
    val monIn = new BufferedWriter(new OutputStreamWriter(mon.getOutputStream))
    Server(clientIn, clientOut, monIn)(global, timeout)
//    println("Server closed. Restarting...")
    count -= 1
  }
}
