import std/[os,strutils,pegs,json,strformat]
let tbl = @[
(1,1,"arm-none-eabi-gcc",""),
(1,1,"avr-gcc",""),
(1,1,"choosenim",""),
(1,1,"clang",""),
(1,1,"cmake",""),
(1,1,"csc",""),
(1,1,"ctags",""),
(1,1,"fbc",""),
(1,1,"ffmpeg",""),
(1,1,"fpc","-iV"),
(1,1,"gcc",""),
(1,1,"git",""),
(1,1,"global",""),
(1,1,"go","version"),
(1,1,"java","-version"),
(1,1,"javac","-version"),
(1,1,"julia",""),
(1,1,"luajit","-v"),
(1,1,"lua54","-v"),
(1,1,"make",""),
(1,1,"meson",""),
(1,1,"nim",""),
(1,1,"nimble",""),
(1,1,"nimv",""),
(1,1,"ninja",""),
(1,1,"node",""),
(1,1,"pandoc",""),
(1,2,"perl",""),
(1,1,"platformio",""),
(1,1,"python",""),
(1,1,"riscv-nuclei-elf-gcc",""),
(1,1,"ruby",""),
(1,1,"rustc",""),
(1,1,"rustup",""),
(1,2,"scons",""),
(0,1,"vim",""),
(1,1,"zig","version"),
(1,1,"zig cc","")
]
#                         0    1    2     3
proc convToJson(tbl:seq[(int,int,string,string)]) =
    var sOut:seq[string]
    sOut.add  """{
"maxCol":76,
"cmdList":["""
    for line in tbl:
        let cmd      = line[2].strip
        let sCmd     = fmt"""{cmd:<20}"""
        let spc      = fmt"""{" ":10}"""
        let sbEnable = $line[0]
        let siVerRow = $line[1]
        if line[3].len == 0:
            sOut.add """  {"enable":$#, "verRow":$#, "cmd":"$#", "cmdVersion":"$#", "comment":""},""" % [sbEnable,siVerRow,sCmd,spc]
        else:
            let sCmdVer = fmt"""{line[3].strip:<10}"""
            sOut.add """  {"enable":$#, "verRow":$#, "cmd":"$#", "cmdVersion":"$#", "comment":""},""" % [sbEnable,siVerRow,sCmd,sCmdVer]
    sOut.add "]}"
    writeFile("gv.json",sOut.join("\n"))
    echo "\nconv.nimsでgv.jsonを上書きしました\n"



let gv_json ="""
"""

let testJson = """{"key":"cont1"}"""
proc parseJsonList(fname:string) =
    let jnode = parseJson(readfile(fname))
    #let jnode = parseJson(gv_json)
    for elm in jnode["cmdList"].items:
        echo "[$#]-[$#]-[$#]" % [elm["cmd"].getStr
                                ,elm["cmdVersion"].getStr
                                ,elm["comment"].getStr]
proc fmtTest() =
    let x = 56
    # { "cmd":"$#",  "cmdVersion":"", "enable":"true", "comment":""},
    let sCmd = fmt"""{"ls":<10}"""
    let spc = ""
    echo """  "$#"  """ % [sCmd]
    echo fmt"""
    {{ "cmd":{sCmd} }}
    """

proc main() =
    convToJson(tbl)
#    parseJsonList("gv.json")
#    fmtTest()


main()
