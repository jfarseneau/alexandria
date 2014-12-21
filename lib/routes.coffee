module.exports = (app, express, path, dotenv, https) ->  
  app.set 'views', path.join(__dirname, '../views')
  app.set 'view engine', 'jade'
  app.use express.static('public')
  
  index = require('./routes/index')(app)
  dropbox = require('./routes/dropbox')(app, https)
  opds = require('./routes/opds')(app)