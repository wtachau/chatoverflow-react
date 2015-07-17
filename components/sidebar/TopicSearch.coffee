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
Select = React.createFactory require("react-select")

{ h1, div, a } = React.DOM

TopicSearch = React.createClass
  displayName: "TopicSearch"

  mixins: [ReactStateMagicMixin, Router.Navigation]

  statics:
    registerStores:
      app: AppStore
      chat: ChatStore

  propTypes:
    user: React.PropTypes.object.isRequired

  fetchSearchResults: (input, callback) ->
    followed_ids = @state.app.user.followed_topics.map ({id}) -> id
    query = input.trim()
    if query is ""
      callback null, options: []
    else
      ChatActions.fetchSearchResults input, (response) =>
        ChatActions.setSearchResults response
        searchResults = response.filter((result) =>
          result.id not in followed_ids
        ).map ({name}) => {value: name, label: name}
        callback null, options: searchResults

  selectOnChange: (value) ->
    topic = @state.chat.searchResults.filter ({name}) => name is value
    AppActions.followTopic topic[0].id, @props.user
    @transitionTo "topic", topic_id: topic[0].id

  render: ->
    div {className: "topic-search"},
      Select
        name: "topic-search-field"
        value: ""
        asyncOptions: @fetchSearchResults
        autoload: false
        onChange: @selectOnChange
        multi: false
        placeholder: "+ Add another"
        searchPromptText: ""
        noResultsText: 'No results found'
        clearable: true
        ignoreCase: true

module.exports = TopicSearch
