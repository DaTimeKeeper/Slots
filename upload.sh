#!/bin/bash
zip -r slots.zip web
../butler.exe push "C:\Godot\Slots\slots.zip" datimekeeper/slots:web
../butler.exe push "C:\Godot\Slots\slots.exe" datimekeeper/slots:win