###

    Users: controller

###

mongoose = require 'mongoose'
User     = require '../models/user'
passport = require 'passport'
debug    = require('debug')('cms:controllers:user')
crud = {}

crud.create = (req, res) ->
  Resource = mongoose.model 'User'
  rec = new Resource(req.body)
  rec.save (err, resource) ->
    if err then res.json {'ERROR': err}
    else res.redirect 'admin/users/user/' + resource._id

crud.retrieve = (req, res) ->
  Resource = mongoose.model 'User'
  if req.params.id?
    Resource.findOne({_id: req.params.id})
            # .populate('parent.project')
            # .populate('parent.user')
            .exec (err, resource) ->
              if err
                Resource.findOne {'url': req.params.id}, (err, resource) ->
                  if err
                    res.status(500).send({ error: err })
                  else if resource
                    res.render 'admin/users/user' , { tuser: resource, user: config.user, page: config.page, cms: config.cms, bl:config.bl}
              else if resource
                res.render 'admin/users/user' , { tuser: resource, user: config.user, page: config.page, cms: config.cms, bl:config.bl}

  else
    Resource.find {}, (err, resource) ->
      res.render 'admin/users/users' , { users: resource, user: config.user, page: config.page, cms: config.cms, bl:config.bl}

crud.update = (req, res) ->
  Resource = mongoose.model 'Task'
  fields = req.body

  Resource.findByIdAndUpdate req.params.id, { $set: fields }, (err, resource) ->
    if err then res.json {'ERROR': err}
    else res.json {'UPDATED': resource}

exports.crud = crud
