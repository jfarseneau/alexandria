express = require 'express'
path = require 'path'
dotenv = require 'dotenv'
https = require 'https'

dotenv.load()
app = express()
routes = require('./source/routes')(app, express, path, dotenv, https)

server = app.listen 3000, ->
  console.log 'Listening on port %d', server.address().port
