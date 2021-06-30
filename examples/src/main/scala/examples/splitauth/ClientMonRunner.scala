package examples.splitauth

import java.net.ServerSocket
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

object ClientMonRunner extends App {
  val timeout = Duration.Inf
  val clientPort = 1335
  var count = args(0).toInt


  def report(msg: String): Unit = {
    println(msg)
  }

  val clientMonSocket = new ServerSocket(clientPort)
  println(s"Started client monitor for ${count} iterations!")
  val cm = new ConnectionManager(clientMonSocket)

  while(count > 0) {
    val Mon = new Monitor(cm, 3, report)(global, timeout)
    Mon.run()
    count -= 1
  }
  clientMonSocket.close()
}