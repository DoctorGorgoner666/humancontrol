
mongoose              = require 'mongoose'
debug                 = require('debug')('cms:model:request')
uuid                  = require 'node-uuid'
nconf                 = require 'nconf'
nconf.argv().env().file  file: './config.json'

env  =  process.env.NODE_ENV || 'development'
debug 'ENV', process.env.NODE_ENV
conf = nconf.get env

Schema = mongoose.Schema

schema = new mongoose.Schema
  text:
    type: String
  email: String
  date:
    created:
      type: Date

module.exports = mongoose.model 'Request', schema
