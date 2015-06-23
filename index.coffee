React = require "react"
App = require "./components/layout/App"

require "./assets/vendor/bootstrap/stylesheets/_bootstrap.scss"
require "./assets/stylesheets/home.scss"

React.render ( React.createElement App ), document.getElementById('react-root')
