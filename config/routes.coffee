React = require("react")
Router = require("react-router")
App = require("../components/layout/App")
AskComponent = require("../components/AskComponent")
ChatComponent = require("../components/ChatComponent")
Route = React.createFactory Router.Route

routes =
  Route {name: "app", path: "/", handler: App},
    Route {name: "topic", path: "/topics/:topic_id", handler: ChatComponent},
      Route {name: "room", path: "rooms/:room_id", handler: App}
    Route {name: "ask", path: "/ask", handler: AskComponent}

module.exports = routes
