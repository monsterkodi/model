###
00     00   0000000   000  000   000  00     00  00000000  000   000  000   000
000   000  000   000  000  0000  000  000   000  000       0000  000  000   000
000000000  000000000  000  000 0 000  000000000  0000000   000 0 000  000   000
000 0 000  000   000  000  000  0000  000 0 000  000       000  0000  000   000
000   000  000   000  000  000   000  000   000  00000000  000   000   0000000 
###

Menu = require 'menu'

class MainMenu
    
    @init: (main) -> 
        
        Menu.setApplicationMenu Menu.buildFromTemplate [
            
            label: 'Strudl'   
            submenu: [     
                label: 'Quit'
                accelerator: 'Command+Q'
                click: -> main.quit()
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
            submenu: [
                label: 'Open...'
                accelerator: 'CmdOrCtrl+O'
                click: -> main.openFile()
            ,
                type: 'separator'
            ,
                label: 'Reload'
                accelerator: 'CmdOrCtrl+R'
                click: (i,win) -> win?.reload()
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
            submenu: [
                label: 'Toggle Full Screen'
                accelerator: process.platform == 'darwin' and 'Ctrl+Command+F' or 'F11'
                click: (i,win) -> win?.setFullScreen !win.isFullScreen()
            ,
                label: 'Minimize'
                accelerator: 'CmdOrCtrl+M'
                role: 'minimize'
            ]
        ]

module.exports = MainMenu
