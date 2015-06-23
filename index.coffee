React = require "react"
App = require "./components/layout/App"

require "./assets/vendor/bootstrap/stylesheets/_bootstrap.scss"
require "./assets/stylesheets/home.scss"
require "./assets/stylesheets/chat.scss"

React.render ( React.createElement App ), document.body
