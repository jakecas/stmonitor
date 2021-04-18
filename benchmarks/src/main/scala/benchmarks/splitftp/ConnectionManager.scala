package benchmarks.ftp

import java.io._
import java.net.{ServerSocket, Socket}

class ConnectionManager(var serverPort: Int, var clientPort: Int) {
  var serverIn: BufferedWriter = _; var clientIn: BufferedWriter = _;
  var serverOut: BufferedReader = _; var clientOut: BufferedReader = _;

  val serverSocket = new Socket("127.0.0.1", serverPort)
  val clientSocket = new ServerSocket(clientPort)

  private val readR = """^READ +(.+)""".r
  private val blockrR = """^BLOCKR ([0-9]+) ([0-9]+) ([\S\s]+)""".r
  private val ackrR = """^ACKR +(.+)""".r
  private val ackrfR = """^ACKRF""".r

  private val writeR = """^WRITE +(.+)""".r
  private val blockwR = """^BLOCKW ([0-9]+) ([0-9]+) ([\S\s]+)""".r
  private val ackwiR = """^ACKWI""".r
  private val ackwR = """^ACKW +(.+)""".r
  private val ackwfR = """^ACKWF""".r

  private val closeR = """^CLOSE""".r

  def setup(): Unit = {
    val client = clientSocket.accept();
    println(f"[CM] Waiting for requests from Client on ${clientPort} and connected to Server on ${serverPort}")
    serverIn = new BufferedWriter(new OutputStreamWriter(serverSocket.getOutputStream))
    serverOut = new BufferedReader(new InputStreamReader(serverSocket.getInputStream))
    clientIn = new BufferedWriter(new OutputStreamWriter(client.getOutputStream))
    clientOut = new BufferedReader(new InputStreamReader(client.getInputStream))
  }

  def receiveFromClient(): Any = clientOut.readLine() match {
    case readR(filename) => println("[CM] Received READ"); Read(filename);
    case writeR(filename) => println("[CM] Received WRITE"); Write(filename);
    case blockwR(c, size, data) =>
      println(f"[CM] Received BLOCKW ${c} ${size} ${data}")
      var fulldata = data
      while(fulldata.length < size.toInt)
        fulldata += "\n" + clientOut.readLine()
      BlockW(c.toInt, size.toInt, fulldata)
    case ackrR(c) => println(f"[CM] Received ACKR ${c}"); AckR(c.toInt);
    case ackrfR() => println("[CM] Received ACKRF"); AckRF();
    case closeR() => println("[CM] Received CLOSE"); Close();
    case e => e
  }

  def receiveFromServer(): Any = serverOut.readLine() match {
    case blockrR(c, size, data) =>
      println(f"[CM] Received BLOCKR ${c} ${size}")
      var fulldata = data
      while(fulldata.length < size.toInt)
        fulldata += "\n" + serverOut.readLine()
      BlockR(c.toInt, size.toInt, fulldata);
    case ackwiR() => println("[CM] Received ACKWI"); AckWI();
    case ackwR(c) => println(f"[CM] Received ACKW ${c}"); AckW(c.toInt);
    case ackwfR() => println("[CM] Received ACKWF"); AckWF();
    case e => e
  }

  def sendToClient(x: Any): Unit = x match {
    case BlockR(c, size, data) => clientIn.write(f"BLOCKR ${c} ${size} ${data}"); clientIn.flush()
    case AckWI() => clientIn.write(f"ACKWI"); clientIn.flush()
    case AckW(c) => clientIn.write(f"ACKW ${c}"); clientIn.flush()
    case AckWF() => clientIn.write(f"ACKWF"); clientIn.flush()
    case _ => close(); throw new Exception("[CM] Error: Unexpected message by Mon");
  }

  def sendToServer(x: Any): Unit = x match {
    case Write(filename) => serverIn.write(f"WRITE ${filename}"); serverIn.flush()
    case Read(filename) => serverIn.write(f"READ ${filename}"); serverIn.flush()
    case BlockW(c, size, data) => serverIn.write(f"BLOCKW ${c} ${size} ${data}"); serverIn.flush()
    case AckR(c) => serverIn.write(f"ACKR ${c}"); serverIn.flush()
    case AckRF() => serverIn.write(f"ACKRF"); serverIn.flush()
    case Close() => serverIn.write(f"CLOSE"); serverIn.flush()
    case _ => close(); throw new Exception("[CM] Error: Unexpected message by Mon");
  }

  def close(): Unit = {
    serverIn.flush(); clientIn.flush();
    serverIn.close(); clientIn.close();
    serverSocket.close(); clientOut.close();
  }
}