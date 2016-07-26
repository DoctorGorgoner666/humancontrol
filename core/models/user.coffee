###

    ACCOUNT model

    https://github.com/saintedlama/passport-local-mongoose
###


mongoose              = require 'mongoose'
deepPopulate          = require('mongoose-deep-populate')(mongoose)
passportLocalMongoose = require 'passport-local-mongoose'
uniqueValidator       = require 'mongoose-unique-validator'
debug                 = require('debug')('cms:model:user')
uuid                  = require 'node-uuid'
nconf                 = require 'nconf'
nconf.argv().env().file  file: './config.json'

env  =  process.env.NODE_ENV || 'development'
conf = nconf.get env

Schema = mongoose.Schema

schema = new mongoose.Schema
  type:
    type: String
  accountType:
    type: String
  username:
    type: String
  name:
    type: String
  middlename:
    type: String
  surname:
    type: String
  password:
    type: String
    select: true
  email:
    type: String
    required: true
    unique: true
  addemail:
    type: String
  skype:
    type: String
  facebook:
    type: String
  linkedln:
    type: String
  position:
    type: String
  tel1:
    type: String
  tel2:
    type: String
  activated:
    type: Boolean
    default: false
  banned:
    type: Boolean
    default: false
  confirmed:
    type: Boolean
    default: false
  modified:
    type: Boolean
  changes:
    type: Object
  country:
    type: String
  region:
    type: String
  membership:
    type: Array
  group:
    type: String
  role:
    type: String
  subrole:
    type: String
  img:
    type: String
    default: '/upload/nophoto.png'
  emailToken: String
  inviteToken: String
  resetPasswordToken: String
  resetPasswordExpires: Date
  date:
    created:
      type: Date
    finished:
      type: Date
    modified:
      type: Date

schema.pre 'save', (next)->
  if @isNew
    if !@date.created
      @date.created = new Date()
    if !@emailToken
      @emailToken = uuid.v4()
    if !@resetPasswordToken
      @resetPasswordToken = uuid.v4()
    next()
  else
    next()


schema.statics.confirm = (token, cb)->
  return @findOneAndUpdate(
    {'emailToken': token},
      {
        $set:
          'confirmed': true
          'emailToken': null
      },
      {new: true}
    ).exec(cb)


schema.plugin passportLocalMongoose, {
  usernameField: 'email'
  passwordField: 'password'
}
schema.plugin uniqueValidator
schema.plugin deepPopulate

module.exports = mongoose.model 'User', schema
