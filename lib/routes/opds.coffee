module.exports = (app) ->
  app.get '/opds', (req, res) ->
    res.set('Content-Type', 'application/atom+xml');
    res.render 'opds/index'