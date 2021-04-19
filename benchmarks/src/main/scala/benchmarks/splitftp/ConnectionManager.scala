package benchmarks.splitftp

import java.io._
import java.net.{ServerSocket, Socket}

class ConnectionManager(var port: Int) {
  var monOut: BufferedReader = _;

  val monSocket = new ServerSocket(port)

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
    val mon = monSocket.accept();
    println(f"[CM] Waiting for requests on ${port}")
    monOut = new BufferedReader(new InputStreamReader(mon.getInputStream))
  }

  def receive(): Any = monOut.readLine() match {
    case readR(filename) => println("[CM] Received READ"); Read(filename);
    case writeR(filename) => println("[CM] Received WRITE"); Write(filename);
    case blockwR(c, size, data) =>
      println(f"[CM] Received BLOCKW ${c} ${size} ${data}")
      var fulldata = data
      while(fulldata.length < size.toInt)
        fulldata += "\n" + monOut.readLine()
      BlockW(c.toInt, size.toInt, fulldata);
    case blockwnR(c, size) =>
      var data = ""
      if(size.toInt == 1){
        data = "\n"
      } else {
        while (data.length < size.toInt) {
          data += "\n" + monOut.readLine()
        }
      }
      println(f"[CM] Received BLOCKW ${c} ${size} ${data}")
      BlockW(c.toInt, size.toInt, data);
    case ackrR(c) => println(f"[CM] Received ACKR ${c}"); AckR(c.toInt);
    case ackrfR() => println("[CM] Received ACKRF"); AckRF();
    case closeR() => println("[CM] Received CLOSE"); Close();
    case blockrR(c, size, data) =>
      println(f"[CM] Received BLOCKR ${c} ${size} ${data}")
      var fulldata = data
      while(fulldata.length < size.toInt)
        fulldata += "\n" + monOut.readLine()
      BlockR(c.toInt, size.toInt, fulldata);
    case blockrnR(c, size) =>
      var data = ""
      if(size.toInt == 1){
        data = "\n"
      } else {
        while (data.length < size.toInt) {
          data += "\n" + monOut.readLine()
        }
      }
      println(f"[CM] Received BLOCKR ${c} ${size} ${data}")
      BlockR(c.toInt, size.toInt, data);
    case ackwiR() => println("[CM] Received ACKWI"); AckWI();
    case ackwR(c) => println(f"[CM] Received ACKW ${c}"); AckW(c.toInt);
    case ackwfR() => println("[CM] Received ACKWF"); AckWF();
    case e => e
  }

  def close(): Unit = {
    monSocket.close(); monOut.close();
  }
}