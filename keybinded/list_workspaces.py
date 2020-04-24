#!/usr/bin/env python
import subprocess as s
import i3ipc

i3 = i3ipc.Connection()

workspaces = ""
for con in i3.get_tree():
    if con.window and con.parent.type != 'dockarea':
        workspaces += " "+con.workspace().name

s.call(['notify-send', 'workspaces', workspaces])
