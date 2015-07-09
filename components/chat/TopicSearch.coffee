React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Link = React.createFactory Router.Link
Button = React.createFactory ReactBootstrap.Button
Input = React.createFactory ReactBootstrap.Input
AppActions = require("../../actions/AppActions")
AppStore = require("../../stores/AppStore")
ChatActions = require("../../actions/ChatActions")
ChatStore = require("../../stores/ChatStore")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")

{ h1, div, a } = React.DOM

TopicSearch = React.createClass
  displayName: "TopicSearch"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStores:
      app: AppStore
      chat: ChatStore

  followTopic: (e) ->
    topic_id = e.target.getAttribute("data-id")
    AppActions.followTopic topic_id, @props.isFollowingTopic
    e.preventDefault()

  changeSearch: (e) ->
    value = e.target.value.trim()
    ChatActions.setTopicSearchQuery value
    if value is ""
      ChatActions.setSearchResults []
    else
      ChatActions.fetchSearchResults value

  render: ->
    followed_ids = @state.app.user.followed_topics.map ({id}) -> id
    searchResults = @state.chat.searchResults.filter (result) =>
      result.id not in followed_ids

    div {id: "topic-search"},
      Input
        type: "text"
        id: "topic-search-field"
        placeholder: "Add another topic"
        onChange: @changeSearch
        value: @state.chat.topicSearchQuery
      searchResults.map ({id, name}) =>
        a {href: "#", onClick: @followTopic, "data-id": id},
          ListGroupItem {className: "topic-name", "data-id": id}, name

module.exports = TopicSearch
