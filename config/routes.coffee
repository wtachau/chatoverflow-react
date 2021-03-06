React                = require("react")
Router               = require("react-router")
App                  = require("../components/layout/App")
AskComponent         = require("../components/AskComponent")
TopicComponent       = require("../components/TopicComponent")
RoomComponent        = require("../components/RoomComponent")
HomeComponent        = require("../components/HomeComponent")
MainComponent        = require("../components/MainComponent")
ActiveUsersComponent = require("../components/ActiveUsersComponent")

Route        = React.createFactory Router.Route
DefaultRoute = React.createFactory Router.DefaultRoute

routes =
  Route {name: "app", path: "/", handler: App},
    Route {name: "main", handler: MainComponent}
      Route {name: "topic", path: "/topics/:topic_id", handler: TopicComponent},
        Route {name: "room", path: "rooms/:room_id", handler: RoomComponent}
        DefaultRoute {name: "active_users", handler: ActiveUsersComponent}
      DefaultRoute {name: "home", handler: HomeComponent}

module.exports = routes
