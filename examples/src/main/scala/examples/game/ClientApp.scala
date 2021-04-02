package examples.game

import java.io._
import java.net.Socket

import scala.io.StdIn

object ClientApp extends App {
  private val correctR = """CORRECT (.+)""".r
  private val incorrectR = """INCORRECT""".r
  val monSocket = new Socket("127.0.0.1", 1330)
  val monIn: BufferedWriter =  new BufferedWriter(new OutputStreamWriter(monSocket.getOutputStream))
  val monOut: BufferedReader = new BufferedReader(new InputStreamReader(monSocket.getInputStream));
  var quit = false
  while (!quit) {
    print("Enter guess (-1 to quit): ")
    val num = StdIn.readInt()
    if(num == -1){
      println("[C] Sending Quit()")
      monIn.write(f"QUIT\n"); monIn.flush()
      quit = true

    } else {
      println("[C] Sending Guess(" + num + ")")
      monIn.write(f"GUESS ${num}\n"); monIn.flush()

      monOut.readLine() match {
        case correctR(ans) =>
          println(f"[C] Received 'Correct(${ans})'")
          quit = true

        case incorrectR() =>
          println(f"[C] Received 'Incorrect'")
      }
    }
  }
}
