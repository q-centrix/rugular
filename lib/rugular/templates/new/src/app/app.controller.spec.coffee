describe 'AppController', ->
  controller = undefined
  beforeEach ->
    module 'app', ($provide) ->
      specHelper.fakeStateProvider $provide
      specHelper.fakeLogger $provide

    specHelper.injector ($controller, $q, $rootScope) ->

    controller = $controller('AppController')

  it 'creates', ->
    expect(controller).to.be.defined

  it 'has title', ->
    expect(controller.title).to.equal 'App'

  specHelper.verifyNoOutstandingHttpRequests()
