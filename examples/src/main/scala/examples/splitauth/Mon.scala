package examples.splitauth

import scala.concurrent.ExecutionContext
import scala.concurrent.duration.Duration

class Mon(cm: ConnectionManager)(implicit ec: ExecutionContext, timeout: Duration) extends Runnable {
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
		cm.receive() match {
			case msg @ Auth(_, _)=>
				if(util.validateUname(msg.uname)){
					payloads.Auth_3.uname = msg.uname
					sendInternalChoice1(cm)
				} else {
					cm.close()
					throw new Exception("[Mon] Validation failed!")
				}
			case e => 
				cm.close()
				throw new Exception(f"[Mon] Received unknown message from client: $e")
		}
	}
	def sendInternalChoice1(cm: ConnectionManager): Unit = {
		cm.receive() match {
			case msg @ Succ(_) =>
				if(util.validateTok(msg.tok, payloads.Auth_3.uname)){
					println("[Mon] Authenticated! ")
				} else {
					cm.close()
					throw new Exception("[Mon] Validation failed!")
				}
			case msg @ Fail(_) =>
				receiveAuth_3(cm)
			case e => 
				cm.close()
				throw new Exception(f"[Mon] Received unknown message from server: $e")
		}
	}
}