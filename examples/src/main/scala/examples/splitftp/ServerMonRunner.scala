package examples.splitftp

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

object ServerMonRunner extends App {
  val timeout = Duration.Inf
  val serverPort = args(0).toInt //4000
  val cm = new ConnectionManager(serverPort)

  def report(msg: String): Unit = {
    println(msg)
  }
  val Mon = new Monitor(cm, 3, report)(global, timeout)
  Mon.run()
}