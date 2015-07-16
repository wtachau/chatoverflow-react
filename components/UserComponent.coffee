React = require("react")
ReactBootstrap = require("react-bootstrap")
AppStore = require("../stores/AppStore")
AppActions = require("../actions/AppActions")
ReactStateMagicMixin = require("../assets/vendor/ReactStateMagicMixin")
Modal = React.createFactory ReactBootstrap.Modal
ModalHeader = React.createFactory ReactBootstrap.Modal.Header
ModalTitle = React.createFactory ReactBootstrap.Modal.Title
ModalBody = React.createFactory ReactBootstrap.Modal.Body
ModalFooter = React.createFactory ReactBootstrap.Modal.Footer
Button = React.createFactory ReactBootstrap.Button
Thumbnail = React.createFactory ReactBootstrap.Thumbnail
Grid = React.createFactory ReactBootstrap.Grid
Row = React.createFactory ReactBootstrap.Row
Col = React.createFactory ReactBootstrap.Col
{ a, div, img } = React.DOM

UserComponent = React.createClass
  displayName: "UserComponent"

  mixins: [ReactStateMagicMixin]

  statics:
    registerStore: AppStore

  propTypes:
    user: React.PropTypes.object.isRequired
    includeLogout: React.PropTypes.bool.isRequired

  getInitialState: ->
    showModal: false

  showPopup: -> @setState showModal: true

  closePopup: -> @setState showModal: false

  render: ->
    div {className: "popup-link"},
      a {href: "#", onClick: @showPopup},
        img {src:@props.user.pic_url}
      Modal {show: @state.showModal, onHide: @closePopup},
        ModalHeader {closeButton: true},
          ModalTitle {}, "User Information"
        ModalBody {},
          Grid {},
            Row {},
              Col {xs: 6, md: 3},
                div {className: "user-thumbnail"},
                  Thumbnail {href: "#", src: @props.user.pic_url}
              Col {xs: 6, md: 3},
                div {className: "user-username"}, "#{@props.user.username}"
                div {className: "user-karma"}, "Karma: #{@props.user.karma}"
        if @props.includeLogout
          ModalFooter {},
            Button {onClick: AppActions.logout, bsStyle: "danger"}, "Log out"


module.exports = UserComponent
