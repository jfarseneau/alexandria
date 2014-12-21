module.exports = (app) ->
  app.get '/', (req, res) ->
    authorizeUrl = "https://www.dropbox.com/1/oauth2/authorize?client_id=#{process.env.DROPBOX_APP_KEY}&response_type=code&redirect_uri=http://localhost:3000/dropbox&state=1"
    res.render 'index', { authorizeUrl: authorizeUrl }