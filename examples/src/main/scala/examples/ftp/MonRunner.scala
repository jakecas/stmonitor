package examples.ftp

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

object MonRunner extends App {
  val timeout = Duration.Inf
  val serverPort = args(0).toInt //4021
  val clientPort = args(1).toInt //4000
  val cm = new ConnectionManager(serverPort, clientPort)

  def report(msg: String): Unit = {
          println(msg)
        }
  val Mon = new Monitor(cm, 3, report)(global, timeout)
  Mon.run()
}