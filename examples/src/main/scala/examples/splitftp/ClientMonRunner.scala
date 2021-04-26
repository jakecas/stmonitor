package examples.splitftp

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

object ClientMonRunner extends App {
  val timeout = Duration.Inf
  val clientPort = args(0).toInt //4000
  val cm = new ConnectionManager(clientPort)
  val Mon = new Mon(cm)(global, timeout)
  Mon.run()
}