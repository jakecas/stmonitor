package examples.auth
import java.net.{ConnectException, ServerSocket}

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

object MonRunner extends App {
  val timeout = Duration.Inf
  val serverPort = 1330
  val clientPort = 1335
  var count = args(0).toInt


  def report(msg: String): Unit = {
    println(msg)
  }

  val clientSocket = new ServerSocket(clientPort)
  println(s"Started monitor for ${count} iterations!")

  while(count > 0) {
    try {
      val cm = new ConnectionManager(serverPort, clientSocket)
      val Mon = new Monitor(cm, 3, report)(global, timeout)
      Mon.run()
      count -= 1
    } catch {
      case _: ConnectException => println("Socket exception, trying again..."); Thread.sleep(100)
    }
  }
}