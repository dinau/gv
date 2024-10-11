### gv

--- 

Small command to show version info.

#### Build

---

Clone this repo. and build

```sh
git clone https://github.com/dinau/gv
cd gv
make
```

#### Usage

---

```sh
$ gv

- Avr-gcc.exe (GCC) 14.2.0
- Choosenim v0.8.9 (2024-10-02 12:55:41) [windows/amd64]
- Clang version 18.1.8
- Cmake version 3.30.3
- Ctags: Exuberant Ctags 5.8J2, Copyright (C) 1996-2009 Darren Hiebert
- Ffmpeg version 7.0.2-essentials_build-www.gyan.dev Copyright (c) 2000-2024 t
- Gcc.exe (Rev1, Built by MSYS2 project) 14.2.0
- Git version 2.46.0.windows.1
- Global (GNU GLOBAL) 6.6.3
- LuaJIT 2.1.1725453128 -- Copyright (C) 2005-2023 Mike Pall. https://luajit.o
- Lua54: Lua 5.4.2  Copyright (C) 1994-2020 Lua.org, PUC-Rio
- Make: GNU Make 4.4.1
- Nim Compiler Version 2.2.0 [Windows: amd64]
- Nimble v0.16.1 compiled at 2024-10-02 02:26:00
- Nimv 1.4.6 (2023/04): Simple CUI wrapper for Choosenim command.
- Ninja: 1.12.1
- Node: v20.17.0
- Perl: This is perl 5, version 38, subversion 2 (v5.38.2) built for x86_64-ms
- Python 3.12.6
- Ruby 3.2.5 (2024-07-26 revision 31d0f1a2e7) [x64-mingw-ucrt]
- Zig: 0.14.0-dev.1743+eb363bf84

Total: 21

- None: [arm-none-eabi-gcc],[csc],[fbc],[fpc],[go],[java],[javac],[julia],[meson],[pandoc],[platformio],[riscv-nuclei-elf-gcc],[rustc],[rustup],[scons],[zig cc],
```

```sh
$ gv ni

- Choosenim v0.8.9 (2024-10-02 12:55:41) [windows/amd64]
- Nim Compiler Version 2.2.0 [Windows: amd64]
- Nimble v0.16.1 compiled at 2024-10-02 02:26:00
- Nimv 1.4.6 (2023/04): Simple CUI wrapper for Choosenim command.
- Ninja: 1.12.1
```

```sh
$ gv g

- Avr-gcc.exe (GCC) 14.2.0
- Clang version 18.1.8
- Ctags: Exuberant Ctags 5.8J2, Copyright (C) 1996-2009 Darren Hiebert
- Ffmpeg version 7.0.2-essentials_build-www.gyan.dev Copyright (c) 2000-2024 t
- Gcc.exe (Rev1, Built by MSYS2 project) 14.2.0
- Git version 2.46.0.windows.1
- Global (GNU GLOBAL) 6.6.3
- Zig: 0.14.0-dev.1743+eb363bf84
```

```sh
$ gv -h

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
        Editable command list
```

It can add or delete the specified command by editing `gv.json` file.


That's all (-:
