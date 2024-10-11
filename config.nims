import strutils

const TC = "gcc"
#const TC = "clang"
#const TC = "tcc"
#
#const LTO = true
const LTO = false

switch "d","release"
switch "opt","size"

switch "passL","-static-libgcc" # for 32bit Windows ?

proc commonOpt() =
    #switch "passC","-s"
    switch "passC","-ffunction-sections"
    switch "passC","-fdata-sections"
    switch "passC","-Wl,--gc-sections"
    switch "passL","-Wl,--gc-sections"

const NIMCACHE = ".nimcache"
switch "nimcache",NIMCACHE

case TC
    of "gcc":
        commonOpt()
        when LTO : # These options let link time slow instead of reducing code size.
            switch "passC","-flto"
            switch "passL","-flto"
    of "clang":
        commonOpt()

switch "cc" ,TC

echo "\n#### Compiler: ",TC," ####\n"
