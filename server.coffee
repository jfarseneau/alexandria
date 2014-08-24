express = require 'express'
path = require 'path'
dotenv = require 'dotenv'
https = require 'https'

dotenv.load()

app = express()

dropboxToken = undefined

app.get '/dropbox', (req, res) ->
  options = {
    hostname: 'api.dropbox.com'
    path: "/1/oauth2/token?" +
          "code=#{req.query.code}&" +
          "grant_type=authorization_code&" +
          "redirect_uri=http://localhost:3000/dropbox&client_id=#{process.env.DROPBOX_APP_KEY}&client_secret=#{process.env.DROPBOX_APP_SECRET}"
    method: 'POST'
  }

  req = https.request options, (res) ->
    res.on 'data', (d) ->
      dropboxToken = d
  req.end()

  req.on 'error', (e) ->
    console.error e
    
  res.send 'Yep'

app.get '/', (req, res) ->
  authorizeUrl = "https://www.dropbox.com/1/oauth2/authorize?client_id=#{process.env.DROPBOX_APP_KEY}&response_type=code&redirect_uri=http://localhost:3000/dropbox&state=1"
  res.render 'index', { authorizeUrl: authorizeUrl }

app.get '/opds', (req, res) ->
  res.set('Content-Type', 'application/atom+xml');
  res.render 'opds/index'

app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'
app.use express.static('public')

server = app.listen 3000, ->
  console.log 'Listening on port %d', server.address().port
