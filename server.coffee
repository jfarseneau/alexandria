express = require 'express'
path = require 'path'
app = express()

app.get '/', (req, res) ->
  res.render 'index'

app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'
app.use express.static('public')

server = app.listen 3000, ->
  console.log 'Listening on port %d', server.address().port
