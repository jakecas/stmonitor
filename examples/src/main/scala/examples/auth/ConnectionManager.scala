package examples.auth

import java.io._
import java.net.{ServerSocket, Socket}

class ConnectionManager(var serverPort: Int, var clientSocket: ServerSocket) {
  var serverIn: BufferedWriter = _; var clientIn: BufferedWriter = _;
  var serverOut: BufferedReader = _; var clientOut: BufferedReader = _;

  val serverSocket = new Socket("127.0.0.1", serverPort)

  private val authR = """AUTH (.+) (.+)""".r
  private val getR = """GET (.+) (.+)""".r
  private val rvkR = """RVK (.+)""".r
  private val succR = """SUCC (.+)""".r
  private val failR = """FAIL (.+)""".r
  private val resR = """RES (.+)""".r
  private val timeoutR = """Timeout""".r

  def setup(): Unit = {
    val client = clientSocket.accept();
    println(f"[CM] Waiting for requests from Client and connected to Server on ${serverPort}")
    serverIn = new BufferedWriter(new OutputStreamWriter(serverSocket.getOutputStream))
    serverOut = new BufferedReader(new InputStreamReader(serverSocket.getInputStream))
    clientIn = new BufferedWriter(new OutputStreamWriter(client.getOutputStream))
    clientOut = new BufferedReader(new InputStreamReader(client.getInputStream))
  }

  def receiveFromClient(): Any = clientOut.readLine() match {
    case authR(uname, pwd) => println(s"[CM] Received AUTH ${uname} ${pwd}"); Auth(uname, pwd);
    case getR(resource, tok) => println(s"[CM] Received GET ${resource} ${tok}"); Get(resource, tok);
    case rvkR(tok) => println(s"[CM] Received RVK ${tok}"); Rvk(tok);
    case e => e
  }

  def receiveFromServer(): Any = serverOut.readLine() match {
    case succR(tok) => println("[CM] Received Success"); Succ(tok);
    case failR(code) => println("[CM] Received Failure"); Fail(code.toInt);
    case resR(content) => println("[CM] Received Result"); Res(content);
    case timeoutR() => println("[CM] Received Timeout"); Timeout();
    case e => e
  }

  def sendToClient(x: Any): Unit = x match {
    case Succ(tok) => println("[CM] Sending Success"); clientIn.write(f"SUCC ${tok}\n"); clientIn.flush();
    case Res(content) => println("[CM] Sending Res"); clientIn.write(f"RES $content\n"); clientIn.flush();
    case Timeout() => println("[CM] Sending Timeout"); clientIn.write(f"Timeout\n"); clientIn.flush();
    case Fail(code) => println("[CM] Sending Fail"); clientIn.write(f"FAIL $code\n"); clientIn.flush();
    case msg => close(); throw new Exception(s"[CM] Error: Unexpected message ${msg} by Mon");
  }

  def sendToServer(x: Any): Unit = x match {
    case Auth(uname, pwd) => println("[CM] Sending Auth"); serverIn.write(f"AUTH ${uname} ${pwd}\n"); serverIn.flush();
    case Get(resource, reqTok) => println("[CM] Sending Get"); serverIn.write(f"GET ${resource} ${reqTok}\n"); serverIn.flush();
    case Rvk(rvkTok) => println("[CM] Sending Rvk"); serverIn.write(f"RVK ${rvkTok}\n"); serverIn.flush();
    case msg => close(); throw new Exception(s"[CM] Error: Unexpected message ${msg} by Mon");
  }

  def close(): Unit = {
    serverIn.flush(); clientIn.flush();
    serverIn.close(); clientIn.close();
    serverSocket.close(); clientOut.close();
  }
}