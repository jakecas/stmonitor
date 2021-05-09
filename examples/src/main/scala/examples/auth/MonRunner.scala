package examples.auth
import java.net.{ConnectException, ServerSocket}

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

object MonRunner extends App {
  val timeout = Duration.Inf
  val serverPort = args(0).toInt //1335
  val clientPort = args(1).toInt //1330


  def report(msg: String): Unit = {
    println(msg)
  }

  val clientSocket = new ServerSocket(clientPort)

  while(true) {
    try {
      val cm = new ConnectionManager(serverPort, clientSocket)
      val Mon = new Monitor(cm, 3, report)(global, timeout)
      Mon.run()
    } catch {
      case _: ConnectException => println("Socket exception, trying again..."); Thread.sleep(100)
    }
  }
}