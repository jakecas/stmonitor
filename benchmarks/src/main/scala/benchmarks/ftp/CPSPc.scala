package benchmarks.ftp

import lchannels.{In, Out}
sealed abstract class ExternalChoice2
case class Read(file: String)(val cont: Out[BlockR]) extends ExternalChoice2
case class BlockR(blockc: Int, bytes: String)(val cont: Out[ExternalChoice1])
sealed abstract class ExternalChoice1
case class AckR(num: Int)(val cont: Out[BlockR]) extends ExternalChoice1
case class AckRF()(val cont: In[ExternalChoice2]) extends ExternalChoice1
case class Write(file: String)(val cont: In[BlockW]) extends ExternalChoice2
case class BlockW(blockc: Int, bytes: String)(val cont: Out[InternalChoice1])
sealed abstract class InternalChoice1
case class AckW(num: Int)(val cont: Out[BlockW]) extends InternalChoice1
case class AckWF()(val cont: Out[ExternalChoice2]) extends InternalChoice1
