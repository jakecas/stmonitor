package examples.auth

import scala.concurrent.ExecutionContext
import scala.concurrent.duration.Duration
import scala.util.control.TailCalls.{TailRec, done, tailcall}
class Mon(cm: ConnectionManager, max: Int)(implicit ec: ExecutionContext, timeout: Duration) extends Runnable {
	object payloads {
		object Auth_3 {
			var uname: String = _
			var pwd: String = _
		}
		object Succ_1 {
			var tok: String = _
		}
		object Fail_2 {
			var Code: Int = _
		}
	}
	override def run(): Unit = {
    println("[Mon] Monitor started")
    println("[Mon] Setting up connection manager")
		cm.setup()
		receiveAuth_3(cm)
    cm.close()
  }
  def receiveAuth_3(cm: ConnectionManager): Unit = {
		cm.receiveFromClient() match {
			case msg @ Auth(_, _)=>
				println("[Mon] Received an Auth")
				if(util.validateUname(msg.uname)){
					println("[Mon] Forwarding to server")
					cm.sendToServer(Auth(msg.uname, msg.pwd))
					payloads.Auth_3.uname = msg.uname
					println("[Mon] Waiting for a response...")
					sendInternalChoice1(cm)
				} else {
					cm.close()
					throw new Exception("[Mon] Invalid username!")
				}
			case e =>
				cm.close()
				throw new Exception(f"[Mon] Received unknown message from client: $e")
		}
	}
	def sendInternalChoice1(cm: ConnectionManager): Unit = {
		cm.receiveFromServer() match {
			case msg @ Succ(_) =>
				println("[Mon] Received a Success message")
				if(util.validateTok(msg.tok, payloads.Auth_3.uname)){
					cm.sendToClient(msg)
				} else {
					cm.close()
					throw new Exception("[Mon] Invalid token!")
				}
			case msg @ Fail(_) =>
				println("[Mon] Received a Failure message")
				cm.sendToClient(msg)
				println("[Mon] Waiting for an Auth...")
				receiveAuth_3(cm)
			case e =>
				cm.close()
				throw new Exception(f"[Mon] Received unknown message from server: $e")
		}
	}
}