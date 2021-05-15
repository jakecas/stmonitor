package examples.splitauth

import java.io._
import java.net.{ServerSocket, Socket}

class ConnectionManager(var monSocket: ServerSocket) {
  var monOut: BufferedReader = _;
  var mon : Socket = _;

  private val authR = """AUTH (.+) (.+)""".r
  private val getR = """GET (.+) (.+)""".r
  private val rvkR = """RVK (.+)""".r
  private val succR = """SUCC (.+)""".r
  private val failR = """FAIL (.+)""".r
  private val resR = """RES (.+)""".r
  private val timeoutR = """Timeout""".r

  def setup(): Unit = {
    mon = monSocket.accept();
    println(f"[CM] Waiting for requests")
    monOut = new BufferedReader(new InputStreamReader(mon.getInputStream))
  }

  def receive(): Any = monOut.readLine() match {
    case authR(uname, pwd) => Auth(uname, pwd);
    case getR(resource, tok) => Get(resource, tok);
    case rvkR(tok) => Rvk(tok);
    case succR(tok) => Succ(tok);
    case failR(code) => Fail(code.toInt);
    case resR(content) => Res(content);
    case timeoutR() => Timeout();
    case e => e
  }

  def close(): Unit = {
    monOut.close();
    // Socket needs to be closed outside, after all iterations have been run.
  }
}