React = require("react")
ReactBootstrap = require("react-bootstrap")
Router = require("react-router")
ListGroup = React.createFactory ReactBootstrap.ListGroup
ListGroupItem = React.createFactory ReactBootstrap.ListGroupItem
Link = React.createFactory Router.Link
Button = React.createFactory ReactBootstrap.Button
Input = React.createFactory ReactBootstrap.Input
UserActions = require("../../actions/UserActions")
UserStore = require("../../stores/UserStore")
RoomActions = require("../../actions/RoomActions")
RoomStore = require("../../stores/RoomStore")
ReactStateMagicMixin = require("../../assets/vendor/ReactStateMagicMixin")
Select = React.createFactory require("react-select")

{ h1, div, a } = React.DOM

TopicSearch = React.createClass
  displayName: "TopicSearch"

  mixins: [ReactStateMagicMixin, Router.Navigation]

  statics:
    registerStores:
      user: UserStore
      room: RoomStore

  propTypes:
    user: React.PropTypes.object.isRequired

  componentDidMount: ->
    RoomActions.fetchSearchResults()

  selectOnChange: (selectedValue) ->
    topics = @state.room.searchResults.filter ({name}) => name is selectedValue
    if topics.length is 0
      UserActions.createTopic selectedValue, (topic) =>
        @state.user.user.followed_topics.push topic
        @transitionTo "topic", topic_id: topic.id
    else
      UserActions.followTopic topics[0].id, @props.user
      @transitionTo "topic", topic_id: topics[0].id

  formattedOptions: ->
    followed_ids = @state.user.user.followed_topics.map ({id}) -> id
    @state.room.searchResults.filter((result) =>
      result.id not in followed_ids
    ).map ({name}) => {value: name, label: name}

  render: ->
    div {className: "topic-search"},
      Select
        name: "topic-search-field"
        value: ""
        options: @formattedOptions()
        onChange: @selectOnChange
        multi: false
        allowCreate: true
        placeholder: "+ Add another"
        addLabelText: 'Create "{label}" room'
        searchPromptText: ""
        noResultsText: 'No results found'
        clearable: true
        ignoreCase: true

module.exports = TopicSearch
