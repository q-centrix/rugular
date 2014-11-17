describe 'AppController', ->
  controller = undefined
  beforeEach ->
    module 'app', ($provide) ->
      specHelper.fakeStateProvider $provide
      specHelper.fakeLogger $provide

    specHelper.injector ($controller, $q, $rootScope) ->

    controller = $controller('AppController')

  describe 'App controller', ->
    it 'should be created successfully', ->
      expect(controller).to.be.defined

    it 'should have title of App', ->
      expect(controller.title).to.equal 'App'

  specHelper.verifyNoOutstandingHttpRequests()
