//package examples.splitauth
//
//import java.io._
//import java.net.{ServerSocket}
//
//class ConnectionManager(var port: Int) {
//  var monIn: BufferedReader = _; var monOut: BufferedWriter = _;
//
//  val socket = new ServerSocket(port)
//
//  private val authR = """AUTH (.+) (.+)""".r
//  private val succR = """SUCC (.+)""".r
//  private val failR = """FAIL (.+)""".r
//
//  def setup(): Unit = {
//    val client = socket.accept();
//    println(f"[CM] Waiting for requests from on ${port}")
//    monOut = new BufferedWriter(new OutputStreamWriter(client.getOutputStream))
//    monIn = new BufferedReader(new InputStreamReader(client.getInputStream))
//  }
//
//  def receive(): Any = monIn.readLine() match {
////    case authR(uname, pwd) => println("[CM] Received Auth"); Auth(uname, pwd);
////    case succR(tok) => println("[CM] Received Success"); Succ(tok);
////    case failR(code) => println("[CM] Received Failure"); Fail(code.toInt);
//    case e => e
//  }
//
////  def send(x: Any): Unit = x match {
////    case Auth(uname, pwd) => monOut.write(f"AUTH ${uname} ${pwd}"); monOut.flush();
////    case Succ(tok) => monOut.write(f"SUCC ${tok}"); monOut.flush();
////    case Fail(code) => monOut.write(f"FAIL ${code}"); monOut.flush();
////    case _ => close(); throw new Exception("[CM] Error: Unexpected message by Mon");
////  }
//
//  def close(): Unit = {
//    monOut.flush(); monOut.close();
//    socket.close();
//  }
//}