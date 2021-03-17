package examples.auth
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

object MonRunner extends App {
  val timeout = Duration.Inf
  val serverPort = args(0).toInt //1335
  val clientPort = args(1).toInt //1330
  val cm = new ConnectionManager(serverPort, clientPort)
  val Mon = new Mon(cm)(global, timeout)
  Mon.run()
}