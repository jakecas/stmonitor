package monitor.synth

import monitor.interpreter.STInterpreter
import monitor.model._

class SynthMon(sessionTypeInterpreter: STInterpreter, path: String, partialIdentityMon: Boolean) {
  private val mon = new StringBuilder()

  def getMon(): StringBuilder = {
    mon
  }

  private var first = true

  /**
   * Generates the code for declaring a monitor including the imports required for the monitor to compile.
   *
   * @param preamble The contents of the preamble file.
   */
  def startInit(preamble: String): Unit = {
    if (preamble!="") mon.append(preamble+"\n")
    mon.append("\nimport monitor.util.ConnectionManager\nimport scala.concurrent.ExecutionContext\nimport scala.concurrent.duration.Duration\nimport scala.util.control.TailCalls.{TailRec, done, tailcall}\nclass Monitor(cm: ConnectionManager) ")

    mon.append("$, max: Int, report: String => Unit)")

    mon.append("(implicit ec: ExecutionContext, timeout: Duration) extends Runnable {\n")
    mon.append("\tobject payloads {\n")
  }

  /**
   * Generates the code for storing values used from other parts in the monitor.
   *
   * @param label The label of the current statement.
   * @param types A mapping from identifiers to their type.
   */
  def handlePayloads(label: String, types: Map[String, String]): Unit ={
    mon.append("\t\tobject "+label+" {\n")
    for(typ <- types){
      mon.append("\t\t\tvar "+typ._1+": "+typ._2+" = _\n")
    }
    mon.append("\t\t}\n")
  }

  def endInit(): Unit = {
    mon.append("\t}\n")
    mon.append("\toverride def run(): Unit = {\n\t\treport(\"[MONITOR] Monitor started, setting up connection manager\")\n")
    mon.append("\t\tcm.setup()\n")
  }

  /**
   * Generates the code for the external choice type consisting of a single branch: ?Label(payload)[assertion].S
   *
   * @param statement The current statement.
   * @param nextStatement The next statement in the session type.
   * @param isUnique A boolean indicating whether the label of the current statement is unique.
   */
  def handleSend(statement: SendStatement, nextStatement: Statement, isUnique: Boolean): Unit = {
    var reference = statement.label
    if(!isUnique){
      reference = statement.statementID
    }
    if(first){
      mon.append("\t\tsend"+statement.statementID+"(cm)\n    cm.close()\n  }\n")
      first = false
    }

    try {
      mon.append("\tdef send"+statement.statementID+"(cm: ConnectionManager): Unit = {\n")
    } catch {
      case _: Throwable =>
        mon.append("\tdef send"+statement.statementID+"(cm: ConnectionManager): Unit = {\n")
    }

    if(partialIdentityMon){
      mon.append("\t\tcm.receiveFromServer() match {\n")
    } else {
      mon.append("\t\tcm.receive() match {\n")
    }
    mon.append("\t\t\tcase msg @ "+reference+"(")
    addParameters(statement.types)
    mon.append(") =>\n")

    if(statement.condition != null){
      handleCondition(statement.condition, statement.statementID)
      if(partialIdentityMon){
        mon.append("\t\t\t\t\tcm.sendToClient(msg)\n")
      }
      handleSendNextCase(statement, isUnique, nextStatement)
      mon.append("\t\t\t\t} else {\n")
      mon.append("\t\t\t\treport(\"[MONITOR] VIOLATION in Assertion: "+statement.condition+"\"); done() }\n")
    } else {
      if(partialIdentityMon){
        mon.append("\t\t\t\tcm.sendToClient(msg)\n")
      }
      handleSendNextCase(statement, nextStatement)
    }
    mon.append("\t\t\tcase msg @ _ => report(f\"[MONITOR] VIOLATION unknown message: $msg\"); done()\n")
    mon.append("\t\t}\n\t}\n")
  }

