//package examples.auth
//
//import java.io._
//import java.net.{ServerSocket, Socket}
//
//class ConnectionManager(var serverPort: Int, var clientPort: Int) {
//  var serverIn: BufferedWriter = _; var clientIn: BufferedWriter = _;
//  var serverOut: BufferedReader = _; var clientOut: BufferedReader = _;
//
//  val serverSocket = new Socket("127.0.0.1", serverPort)
//  val clientSocket = new ServerSocket(clientPort)
//
//  private val authR = """AUTH (.+) (.+)""".r
//  private val getR = """GET (.+) (.+)""".r
//  private val rvkR = """RVK (.+)""".r
//  private val succR = """SUCC (.+)""".r
//  private val failR = """FAIL (.+)""".r
//
//  def setup(): Unit = {
//    val client = clientSocket.accept();
//    println(f"[CM] Waiting for requests from Client on ${clientPort} and connected to Server on ${serverPort}")
//    serverIn = new BufferedWriter(new OutputStreamWriter(serverSocket.getOutputStream))
//    serverOut = new BufferedReader(new InputStreamReader(serverSocket.getInputStream))
//    clientIn = new BufferedWriter(new OutputStreamWriter(client.getOutputStream))
//    clientOut = new BufferedReader(new InputStreamReader(client.getInputStream))
//  }
//
//  def receiveFromClient(): Any = clientOut.readLine() match {
//    case authR(uname, pwd) => Auth(uname, pwd);
//    case getR(resource, tok) => Get(resource, tok);
//    case rvkR(tok) => Rvk(tok);
//    case e => e
//  }
//
//  def receiveFromServer(): Any = serverOut.readLine() match {
//    case succR(tok) => println("[CM] Received Success"); Succ(tok);
//    case failR(code) => println("[CM] Received Failure"); Fail(code.toInt);
//    case e => e
//  }
//
//  def sendToClient(x: Any): Unit = x match {
//    case Succ(tok) => clientIn.write(f"SUCC ${tok}\r\n"); clientIn.flush();
//    case Res(content) => clientIn.write(f"RES $content\r\n"); clientIn.flush();
//    case Timeout() => clientIn.write(f"Timeout\r\n"); clientIn.flush();
//    case Fail(code) => clientIn.write(f"FAIL $code\r\n"); clientIn.flush();
//    case _ => close(); throw new Exception("[CM] Error: Unexpected message by Mon");
//  }
//
//  def sendToServer(x: Any): Unit = x match {
//    case Auth(uname, pwd) => serverIn.write(f"AUTH ${uname} ${pwd}"); serverIn.flush();
//    case _ => close(); throw new Exception("[CM] Error: Unexpected message by Mon");
//  }
//
//  def close(): Unit = {
//    serverIn.flush(); clientIn.flush();
//    serverIn.close(); clientIn.close();
//    serverSocket.close(); clientOut.close();
//  }
//}