React = require("react")
Router = require("react-router")
App = require("../components/layout/App")
Route = React.createFactory Router.Route

routes = 
  Route {name:"app", path:"/", handler:App},
    Route {name:"room", path:"/:room", handler:App}

module.exports = routes
