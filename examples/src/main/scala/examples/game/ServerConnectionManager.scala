package examples.game

import monitor.util.ConnectionManager

import java.io
import java.io.{BufferedReader, BufferedWriter, InputStreamReader, OutputStreamWriter}
import java.net.{ServerSocket, Socket}

class ServerConnectionManager(var serverPort: Int, var clientPort: Int) {
  var serverIn: BufferedWriter = _; var clientIn: BufferedWriter = _;
  var serverOut: BufferedReader = _; var clientOut: BufferedReader = _;

  val serverSocket = new Socket("127.0.0.1", serverPort)
  val clientSocket = new ServerSocket(clientPort)

  private val guessR = """GUESS (.+)""".r
  private val quitR = """QUIT""".r
  private val correctR = """CORRECT (.+)""".r
  private val incorrectR = """INCORRECT""".r

  def setup(): Unit ={
    val client = clientSocket.accept();
    println(f"[CM] Waiting for requests from Client on ${clientPort} and connected to Server on ${serverPort}")
    serverIn = new BufferedWriter(new OutputStreamWriter(serverSocket.getOutputStream))
    serverOut = new BufferedReader(new InputStreamReader(serverSocket.getInputStream))
    clientIn = new BufferedWriter(new OutputStreamWriter(client.getOutputStream))
    clientOut = new BufferedReader(new InputStreamReader(client.getInputStream))
  }

  def receiveFromServer(): Any = clientOut.readLine() match {
    case guessR(num) => println("Received guess."); Guess(num.toInt)
    case quitR() => println("Received quit."); Quit()
    case e => e
  }

  def receiveFromClient(): Any = serverOut.readLine() match {
    case correctR(ans) => Correct(ans.toInt)
    case incorrectR() => Incorrect()
    case e => e
  }

  def sendToServer(x: Any): Unit = x match {
    case Correct(ans) => clientIn.write(f"CORRECT ${ans}\n"); clientIn.flush()
    case Incorrect() => clientIn.write("INCORRECT\n"); clientIn.flush();
    case _ => close(); throw new Exception()
  }

  def sendToClient(x: Any): Unit = x match {
    case Guess(num) => serverIn.write(f"GUESS ${num}\n"); serverIn.flush()
    case Quit() => serverIn.write("QUIT\n"); serverIn.flush();
    case _ => close(); throw new Exception()
  }

  def close(): Unit = {
    serverIn.flush(); clientIn.flush();
    serverIn.close(); clientIn.close();
    serverSocket.close(); clientOut.close();
  }
}