
@echo off

set pathToBuild="C:\Godot\Slots\web\"


cd %pathToBuild%


REM #send file to itch.io via Butler:
butler push "C:\Godot\Slots\web\web.zip" datimekeeper/slots:web


pause