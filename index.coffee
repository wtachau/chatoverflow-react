React = require("react")
Router = require("react-router")
routes = require("./config/routes") 
App = require "./components/layout/App"

require "./assets/vendor/bootstrap/stylesheets/_bootstrap.scss"
require "./assets/stylesheets/home.scss"
require "./assets/stylesheets/chat.scss"

Router.run routes, Router.HistoryLocation, (Handler) ->
  React.render (React.createElement Handler), document.getElementById("react-root")
