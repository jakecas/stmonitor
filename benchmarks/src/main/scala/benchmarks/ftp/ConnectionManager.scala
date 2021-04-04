package benchmarks.ftp

import java.io._
import java.net.{ServerSocket, Socket}

class ConnectionManager(var serverPort: Int, var clientPort: Int) {
  var serverIn: BufferedWriter = _; var clientIn: BufferedWriter = _;
  var serverOut: BufferedReader = _; var clientOut: BufferedReader = _;

  val serverSocket = new Socket("127.0.0.1", serverPort)
  val clientSocket = new ServerSocket(clientPort)

  private val authR = """AUTH (.+) (.+)""".r
  private val succR = """SUCC (.+)""".r
  private val failR = """FAIL (.+)""".r

  def setup(): Unit = {
//    val client = clientSocket.accept();
//    println(f"[CM] Waiting for requests from Client on ${clientPort} and connected to Server on ${serverPort}")
//    serverIn = new BufferedWriter(new OutputStreamWriter(serverSocket.getOutputStream))
//    serverOut = new BufferedReader(new InputStreamReader(serverSocket.getInputStream))
//    clientIn = new BufferedWriter(new OutputStreamWriter(client.getOutputStream))
//    clientOut = new BufferedReader(new InputStreamReader(client.getInputStream))
  }

  def receiveFromClient(): Any = clientOut.readLine() match {
    case e => e
  }

  def receiveFromServer(): Any = serverOut.readLine() match {
    case e => e
  }

  def sendToClient(x: Any): Unit = x match {
    case _ => close(); throw new Exception("[CM] Error: Unexpected message by Mon");
  }

  def sendToServer(x: Any): Unit = x match {
    case _ => close(); throw new Exception("[CM] Error: Unexpected message by Mon");
  }

  def close(): Unit = {
//    serverIn.flush(); clientIn.flush();
//    serverIn.close(); clientIn.close();
//    serverSocket.close(); clientOut.close();
  }
}