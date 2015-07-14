React = require("react")
Router = require("react-router")
App = require("../components/layout/App")
AskComponent = require("../components/AskComponent")
TopicComponent = require("../components/TopicComponent")
RoomComponent = require("../components/RoomComponent")
Route = React.createFactory Router.Route

routes =
  Route {name: "app", path: "/", handler: App},
    Route {name: "topic", path: "/topics/:topic_id", handler: TopicComponent},
      Route {name: "room", path: "rooms/:room_id", handler: RoomComponent}
    Route {name: "ask", path: "/ask", handler: AskComponent}

module.exports = routes
