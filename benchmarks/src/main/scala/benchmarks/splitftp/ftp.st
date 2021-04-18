S_ftp=rec X.( &{
    ?Read(file: String)[util.validateFilename(file)].
        rec R.(!BlockR(blockc: Int, size: Int, bytes: String)[bytes.length == size && size <= 512].&{
            ?AckR(num: Int)[blockc == num].R, ?AckRF().X
        }),
    ?Write(file: String)[util.validateFilename(file)].!AckWI().
        rec W.(?BlockW(blockc: Int, size: Int, bytes: String)[bytes.length == size && size <= 512].+{
            !AckW(num: Int)[blockc == num].W, !AckWF().X
        }),
    ?Close()
    }
)