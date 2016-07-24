###

    CORE

###

nconf             = require 'nconf'
express           = require 'express'
path              = require 'path'
fs                = require 'fs'
chalk             = require 'chalk'
debug             = require('debug')('cms:core')
bodyParser        = require 'body-parser'
cookieParser      = require 'cookie-parser'
coffee            = require 'coffee-middleware'
stylus            = require 'stylus'
passport          = require 'passport'
webpack           = require './webpack'
db                = require './db'
routes            = require './router'
server            = require './server'
expressSession    = require 'express-session'
mongoConnection   = require 'connect-mongo'

app = express()

# NODE_ENV=DEVELOPMENT
process.env.NODE_ENV = process.env.NODE_ENV or 'development'

debug 'ENV', process.env.NODE_ENV

root = process.env.PWD
nconf.argv().env().file  file: './config.json'
conf = nconf.get process.env.NODE_ENV

app.use (req,res, next) ->
  res.locals.path = req.path
  next()

app.use bodyParser.json()
app.use bodyParser.urlencoded { extended: true }
app.use cookieParser()
app.disable 'x-powered-by'  # Убирает X-Powered-By:Express из header


# TEMPLATES
app.set 'views', './views'
app.set 'view engine', 'jade'

app.use coffee {src: root + '/public'}

app.use stylus.middleware
  src: root + '/public/stylus/',
  dest: root + '/public/css/',
  debug: true,
  force: true,

sessionStore = new (mongoConnection(expressSession))({
  url: conf.url
})

# SESSION
app.use expressSession
  key: 'express.sid'
  secret: 'session_secret'
  store: sessionStore
  resave: true
  saveUninitialized: true

# PASSPORT
app.use passport.initialize()
app.use passport.session()

app.use express.static 'public'
require("./passport")(app)

# ROUTING
app.use '/', routes

# WEBPACK
app.use webpack.DevMiddleware
app.use webpack.HotMiddleware

# 404
app.get '*', (req, res, next) ->
  err = new Error()
  err.status = 404
  err.message = 'Page not found'
  next err

# ERROR HANDLING
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render  'error',
              message : err.message
              error : if app.get('env') is 'development' then err else {}

# Вести лог
process.on 'uncaughtException', (err) ->
  if not err.caught then debug chalk.red err + err.message + err.stack

server = server.start app

exports.db  = db
exports.app = app
