jest.dontMock('../../../components/sidebar/TopicSidebar')
jest.dontMock('../../../components/sidebar/TopicList')

React = require('react/addons')
TestUtils = React.addons.TestUtils
TopicSidebar = React.createFactory require('../../../components/sidebar/TopicSidebar')
TopicListItem = require('../../../components/sidebar/TopicListItem')

describe 'TopicSidebar', ->
  it 'renders a list of topics', ->
    # Create mock data
    user =
      followed_topics: [{name: "test", id: 1}]
      followed_rooms: []
    isFollowingRoom = jest.genMockFunction()
    isFollowingTopic = jest.genMockFunction()

    # Initialize the topic sidebar
    sidebar = TopicSidebar {user, isFollowingTopic, isFollowingRoom}
    topicSidebar = TestUtils.renderIntoDocument(sidebar)

    # Find the list of topics rendered
    topicListItems = TestUtils.scryRenderedComponentsWithType(topicSidebar, TopicListItem)
    expect(topicListItems.length).toEqual 1