  /**
   * Generates the code for the monitor to call the method representing the next statement in the session type after an external choice type.
   *
   * @param currentStatement The current statement.
   * @param nextStatement The next statement in the session type.
   */
  @scala.annotation.tailrec
  private def handleSendNextCase(currentStatement: SendStatement, nextStatement: Statement): Unit ={
    nextStatement match {
      case sendStatement: SendStatement =>
        storeValue(currentStatement.types, currentStatement.condition==null, currentStatement.statementID)
        if(currentStatement.condition==null) {
          mon.append("\t\t\t\tsend" + sendStatement.statementID + "(cm)\n")
        } else {
          mon.append("\t\t\t\t\tsend" + sendStatement.statementID + "(cm)\n")
        }

      case sendChoiceStatement: SendChoiceStatement =>
        storeValue(currentStatement.types, currentStatement.condition==null, currentStatement.statementID)
        if(currentStatement.condition==null) {
          mon.append("\t\t\t\tsend" + sendChoiceStatement.label + "(cm)\n")
        } else {
          mon.append("\t\t\t\t\tsend" + sendChoiceStatement.label + "(cm)\n")
        }

      case receiveStatement: ReceiveStatement =>
        storeValue(currentStatement.types, currentStatement.condition==null, currentStatement.statementID)
        if(currentStatement.condition==null) {
          mon.append("\t\t\t\treceive" + receiveStatement.statementID + "(cm)\n")
        } else {
          mon.append("\t\t\t\t\treceive" + receiveStatement.statementID + "(cm)\n")
        }

      case receiveChoiceStatement: ReceiveChoiceStatement =>
        storeValue(currentStatement.types, currentStatement.condition==null, currentStatement.statementID)
        if(currentStatement.condition==null) {
          mon.append("\t\t\t\treceive" + receiveChoiceStatement.label + "(cm)\n")
        } else {
          mon.append("\t\t\t\t\treceive" + receiveChoiceStatement.label + "(cm)\n")
        }

      case recursiveVar: RecursiveVar =>
        handleSendNextCase(currentStatement, sessionTypeInterpreter.getRecursiveVarScope(recursiveVar).recVariables(recursiveVar.name))

      case recursiveStatement: RecursiveStatement =>
        handleSendNextCase(currentStatement, recursiveStatement.body)

      case _ => return
//        if(currentStatement.condition==null) {
//          mon.append("\t\t\t\tcm.close()\n\t\t\t\tthrow new Exception(f\"[Mon] Received unknown message from server: $e\")")
//        } else {
//          mon.append("\t\t\t\t\tcm.close()\n\t\t\t\t\tthrow new Exception(f\"[Mon] Received unknown message from server: $e\")\n")
//        }
    }
  }

  /**
   * Generates the code for the internal choice type consisting of a single branch: !Label(payload)[assertion].S
   *
   * @param statement The current statement.
   * @param nextStatement The next statement in the session type.
   * @param isUnique A boolean indicating whether the label of the current statement is unique.
   */
  def handleReceive(statement: ReceiveStatement, nextStatement: Statement, isUnique: Boolean): Unit = {
    var reference = statement.label
    if(!isUnique){
      reference = statement.statementID
    }
    if(first) {
      mon.append("\t\treceive" + statement.statementID + "(cm)\n    cm.close()\n  }\n")
      first = false
    }

    mon.append("  def receive" + statement.statementID + "(cm: ConnectionManager): Unit = {\n")
    if(partialIdentityMon){
      mon.append("\t\tcm.receiveClient() match {\n")
    } else {
      mon.append("\t\tcm.receive() match {\n")
    }
    mon.append("\t\t\tcase msg @ " + reference + "(")
    addParameters(statement.types)
    mon.append(")=>\n")
    if(statement.condition != null){
      handleCondition(statement.condition, statement.statementID)
      handleReceiveNextCase(statement, isUnique, nextStatement)
      mon.append("\t\t\t\t} else {\n")
      mon.append("\t\t\t\treport(\"[MONITOR] VIOLATION in Assertion: "+statement.condition+"\"); done() }\n")
    } else {
      handleReceiveNextCase(statement, isUnique, nextStatement)
    }
    mon.append("\t\t\tcase msg @ _ => report(f\"[MONITOR] VIOLATION unknown message: $msg\"); done()\n")
    mon.append("\t\t}\n\t}\n")
  }

