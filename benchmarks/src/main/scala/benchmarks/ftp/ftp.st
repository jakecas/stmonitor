S_ftp=rec X.( &{
    ?Read(file: String)[util.validateFilename(file)].
        rec R.(!BlockR(blockc: Int, bytes: String)[bytes.length <= 512].&{
            ?AckR(num: Int)[blockc == num].R, ?AckRF().X
        }),
    ?Write(file: String)[util.validateFilename(file)].
        rec W.(?BlockW(blockc: Int, bytes: String)[bytes.length <= 512].+{
            !AckW(num: Int)[blockc == num].W, !AckWF().X
        })
    }
)