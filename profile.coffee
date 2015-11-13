###
00000000   00000000    0000000   00000000  000  000      00000000
000   000  000   000  000   000  000       000  000      000     
00000000   0000000    000   000  000000    000  000      0000000 
000        000   000  000   000  000       000  000      000     
000        000   000   0000000   000       000  0000000  00000000
###

now = require 'performance-now'
log = require './log'

start = undefined
s_msg = undefined

profile = (msg) ->

    if start? and s_msg.length
        ms = (now()-start).toFixed 0
        if ms > 1000
            log "#{s_msg} in #{(ms/1000).toFixed(3)} sec"
        else
            log "#{s_msg} in #{ms} ms"

    start = now()
    s_msg = msg

module.exports = profile
