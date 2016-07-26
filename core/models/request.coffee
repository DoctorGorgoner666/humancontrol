
mongoose              = require 'mongoose'
debug                 = require('debug')('cms:model:request')

Schema = mongoose.Schema

schema = new mongoose.Schema
  text:
    type: String
  email: String
  date:
    created:
      type: Date

module.exports = mongoose.model 'Request', schema
