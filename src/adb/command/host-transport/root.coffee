Command = require '../../command'
Protocol = require '../../protocol'

class RootCommand extends Command
  RE_OK = /restarting adbd as root/

  execute: ->
    this._send 'root:'
    @parser.readAscii 4
      .then (reply) =>
        switch reply
          when Protocol.OKAY
            @parser.readAll()
              .then (value) ->
                if RE_OK.test(value)
                  true
                else
                  throw new Error value.toString().trim()
          when Protocol.FAIL
            @parser.readError()
          else
            @parser.unexpected reply, 'OKAY or FAIL'

module.exports = RootCommand
