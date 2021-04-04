package benchmarks.ftp

import scala.concurrent.ExecutionContext
import scala.concurrent.duration.Duration

class Mon(cm: ConnectionManager)(implicit ec: ExecutionContext, timeout: Duration) extends Runnable {
	object payloads {
		object Read_4 {
			var file: String = _
		}
		object BlockR_3 {
			var blockc: Int = _
			var bytes: String = _
		}
		object AckR_1 {
			var num: Int = _
		}
		object AckRF_2 {
		}
		object Write_8 {
			var file: String = _
		}
		object BlockW_7 {
			var blockc: Int = _
			var bytes: String = _
		}
		object AckW_5 {
			var num: Int = _
		}
		object AckWF_6 {
		}
	}
	override def run(): Unit = {
    println("[Mon] Monitor started")
    println("[Mon] Setting up connection manager")
		cm.setup()
		receiveExternalChoice2(cm)
    cm.close()
  }
	def receiveExternalChoice2(cm: ConnectionManager): Unit = {
		cm.receiveFromClient() match {
			case msg @ Read(_)=>
				if(util.validateFilename(msg.file)){
					cm.sendToServer(Read(msg.file))
					sendBlockR_3(cm)
				} else {
				cm.close()
				throw new Exception("[Mon] Validation failed!")
			}
			case msg @ Write(_)=>
				if(util.validateFilename(msg.file)){
					cm.sendToServer(Write(msg.file))
					receiveBlockW_7(cm)
				} else {
				cm.close()
				throw new Exception("[Mon] Validation failed!")
			}
			case e => 
				cm.close()
				throw new Exception(f"[Mon] Received unknown message from client: $e")
		}
	}
	def sendBlockR_3(cm: ConnectionManager): Unit = {
		cm.receiveFromServer() match {
			case msg @ BlockR(_, _) =>
				if(msg.bytes.length <= 512){
					cm.sendToClient(msg)
					payloads.BlockR_3.blockc = msg.blockc
					receiveExternalChoice1(cm)
				} else {
					cm.close()
					throw new Exception("[Mon] Validation failed!")
				}
			case e => 
				cm.close()
				throw new Exception(f"[Mon] Received unknown message from server: $e")		}
	}
	def receiveExternalChoice1(cm: ConnectionManager): Unit = {
		cm.receiveFromClient() match {
			case msg @ AckR(_)=>
				if(payloads.BlockR_3.blockc == msg.num){
					cm.sendToServer(AckR(msg.num))
					sendBlockR_3(cm)
				} else {
				cm.close()
				throw new Exception("[Mon] Validation failed!")
			}
			case msg @ AckRF()=>
				cm.sendToServer(AckRF())
				receiveExternalChoice2(cm)
			case e => 
				cm.close()
				throw new Exception(f"[Mon] Received unknown message from client: $e")
		}
	}
  def receiveBlockW_7(cm: ConnectionManager): Unit = {
		cm.receiveFromClient() match {
			case msg @ BlockW(_, _)=>
				if(msg.bytes.length <= 512){
					cm.sendToServer(BlockW(msg.blockc, msg.bytes))
					payloads.BlockW_7.blockc = msg.blockc
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
		cm.receiveFromServer() match {
			case msg @ AckW(_) =>
				if(payloads.BlockW_7.blockc == msg.num){
					cm.sendToClient(msg)
					receiveBlockW_7(cm)
				} else {
					cm.close()
					throw new Exception("[Mon] Validation failed!")
				}
			case msg @ AckWF() =>
				cm.sendToClient(msg)
				receiveExternalChoice2(cm)
			case e => 
				cm.close()
				throw new Exception(f"[Mon] Received unknown message from server: $e")
		}
	}
}