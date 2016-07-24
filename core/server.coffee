###

    SERVER

###

http              = require 'http'
debug             = require('debug')('cms:server')
chalk             = require 'chalk'
nconf             = require 'nconf'

nconf.argv().env().file  file: './config.json'

env  =  process.env.NODE_ENV || 'development'
debug 'ENV', process.env.NODE_ENV

conf = nconf.get env
port = process.env.PORT or conf.port or '3000'
exports.start = (app) ->
  server = http.createServer app
  server.listen port, false, ()-> debug chalk.green.bold "Started on port #{port} in #{env} mode"
  if env is 'production'
    debug chalk.red.bold "##############  BRAIN DAMAGE ################"
  server.on 'error', (err) -> debug chalk.red err
  return server
