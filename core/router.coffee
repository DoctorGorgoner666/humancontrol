###

    ROUTER

###

express     = require 'express'
passport    = require 'passport'
debug       = require('debug')('cms:router')
chalk       = require 'chalk'
router      = express.Router()
user        = require './controllers/user'
User        = require './models/user'
request     = require './controllers/request'
crypto      = require 'crypto'
nconf       = require 'nconf'

nconf.argv().env().file  file: './config.json'
env  =  process.env.NODE_ENV
conf = nconf.get env

router.get '/', (req, res)->
  res.render 'index'

# Создание администратора
router.route '/install'
  .get (req, res) ->
    debug 'Creating user account...'
    User.findOne {accountType: 'admin'}
      .exec()
      .then (user)->
        debug user
        if user is null
          User.register new User(
            {
              email: conf.adminEmail
              name: 'General'
              surname: 'Admin'
              username: conf.adminEmail
              subrole: 'none'
              role: 'none'
              accountType: 'admin'
              type: 'admin'
            }),
            conf.adminPass,
            (err, user)->
              if err
                debug err
              else
                debug 'new user', user
                res.json {success: 'Admin user created'}
        else
          res.json {error: 'Admin user already register'}

# LOGIN
router.route '/login'
  .get (req, res) ->
    req.logout()
    if req.isAuthenticated() and req.user.accountType is 'admin'
      res.redirect 'admin'
    else if req.isAuthenticated()
      if req.user.confirmed
        res.redirect '/'
      else
        res.render 'admin/login', {error: '', confirmed: false}
    else
      res.render 'admin/login', {error: '', confirmed: null}

# LOGIN
router.route '/request'
  .get (req, res) ->
    if req.isAuthenticated() and req.user.accountType is 'admin'
      request.retrieve(req, res)
    else
      res.json {error: 'Wrong way'}
  .post (req, res) ->
    if req.isAuthenticated() and req.user.accountType is 'admin'
      request.create(req, res)
    else
      res.json {error: 'Wrong way'}

# LOGIN
router.route '/ajax-login'
  .post (req, res) ->
    passport.authenticate('local')(req, res, ()->
      if req.user.accountType is 'admin'
        res.json {
          success:
            login: 'ok'
            admin: true
        }
      else
        debug 'Ajax-login error'
    )

# LOGOUT
router.get '/sign-out', (req, res) ->
  req.logout()
  res.redirect '/'

###

  ADMIN

###

router.get '/admin', (req, res, next) ->
  if req.isAuthenticated() and req.user.accountType is 'admin'
    next()
  else
    res.redirect '/'

router.get '/admin/*', (req, res, next) ->
  if req.isAuthenticated() and req.user.accountType is 'admin'
    next()
  else
    res.redirect '/'

# ADMIN
router.route '/admin'
  .get (req, res) -> res.render 'admin/admin',
    {
      page: 'This page'
      msg: 'Yo'
    }

module.exports = router
