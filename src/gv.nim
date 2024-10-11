# 2022/11 nim-1.6.10 nimスクリプトに変更
# 2022/10 nim-1.6.8,# 2021/11 made by audin
# Nim verion: nim-1.4.0 or later

# gv.exe時のコマンド引数インデックス (x)
#    0             1  : paramCount() = ParamOffset
#   (0)           (1) : paramStr(x)
# > gv.exe      -h or cmd

# スクリプト時のコマンド引数インデックス (x)
#    0        1                   2  : paramCount()    3   = ParamOffset
#   (0)      (1)                 (2) : paramStr(x)    (3)
# > nim     --hint:Conf:off       gv.nims             -h or cmd
# (It needs 'mv gv.nim gv.nims' if it executes as nimscript.)

{.hint[QuitCalled]: off.}
import pegs
var fDebug = false
const NimScript = false
when NimScript:
  import std/[strformat]
  const ParamOffset = 3
  # > nim --hint:Conf:off gv.nims # 通常の実行方法
  when (NimMajor, NimMinor, NimPatch) < (1, 4, 0): # ???
    echo "\n#---* \ngv: Error: Nim verion : \n    It needs nim-1.4.0 or later \n#---*\n"
    quit 1
  proc execCmdLocal(cmd: string): (string, int) = gorgeEx(cmd)
else:
  import std/[osproc]
  const ParamOffset = 1
  # > gv # 通常の実行方法
  proc execCmdLocal(cmd: string): (string, int) =
    if fDebug: echo cmd
    execCmdEx(cmd, options = {poStdErrToStdOut, poUsePath}) # poStdErrToStdOutは必須

import std/[os, strutils, json, strformat]

let sHelp = """
gv: Show version info command
        v2.0 (2022/12) from 2022/11 by audin
Usage:
    gv[.exe] [Option] [cmd]
       Option:
            no argument : Show all versions of commands.
            cmd  : Command eg. 'gcc', 'clang'.  Only show version info specified by 'cmd'.
            -i   : Show folder name that the command exists.
            -h, /?, /h, -v, --version: Show help.
    gv.json:
        Editable command list"""

var noneList: seq[string]
var fShowExePath = false

proc execVersionCommand(cmd, sOptVersion: string, verRow,
    maxCol: int): bool = # true: success , false: fail
  result = true
  var sCmd = findExe(cmd)
  if sCmd.len == 0:
    noneList.add(cmd) # なしリストに追加
    return false
  sCmd = if sOptVersion.len == 0:
           [sCmd, "--version"].join(" ") # 無指定の場合はこれ
         else:
           [sCmd, sOptVersion].join(" ")
  let (sOut, _) = execCmdLocal(sCmd)
  let seqVers = sOut.splitlines()        # 出力結果をseqに変換
  var sVer = seqVers[verRow - 1].strip   # version情報がある行を取得
  let sPeg = &r"\s*'{cmd.toLower}'.+"
  if not (sVer.toLower =~ sPeg.peg):     # バージョン情報の先頭にコマンド名がないならコマンド名を先頭に追加
    sVer = [cmd, sVer].join(": ")
  sVer = sVer.capitalizeAscii()
  if sVer.len >= maxCol:
    echo "- ", sVer[0..maxCol - 1]       # 表示桁数制限
  else:
    echo "- ", sVer                      # md対応: Version行を表示
  block:                                 # "コマンドが存在するフォルダ名"を表示するかどうか
    if fShowExePath and ("" != findExe("which")):    # whichコマンドがあれば
      let (sOut, res) = execCmdLocal("which " & cmd) #実行して結果を表示
      if res == 0:
        echo "   - ", sOut.split("\n")[0]            # md対応

#--------
# main()
#--------
proc main() =
  var searchCmd = ""
  if paramCount() >= ParamOffset:
    case paramStr(ParamOffset)
    of "--help", "-h", "/?", "/h", "-v", "--version":
      echo sHelp
      quit 0
    of "-i":
      fShowExePath = true
    else:
      searchCmd = paramStr(ParamOffset)
  when false:
    if searchCmd == "":
      echo "\n#### Tools Version\n\n---\n" # md対応
  var total = 0
  when NimScript:
    let cmdListPath = joinPath(thisDir(), "gv.json")
  else:
    let cmdListPath = joinPath(os.getAppFilename().splitFile.dir, "gv.json")
  var jnode: JsonNode
  try:
    jnode = parseJson(readfile(cmdListPath))
  except JsonParsingError as e:
    echo "Json parsing Error: " & e.msg
    echo "  $#" % [cmdListPath]
    quit 1

  for jElm in jnode["cmdList"].items:
    if 0 == jElm["enable"].getInt: continue
    let cmd = jElm["cmd"].getStr.strip # コマンド名取得
    var sCmdVersion = jElm["cmdVersion"].getStr.strip # version オプションを取得
    if (searchCmd == "") or cmd.contains(
        searchCmd.toLower): # 特定のコマンドが指定された場合
      if execVersionCommand(cmd, sCmdVersion, jElm["verRow"].getInt, jnode[
          "maxCol"].getInt):
        inc total

  if searchCmd == "":
    echo "\nTotal: ", total
  if noneList.len > 0: # 発見できなかったコマンドを最後に表示
    stdout.write "\n- None: "
    for noneCmd in noneList:
      stdout.write &"[{noneCmd}],"

###########
## main()
###########
main()
