package examples.ftp

sealed abstract class ExternalChoice2
case class Read(file: String) extends ExternalChoice2
case class BlockR(blockc: Int, size: Int, bytes: String)
sealed abstract class ExternalChoice1
case class AckR(num: Int) extends ExternalChoice1
case class AckRF() extends ExternalChoice1
case class Write(file: String) extends ExternalChoice2
case class AckWI()
case class BlockW(blockc: Int, size: Int, bytes: String)
sealed abstract class InternalChoice1
case class AckW(num: Int) extends InternalChoice1
case class AckWF() extends InternalChoice1
case class Close() extends ExternalChoice2
