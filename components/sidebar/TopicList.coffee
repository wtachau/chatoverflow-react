React = require("react")

TopicListItem = React.createFactory require("./TopicListItem")

{ h1, div } = React.DOM

module.exports = React.createClass
  displayName: "TopicList"

  propTypes:
    topics: React.PropTypes.array.isRequired
    onClose: React.PropTypes.func.isRequired

  render: ->
    div {},
      h1 {className: "categories-header"}, "Followed Rooms"
      @props.topics?.map ({id, name}, index) =>
        TopicListItem {id, name, key: index, onClose: @props.onClose}
