package examples.ftp

import java.io._
import java.net.{ServerSocket, Socket}

class ConnectionManager(var serverPort: Int, var clientPort: Int) {
  var serverIn: BufferedWriter = _; var clientIn: BufferedWriter = _;
  var serverOut: BufferedReader = _; var clientOut: BufferedReader = _;

  val serverSocket = new Socket("127.0.0.1", serverPort)
  val clientSocket = new ServerSocket(clientPort)

  private val readR = """^READ +(.+)""".r
  private val blockrR = """^BLOCKR ([0-9]+) ([0-9]+) ([\S\s]+)""".r
  private val blockrnR = """^BLOCKR ([0-9]+) ([0-9]+) """.r
  private val ackrR = """^ACKR +(.+)""".r
  private val ackrfR = """^ACKRF""".r

  private val writeR = """^WRITE +(.+)""".r
  private val blockwR = """^BLOCKW ([0-9]+) ([0-9]+) ([\S\s]+)""".r
  private val blockwnR = """^BLOCKW ([0-9]+) ([0-9]+) """.r
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
    case readR(filename) => Read(filename);
    case writeR(filename) => Write(filename);
    case blockwR(c, size, data) =>
      var fulldata = data
      while(fulldata.length < size.toInt)
        fulldata += "\n" + clientOut.readLine()
      BlockW(c.toInt, size.toInt, fulldata);
    case blockwnR(c, size) =>
      var data = ""
      if(size.toInt == 1){
        data = "\n"
      } else {
        while (data.length < size.toInt) {
          data += "\n" + clientOut.readLine()
        }
      }
      BlockW(c.toInt, size.toInt, data);
    case ackrR(c) => AckR(c.toInt);
    case ackrfR() => AckRF();
    case closeR() => Close();
    case e => e
  }

  def receiveFromServer(): Any = serverOut.readLine() match {
    case blockrR(c, size, data) =>
      var fulldata = data
      while(fulldata.length < size.toInt)
        fulldata += "\n" + serverOut.readLine()
      BlockR(c.toInt, size.toInt, fulldata);
    case blockrnR(c, size) =>
      var data = ""
      if(size.toInt == 1){
        data = "\n"
      } else {
        while (data.length < size.toInt) {
          data += "\n" + serverOut.readLine()
        }
      }
      BlockR(c.toInt, size.toInt, data);
    case ackwiR() => AckWI();
    case ackwR(c) => AckW(c.toInt);
    case ackwfR() => AckWF();
    case e => e
  }

  def sendToClient(x: Any): Unit = x match {
    case BlockR(c, size, data) => clientIn.write(f"BLOCKR ${c} ${size} ${data}\n"); clientIn.flush();
    case AckWI() => clientIn.write(f"ACKWI\n"); clientIn.flush();
    case AckW(c) => clientIn.write(f"ACKW ${c}\n"); clientIn.flush();
    case AckWF() => clientIn.write(f"ACKWF\n"); clientIn.flush();
    case _ => close(); throw new Exception("[CM] Error: Unexpected message by Mon");
  }

  def sendToServer(x: Any): Unit = x match {
    case Write(filename) => serverIn.write(f"WRITE ${filename}\n"); serverIn.flush();
    case Read(filename) => serverIn.write(f"READ ${filename}\n"); serverIn.flush();
    case BlockW(c, size, data) => serverIn.write(f"BLOCKW ${c} ${size} ${data}\n"); serverIn.flush();
    case AckR(c) => serverIn.write(f"ACKR ${c}\n"); serverIn.flush();
    case AckRF() => serverIn.write(f"ACKRF\n"); serverIn.flush();
    case Close() => serverIn.write(f"CLOSE\n"); serverIn.flush();
    case _ => close(); throw new Exception("[CM] Error: Unexpected message by Mon");
  }

  def close(): Unit = {
    serverIn.flush(); clientIn.flush();
    serverIn.close(); clientIn.close();
    serverSocket.close(); clientOut.close();
  }
}