  /**
   * Generates the code for the monitor to call the method representing the next statement in the session type after an internal choice type.
   *
   * @param currentStatement The current statement.
   * @param isUnique A boolean indicating whether the label of the current statement is unique.
   * @param nextStatement The next statement in the session type.
   */
  @scala.annotation.tailrec
  private def handleReceiveNextCase(currentStatement: ReceiveStatement, isUnique: Boolean, nextStatement: Statement): Unit ={
    nextStatement match {
      case sendStatement: SendStatement =>
        handleReceiveCases(currentStatement, isUnique)
        storeValue(currentStatement.types, currentStatement.condition==null, currentStatement.statementID)
        if(currentStatement.condition==null) {
          mon.append("\t\t\t\tsend" + sendStatement.statementID + "(cm)\n")
        } else {
          mon.append("\t\t\t\t\tsend" + sendStatement.statementID + "(cm)\n")
        }

      case sendChoiceStatement: SendChoiceStatement =>
        handleReceiveCases(currentStatement, isUnique)
        storeValue(currentStatement.types, currentStatement.condition==null, currentStatement.statementID)
        if(currentStatement.condition==null) {
          mon.append("\t\t\t\tsend" + sendChoiceStatement.label + "(cm)\n")
        } else {
          mon.append("\t\t\t\t\tsend" + sendChoiceStatement.label + "(cm)\n")
        }

      case receiveStatement: ReceiveStatement =>
        handleReceiveCases(currentStatement, isUnique)
        storeValue(currentStatement.types, currentStatement.condition==null, currentStatement.statementID)
        if(currentStatement.condition==null) {
          mon.append("\t\t\t\treceive" + receiveStatement.statementID + "(cm)\n")
        } else {
          mon.append("\t\t\t\t\treceive" + receiveStatement.statementID + "(cm)\n")
        }

      case receiveChoiceStatement: ReceiveChoiceStatement =>
        handleReceiveCases(currentStatement, isUnique)
        storeValue(currentStatement.types, currentStatement.condition==null, currentStatement.statementID)
        if(currentStatement.condition==null) {
          mon.append("\t\t\t\treceive" + receiveChoiceStatement.label + "(cm)\n")
        } else {
          mon.append("\t\t\t\t\treceive" + receiveChoiceStatement.label + "(cm)\n")
        }

      case recursiveVar: RecursiveVar =>
        handleReceiveNextCase(currentStatement, isUnique, sessionTypeInterpreter.getRecursiveVarScope(recursiveVar).recVariables(recursiveVar.name))

      case recursiveStatement: RecursiveStatement =>
        handleReceiveNextCase(currentStatement, isUnique, recursiveStatement.body)

      case _ =>
        if(partialIdentityMon) {
          if (currentStatement.condition == null) {
            mon.append("\t\t\t\tcm.sendToServer(msg);\n")
          } else {
            mon.append("\t\t\t\t\tcm.sendToServer(msg);\n")
          }
        }
    }
  }

  /**
   * Generates the code for forwarding a message over an lchannels channel.
   *
   * @param statement The current statement.
   * @param isUnique A boolean indicating whether the label of the current statement is unique.
   */
  private def handleReceiveCases(statement: ReceiveStatement, isUnique: Boolean): Unit = {
    if(partialIdentityMon) {
      var reference = statement.statementID
      if(isUnique){
        reference = statement.label
      }
      if (statement.condition != null) {
        mon.append("\t\t\t\t\tcm.sendToServer(" + reference + "(")
      } else {
        mon.append("\t\t\t\tcm.sendToServer(" + reference + "(")
      }
      for ((k, v) <- statement.types) {
        if ((k, v) == statement.types.last) {
          mon.append("msg." + k)
        } else {
          mon.append("msg." + k + ", ")
        }
      }
      mon.append("))\n")
    }
  }

  /**
   * Generates the code for the external choice type: &{?Label(payload)[assertion].S, ...}
   *
   * @param statement The current statement.
   */
  def handleSendChoice(statement: SendChoiceStatement): Unit ={
    if(first) {
      mon.append("\t\tsend" + statement.label + "(cm)\n    cm.close()\n  }\n")
      first = false
    }

    mon.append("\tdef send" + statement.label + "(cm: ConnectionManager): Unit = {\n")
    if(partialIdentityMon){
      mon.append("\t\tcm.receiveFromServer() match {\n")
    } else {
      mon.append("\t\tcm.receive() match {\n")
    }

    for (choice <- statement.choices){
      var reference = choice.asInstanceOf[SendStatement].label
      if(!sessionTypeInterpreter.getScope(choice).isUnique){
        reference = choice.asInstanceOf[SendStatement].statementID
      }
      mon.append("\t\t\tcase msg @ "+reference+"(")
      addParameters(choice.asInstanceOf[SendStatement].types)
      mon.append(") =>\n")
      if(choice.asInstanceOf[SendStatement].condition != null){
        handleCondition(choice.asInstanceOf[SendStatement].condition, choice.asInstanceOf[SendStatement].statementID)
        if(partialIdentityMon){
          mon.append("\t\t\t\t\tcm.sendToClient(msg)\n")
        }
        handleSendNextCase(choice.asInstanceOf[SendStatement], choice.asInstanceOf[SendStatement].continuation)
        mon.append("\t\t\t\t} else {\n")
        mon.append("\t\t\t\treport(\"[MONITOR] VIOLATION in Assertion: "+choice.asInstanceOf[SendStatement].condition+"\"); done() }\n")
      } else {
        if(partialIdentityMon){
          mon.append("\t\t\t\tcm.sendToClient(msg)\n")
        }
        handleSendNextCase(choice.asInstanceOf[SendStatement], choice.asInstanceOf[SendStatement].continuation)
      }
    }
    mon.append("\t\t\tcase msg @ _ => report(f\"[MONITOR] VIOLATION unknown message: $msg\"); done()\n")
    mon.append("\t\t}\n\t}\n")
  }

