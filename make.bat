@echo off
REM make
REM Assembles and links the 32-bit ASM program into .exe which can be used by WinDBG
REM Uses MicroSoft Macro Assembler version 6.11 and 32-bit Incremental Linker version 5.10.7303
REM Created by Huang 

REM delete related files
del group_16.lst
del group_16.obj
del group_16.ilk
del group_16.pdb
del group_16.exe
del group_16.RES


REM /c          assemble without linking
REM /coff       generate object code to be linked into flat memory model 
REM /Zi         generate symbolic debugging information for WinDBG
REM /Fl		Generate a listing file
 
REM group_16.asm      The name of the source file 


ML /c /coff /Zi /Fl group_16.asm
if errorlevel 1 goto terminate
rc group_16.rc
REM /debug              generate symbolic debugging information
REM /subsystem:console  generate console application code
REM /entry:start        entry point from WinDBG to the program 

REM                           the entry point of the program must be _start

REM /out:group_16.exe         output group_16.exe code
REM group_16.obj              input group_16.obj
REM Kernel32.lib        library procedures to be invoked from the program
REM irvine32.lib
REM user32.lib

LINK /debug /subsystem:console  /entry:main  /out:group_16.exe group_16.obj group_16.RES Kernel32.lib irvine32.lib user32.lib 
if errorlevel 1 goto terminate

REM Display all files related to this program:
DIR group_16.*

:terminate
pause
