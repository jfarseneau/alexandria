module.exports = (app, https) ->
  dropboxToken = undefined
  
  app.get '/dropbox', (req, res) ->
    host = req.protocol + '://' + req.get('host')
    dropboxPath = "#{host}/dropbox&" +
                  "client_id=#{process.env.DROPBOX_APP_KEY}&" +
                  "client_secret=#{process.env.DROPBOX_APP_SECRET}"
    options = {
      hostname: 'api.dropbox.com'
      path: "/1/oauth2/token?" +
            "code=#{req.query.code}&" +
            "grant_type=authorization_code&" +
            "redirect_uri=#{dropboxPath}"
      method: 'POST'
    }

    req = https.request options, (res) ->
      res.on 'data', (d) ->
        dropboxToken = d
    req.end()

    req.on 'error', (e) ->
      console.error e
      
    res.send 'Yep'