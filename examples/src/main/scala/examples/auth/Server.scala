package examples.auth

import java.io.{BufferedReader, BufferedWriter}

import scala.concurrent.duration.Duration
import scala.concurrent.ExecutionContext
import scala.util.Random

object Server {

  private val authR = """AUTH (.+) (.+)""".r
  private val getR = """GET (.+) (.+)""".r
  private val rvkR = """RVK (.+)""".r


  def apply(toMon: BufferedWriter, fromMon: BufferedReader)(implicit ec: ExecutionContext, timeout: Duration) {
//    println("[S] Server started, to terminate press CTRL+c")
    var notAuth = true
    while(notAuth){
      fromMon.readLine() match {
        case authR(uname, pwd) =>
//          println(f"[S] Received Auth(${uname}, ${pwd})")
          val token = Random.alphanumeric.filter(_.isLetter).take(10).mkString
//          println(f"[S] Sending Succ($token)")
          toMon.write(s"SUCC ${token}\n"); toMon.flush()
          notAuth = false
          while(!notAuth){
            fromMon.readLine() match {
              case getR(resource, reqTok) =>
//                println(f"[S] Received Get(${resource}, ${reqTok})")
                if(token!=reqTok){
//                  println("[S] Tokens do not match: sending Timeout()")
                  toMon.write("Timeout\n"); toMon.flush()
                  notAuth = true
                } else {
//                  println(f"[S] Sending Res(content)")
                  toMon.write(s"RES content\n"); toMon.flush()
                }
              case rvkR(rvkTok) =>
//                println(f"[S] Received Rvk(${rvkTok}): terminating")
                return
            }
          }
      }
    }
  }
}
