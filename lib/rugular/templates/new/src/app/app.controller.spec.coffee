describe 'appController', ->
  beforeEach module('app')

  $controller = undefined

  beforeEach inject((_$controller_) ->
    # The injector unwraps the underscores (_) from around the parameter names when matching
    $controller = _$controller_

    return
  )

  describe 'this.title', ->
    it 'is initially set to "app"', ->
      controller = $controller('appController')
      expect(controller.title).toEqual 'app'
      return

