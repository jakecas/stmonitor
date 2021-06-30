# STMonitor - Modified Session Types Monitor Synthesiser

This code is hosted on github at the following URL: https://github.com/jakecas/stmonitor, where the master branch leaves everything untouched (is a direct clone of the original project), and the develop branch represents our work in 'An Evaluation of Monitor Configurations for Binary Session Types in Scala'.

Given a session type _S_, this tool will synthesize a partial-identity monitor or a sequence recogniser depending on the parameter given. 
See monitor/Generate for this usage. It will also generate any classes necessary for the monitors.

Before modification, this synthesizer used to assume that one side of the binary system is known at compile-time and could thus be type-checked,
however our version makes no such assumptions and thus needs the ConnectionManager class to allow communication with both client and server.

Monitors and ProtocolClasses have been generated for your convenience, however this can easily be done again by following these steps:

1. Run `sbt compile` in the base directory, where you found this README.
2. Run `sbt "project monitor" "runMain monitor.Generate /path/to/dir/of/example/ /path/to/dir/of/example/example.st"`
    Note that the ftp and splitftp examples require the package statement in their respective util.scala files to be commented. 
    And each of the generated classes will need their package statements added manually.
3. Once all have been synthesized, you can assemble a jar file with `sbt assembly`.
4. And then run the benchmark scripts found in scripts/. 
    Note that the ftp python scripts have some hard coded directory paths that will need to be changed. 
    Execution can be halted with Ctrl+C, but ensure that no processes remain by running `ps` and killing them.

To instead run without generating the jar file, you can use `sbt "project examples" "runMain examples.auth.MonRunner"`,
but this will require manually starting each of the client, server, and monitor. Follow the examples in the benchmark scripts to see how this is done.