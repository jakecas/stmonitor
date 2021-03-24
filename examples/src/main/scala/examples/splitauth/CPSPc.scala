package examples.splitauth

case class Auth(uname: String, pwd: String)
sealed abstract class InternalChoice1
case class Succ(tok: String) extends InternalChoice1
case class Fail(code: Int) extends InternalChoice1
