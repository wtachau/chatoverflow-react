React = require "react"
# App = require "./components/layout/App"
ChatComponent = require "./components/ChatComponent"

require "./assets/vendor/bootstrap/stylesheets/_bootstrap.scss"
require "./assets/stylesheets/home.scss"

# React.render ( React.createElement App ), document.body
React.render ( React.createElement ChatComponent ), document.body
