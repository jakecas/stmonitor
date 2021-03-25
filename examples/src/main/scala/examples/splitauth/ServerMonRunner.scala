package examples.splitauth

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

//object ServerMonRunner extends App {
//  val timeout = Duration.Inf
//  val serverPort = args(0).toInt //1445
//  val cm = new ConnectionManager(serverPort)
//  val Mon = new Mon(cm)(global, timeout)
//  Mon.run()
//}