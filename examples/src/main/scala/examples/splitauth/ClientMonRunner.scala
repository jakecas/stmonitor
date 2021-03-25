package examples.splitauth

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

//object ClientMonRunner extends App {
//  val timeout = Duration.Inf
//  val clientPort = args(0).toInt //1440
//  val cm = new ConnectionManager(clientPort)
//  val Mon = new Mon(cm)(global, timeout)
//  Mon.run()
//}