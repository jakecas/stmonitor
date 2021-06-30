package examples.splitauth

import java.net.ServerSocket
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

object ServerMonRunner extends App {
  val timeout = Duration.Inf
  val monPort = 1331
  var count = args(0).toInt


  def report(msg: String): Unit = {
    println(msg)
  }

  val serverMonSocket = new ServerSocket(monPort)
  println(s"Started server monitor for ${count} iterations!")
  val cm = new ConnectionManager(serverMonSocket)

  while(count > 0) {
    val Mon = new Monitor(cm, 3, report)(global, timeout)
    Mon.run()
    count -= 1
  }
  serverMonSocket.close()
}