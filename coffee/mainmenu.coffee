###
00     00   0000000   000  000   000  00     00  00000000  000   000  000   000
000   000  000   000  000  0000  000  000   000  000       0000  000  000   000
000000000  000000000  000  000 0 000  000000000  0000000   000 0 000  000   000
000 0 000  000   000  000  000  0000  000 0 000  000       000  0000  000   000
000   000  000   000  000  000   000  000   000  00000000  000   000   0000000 
###

fs    = require 'fs'
Menu  = require 'menu'
path  = require 'path'
prefs = require './tools/prefs'
log   = require './tools/log'

class MainMenu
    
    @init: (main) -> 
    
        recent = []
        for f in prefs.load().recent
            if fs.existsSync f
                recent.unshift 
                    label: path.basename(f) + ' - ' + path.dirname(f)
                    path: f
                    click: (i) -> main.loadFile i.path
        if recent.length
            recent.push
                type: 'separator'
            recent.push
                label: 'Clear List'
                click: (i) -> 
                    p = prefs.load()
                    p.recent = []
                    prefs.save p
                    MainMenu.init main
            
        Menu.setApplicationMenu Menu.buildFromTemplate [
            
            label: 'Strudel'   
            submenu: [     
                label:       'About strudl'
                accelerator: 'CmdOrCtrl+.'
                click:       main.showAbout
            ,
                type: 'separator'
            ,
                label:       'Hide strudl'
                accelerator: 'Command+H'
                role:        'hide'
            ,
                label:       'Hide Others'
                accelerator: 'Command+Alt+H'
                role:        'hideothers'
            ,
                type: 'separator'
            ,
                label:       'Quit'
                accelerator: 'Command+Q'
                click:       -> main.quit()
            ]
        ,
            ###
            00000000  000  000      00000000
            000       000  000      000     
            000000    000  000      0000000 
            000       000  000      000     
            000       000  0000000  00000000
            ###
            label: 'File'
            role: 'file'
            submenu: [
                label:       'Open...'
                accelerator: 'CmdOrCtrl+O'
                click:       -> main.openFile()
            ,
                label:       'Open Recent'
                submenu:     recent
            ,
                type: 'separator'
            ,
                label:       'Reload'
                accelerator: 'CmdOrCtrl+R'
                click:       (i,win) -> main.reload win
            ]
        ,    
            ###
            00000000  0000000    000  000000000
            000       000   000  000     000   
            0000000   000   000  000     000   
            000       000   000  000     000   
            00000000  0000000    000     000   
            ###
            label: "Edit",
            submenu: [
                label:       "Undo"
                accelerator: "CmdOrCtrl+Z"
                selector:    "undo:" 
            ,
                label:       "Redo"
                accelerator: "Shift+CmdOrCtrl+Z"
                selector:    "redo:" 
            ,
                type: "separator" 
            ,
                label:       "Cut"
                accelerator: "CmdOrCtrl+X"
                selector:    "cut:" 
            ,
                label:       "Copy"
                accelerator: "CmdOrCtrl+C"
                selector:    "copy:" 
            ,
                label:       "Paste"
                accelerator: "CmdOrCtrl+V"
                selector:    "paste:"
            ]
        ,
            ###
            00000000  000  000   000  0000000  
            000       000  0000  000  000   000
            000000    000  000 0 000  000   000
            000       000  000  0000  000   000
            000       000  000   000  0000000  
            ###
            label: 'Find'
            submenu: [
                label:       'Find Path'
                accelerator: 'CmdOrCtrl+F'
                click:       (i,win) -> win?.emit 'findPath'
            ,
                label:       'Find Value'
                accelerator: 'CmdOrCtrl+G'
                click:       (i,win) -> win?.emit 'findValue'
            ,
                label:       'Clear Find'
                accelerator: 'CmdOrCtrl+K'
                click:       (i,win) -> win?.emit 'clearFind'
            ]
        ,        
            ###
            000   000  000  00000000  000   000
            000   000  000  000       000 0 000
             000 000   000  0000000   000000000
               000     000  000       000   000
                0      000  00000000  00     00
            ###
            label: 'View'
            role: 'view'
            submenu: [
                label:       'Indices'
                accelerator: 'CmdOrCtrl+1'
                type:        'checkbox'
                checked:     true
                click:       (i,win) -> win?.emit 'setColumnVisible', 'idx', i.checked
            ,
                label:       'Paths'
                accelerator: 'CmdOrCtrl+2'
                type:        'checkbox'
                checked:     true
                click:       (i,win) -> win?.emit 'setColumnVisible', 'key', i.checked
            ,
                label:       'Values'
                accelerator: 'CmdOrCtrl+3'
                type:        'checkbox'
                checked:     true
                click:       (i,win) -> win?.emit 'setColumnVisible', 'val', i.checked
            ,
                label:       'Numbers'
                accelerator: 'CmdOrCtrl+4'
                type:        'checkbox'
                checked:     true
                click:       (i,win) -> win?.emit 'setColumnVisible', 'num', i.checked
            ,
                type: 'separator'
            ,                
                label:       'Toggle FullScreen'
                accelerator: 'Ctrl+Command+F'
                click:       (i,win) -> win?.setFullScreen !win.isFullScreen()
            ]
        ,        
            ###
            000   000  000  000   000  0000000     0000000   000   000
            000 0 000  000  0000  000  000   000  000   000  000 0 000
            000000000  000  000 0 000  000   000  000   000  000000000
            000   000  000  000  0000  000   000  000   000  000   000
            00     00  000  000   000  0000000     0000000   00     00
            ###
            label: 'Window'
            role: 'window'
            submenu: [
                label:       'Minimize'
                accelerator: 'Cmd+M'
                click:       (i,win) -> win?.minimize()
            ,
                label:       'Maximize'
                accelerator: 'Cmd+Shift+m'
                click:       (i,win) -> win?.maximize()
            ,
                type: 'separator'
            ,                            
                label:       'Bring All to Front'
                accelerator: 'Alt+Cmd+`'
                role:        'front'
            ,
                label:       'Cycle Through Windows'
                accelerator: 'CmdOrCtrl+`'
                click:       (i,win) -> main.focusNextWindow win
            ]
        ,        
            label: 'Help'
            role: 'help'
            submenu: []            
        ]

module.exports = MainMenu
