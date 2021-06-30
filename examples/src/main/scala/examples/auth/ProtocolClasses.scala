package examples.auth

case class Auth(uname: String, pwd: String)
sealed abstract class ExternalChoice2
case class Succ(origTok: String) extends ExternalChoice2
sealed abstract class InternalChoice1
case class Get(resource: String, reqTok: String) extends InternalChoice1
sealed abstract class ExternalChoice1
case class Res(content: String) extends ExternalChoice1
case class Timeout() extends ExternalChoice1
case class Rvk(rvkTok: String) extends InternalChoice1
case class Fail(code: Int) extends ExternalChoice2
