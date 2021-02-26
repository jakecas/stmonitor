package examples.generate.login

import monitor.synth.Synth

object Generate {
  def main(args: Array[String]): Unit = {
    val synth = new Synth()
    synth.apply(args(0), "login.st", synthMonFile = true, synthProtocolFile = true)
  }
}
