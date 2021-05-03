package examples.splitftp

sealed abstract class InternalChoice2
case class Read(file: String) extends InternalChoice2
case class BlockR(blockc: Int, size: Int, bytes: String)
sealed abstract class InternalChoice1
case class AckR(num: Int) extends InternalChoice1
case class AckRF() extends InternalChoice1
case class Write(file: String) extends InternalChoice2
case class AckWI()
case class BlockW(blockc: Int, size: Int, bytes: String)
sealed abstract class ExternalChoice1
case class AckW(num: Int) extends ExternalChoice1
case class AckWF() extends ExternalChoice1
case class Close() extends InternalChoice2
