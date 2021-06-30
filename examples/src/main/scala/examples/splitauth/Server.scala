package examples.splitauth

import java.io.{BufferedReader, BufferedWriter}

import scala.concurrent.ExecutionContext
import scala.concurrent.duration.Duration
import scala.util.Random

object Server {

  private val authR = """AUTH (.+) (.+)""".r
  private val getR = """GET (.+) (.+)""".r
  private val rvkR = """RVK (.+)""".r

  def apply(toClient: BufferedWriter, fromClient: BufferedReader, toMon: BufferedWriter)(implicit ec: ExecutionContext, timeout: Duration) {
//    println("[S] Server started, to terminate press CTRL+c")
    var notAuth = true
    while(notAuth){
      fromClient.readLine() match {
        case authR(uname, pwd) =>
          toMon.write(s"AUTH ${uname} ${pwd}\n")
//          println(f"[S] Received Auth(${uname}, ${pwd})")
          val token = Random.alphanumeric.filter(_.isLetter).take(10).mkString
//          println(f"[S] Sending Succ($token)")
          toClient.write(s"SUCC ${token}\n"); toClient.flush()
          toMon.write(s"SUCC ${token}\n"); toMon.flush()
          notAuth = false
          while(!notAuth){
            fromClient.readLine() match {
              case getR(resource, reqTok) =>
                toMon.write(s"GET ${resource} ${reqTok}\n")
//                println(f"[S] Received Get(${resource}, ${reqTok})")
                if(token!=reqTok){
//                  println("[S] Tokens do not match: sending Timeout()")
                  toClient.write("Timeout\n"); toClient.flush()
                  toMon.write("Timeout\n"); toMon.flush()
                  notAuth = true
                } else {
//                  println(f"[S] Sending Res(content)")
                  toClient.write(s"RES content\n"); toClient.flush()
                  toMon.write(s"RES content\n"); toMon.flush()
                }
              case rvkR(rvkTok) =>
                toMon.write(s"RVK ${rvkTok}\n"); toMon.flush()
//                println(f"[S] Received Rvk(${rvkTok}): terminating")
                return
            }
          }
      }
    }
  }
}
