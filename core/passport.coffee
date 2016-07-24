###

    PASSPORT

###

# config      = require "nconf"
User            = require './models/user'
passport        = require 'passport'
LocalStrategy   = require('passport-local').Strategy
debug           = require('debug')('cms:passport')

passport.use User.createStrategy()
passport.serializeUser User.serializeUser()
passport.deserializeUser User.deserializeUser()
module.exports = (app) -> {}
