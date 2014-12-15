describe 'homepage', ->
  it 'should display the title', ->
    browser.get browser.baseUrl

    title = element(By.model('app.title'))
    expect(title.getText()).toMatch 'App'

    return

  return


