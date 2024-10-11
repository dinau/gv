# Package

version       = "2.0"
author        = "dinau"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["gv"]


# Dependencies

requires "nim >= 0.19.0"

import std/[os]
const TARGET = "gv"
var srcNim = [srcDir,TARGET].joinPath()

var Opts:seq[string]
Opts.add "--verbosity:1"
Opts.add "-o:$#" % [TARGET.toExe()]


task make,"make":
    exec ("nim c -d:strip  $# " % [Opts.join(" ")]) & srcNim

task clean,"clean":
    rmFile TARGET.toEXE()
    exec(["rm -fr",".nimcache"].join(" "))

task build,"build":
    makeTask()

