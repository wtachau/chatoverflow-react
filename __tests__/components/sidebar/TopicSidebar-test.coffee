jest.dontMock('../../../components/sidebar/TopicSidebar')
describe 'TopicSidebar', ->
  it 'renders a list of topics', ->
    React = require('react/addons')
    TopicSidebar = React.createFactory require('../../../components/sidebar/TopicSidebar')
    TestUtils = React.addons.TestUtils
    user = {}
    sidebar = TestUtils.renderIntoDocument(
      TopicSidebar
        user: user
        isFollowingTopic: (a) -> true
        isFollowingRoom: (a) -> true
    )

    expect(sidebar.props.user).toBe user

