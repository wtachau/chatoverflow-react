React = require "react"
{ div, h1 } = React.DOM

module.exports = React.createClass
  render: -> 
  	div className:"row-fluid",
      h1 className: "center-block" , "Chat Overflow"
    
  