  /**
   * Generates the code for the internal choice type: +{!Label(payload)[assertion].S, ...}
   *
   * @param statement The current statment.
   */
  def handleReceiveChoice(statement: ReceiveChoiceStatement): Unit = {
    if(first) {
      mon.append("\t\treceive" + statement.label + "(cm)\n    cm.close()\n  }\n")
      first = false
    }

    mon.append("\tdef receive" + statement.label + "(cm: ConnectionManager): Unit = {\n")
    if(partialIdentityMon){
      mon.append("\t\tcm.receiveFromClient() match {\n")
    } else {
      mon.append("\t\tcm.receive() match {\n")
    }

    for (choice <- statement.choices){
      var reference = choice.asInstanceOf[ReceiveStatement].label
      if(!sessionTypeInterpreter.getScope(choice).isUnique){
        reference = choice.asInstanceOf[ReceiveStatement].statementID
      }
      mon.append("\t\t\tcase msg @ " + reference + "(")
      addParameters(choice.asInstanceOf[ReceiveStatement].types)
      mon.append(")=>\n")
      if(choice.asInstanceOf[ReceiveStatement].condition != null){
        handleCondition(choice.asInstanceOf[ReceiveStatement].condition, choice.asInstanceOf[ReceiveStatement].statementID)
        handleReceiveNextCase(choice.asInstanceOf[ReceiveStatement], true, choice.asInstanceOf[ReceiveStatement].continuation)
        mon.append("\t\t\t\t} else {\n")
        mon.append("\t\t\t\treport(\"[MONITOR] VIOLATION in Assertion: "+choice.asInstanceOf[ReceiveStatement].condition+"\"); done() }\n")
      } else {
        handleReceiveNextCase(choice.asInstanceOf[ReceiveStatement], true, choice.asInstanceOf[ReceiveStatement].continuation)
      }
    }
    mon.append("\t\t\tcase msg @ _ => report(f\"[MONITOR] VIOLATION unknown message: $msg\"); done()\n")
    mon.append("\t\t}\n\t}\n")
  }

  /**
   * Generates the parameters for the statements depending on the payload size.
   *
   * @param types A mapping from identifiers to their type.
   */
  private def addParameters(types: Map[String, String]): Unit ={
    for (typ <- types) {
      if(typ == types.last){
        mon.append("_")
      } else {
        mon.append("_, ")
      }
    }
  }

  /**
   * Generates the code for storing a value in the respective identifier object within the monitor.
   *
   * @param types A mapping from identifiers to their type.
   * @param checkCondition A boolean indicating whether current statement has a condition.
   * @param curStatementScope The label of the current statement used to retrieve identifier
   *                          information from the interpreter.
   */
  private def storeValue(types: Map[String, String], checkCondition: Boolean, curStatementScope: String): Unit = {
    for((name, _) <- types) {
      val (varScope, (global, _)) = sessionTypeInterpreter.getVarInfo(name, curStatementScope)
      if(global) {
        if(checkCondition){
          mon.append("\t\t\t\tpayloads."+varScope+"."+name+" = msg."+name+"\n")
        } else {
          mon.append("\t\t\tpayloads."+varScope+"."+name+" = msg."+name+"\n")
        }
      }
    }
  }

  /**
   * Generates the code for conditions by identifying identifiers and changing them for the
   * respective variable within the monitor.
   *
   * @param condition Condition in String format.
   * @param label The label of the current statment.
   */
  private def handleCondition(condition: String, label: String): Unit ={
    mon.append("\t\t\t\tif(")
    var stringCondition = condition
    val identifierNames = sessionTypeInterpreter.getIdentifiers(condition)
    for(identName <- identifierNames){
      val varScope = sessionTypeInterpreter.searchIdent(label, identName)
      val identPattern = ("\\b"+identName+"\\b").r
      if(label == varScope){
        stringCondition = identPattern.replaceAllIn(stringCondition, "msg."+identName)
      } else {
        stringCondition = identPattern.replaceAllIn(stringCondition, "payloads."+varScope+"."+identName)
      }
    }
    mon.append(stringCondition+"){\n")
  }

  def end(): Unit = {
    mon.append("}")
  }
}
