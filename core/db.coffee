###

    Database

###

debug       = require('debug')('cms:db')
chalk       = require 'chalk'
nconf       = require 'nconf'
mongoose    = require 'mongoose'

#  NCONF SETTINGS
nconf.argv().env().file  file: './config.json'

conf = nconf.get (process.env.NODE_ENV or 'development')

debug 'ENV', process.env.NODE_ENV

debug 'Configs: ', conf
mongoose.connect conf.url, (err) ->
  if err then throw err else debug (conf.url + ' connected')

db = mongoose.connection

db.on 'error', (err) -> debug 'connection error:', err.message

process.on 'uncaughtException', (err) ->
  if err.name is "MongoError"
    err.caught = on
    debug chalk.red err.name + ": Connection Refused by the server, make sure"
    + "that the mongod daemon is enabled \n"  + err.stack

module.exports = db
