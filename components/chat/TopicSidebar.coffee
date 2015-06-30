React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
URLResources = require("../../common/URLResources")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Link = React.createFactory Router.Link

{ div, h1 } = React.DOM

TopicSidebar = React.createClass

  getInitialState: ->
    topics: []

  componentWillMount: ->
    URLResources.readFromAPI "/topics", (response)=>
      @setState topics: response

  render: ->
    ListGroup {className: "side-bar"},
      h1 {className: "categories-header"}, "Categories"
      @state.topics.map ({name, id, rooms}) ->
        div {}, 
          rooms.map ({id}) ->
            Link {to: "/topics/#{id}"},
              ListGroupItem {className: "topic-name"}, name 

module.exports = TopicSidebar
