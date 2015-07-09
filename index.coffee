React = require("react")
Router = require("react-router")
routes = require("./config/routes")
App = require("./components/layout/App")

require("./assets/vendor/bootstrap/stylesheets/_bootstrap.scss")
require("./assets/stylesheets/home.scss")
require("./assets/stylesheets/chat.scss")
require("./assets/stylesheets/login.scss")
require("./assets/stylesheets/rooms.scss")
require("./assets/stylesheets/sidebar.scss")
require("./assets/stylesheets/messages.scss")
require("./assets/stylesheets/mentions.scss")
require("./assets/stylesheets/pinnedPost.scss")
require("./assets/stylesheets/header.scss")
require("./assets/stylesheets/chatPanel.scss")

Router.run routes, Router.HistoryLocation, (Handler) ->
  React.render (React.createElement Handler),
  document.getElementById("react-root")
