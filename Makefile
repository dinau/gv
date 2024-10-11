ROOT_DIR = c:/drvDx
ifeq ($(OS),Windows_NT)
	EXE = .exe
endif

all:
	@-nim conv.nims
	@nimble make
clean:
	@nimble clean


rel:
	cp -f gv.exe $(ROOT_DIR)/00emacs-home/vimtool/
	cp -f gv.json $(ROOT_DIR)/00emacs-home/vimtool/

remove:
	-rm  $(ROOT_DIR)/00emacs-home/vimtool/gv.exe
	-rm  $(ROOT_DIR)/00emacs-home/vimtool/gv.json

TARGET = gv
allscript:
	nim conv.nims
	@nim $(TARGET).nims -h
	@nim $(TARGET).nims

relscript:
	cp -f gv.nims $(ROOT_DIR)/00emacs-home/vimtool/
	cp -f gv.json $(ROOT_DIR)/00emacs-home/vimtool/
	cp -f gv.bat $(ROOT_DIR)/00emacs-home/vimtool/

removescript:
	-rm  $(ROOT_DIR)/00emacs-home/vimtool/gv.nims
	-rm  $(ROOT_DIR)/00emacs-home/vimtool/gv.json
	-rm  $(ROOT_DIR)/00emacs-home/vimtool/gv.bat

dlls:
	@strings $(TARGET)$(EXE) | rg -i \.dll
