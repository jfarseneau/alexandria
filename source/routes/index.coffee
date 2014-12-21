module.exports = (app) ->
  app.get '/', (req, res) ->
    host = req.protocol + '://' + req.get('host')
    authorizeUrl = "https://www.dropbox.com/1/oauth2/authorize?" +
                   "client_id=#{process.env.DROPBOX_APP_KEY}&" + 
                   "response_type=code&" +
                   "redirect_uri=#{host}/dropbox&state=1"
    res.render 'index', { authorizeUrl: authorizeUrl }