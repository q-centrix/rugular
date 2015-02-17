<%= name %>Factory = ($q) ->
  getquestions = ->
    questions = [
      {
        id: 1
        prompt: 'What is your favorite color?'
        type: 'select-one'
        answers: [
          {
            description: 'blue'
          }
          {
            description: 'yellow'
          }
          {
            description: 'red'
          }
        ]
      }
    ]

    return $q.when(questions)

  return {
    questions: getQuestions()
  }

<%= name %>Factory.$inject = ['$q']

angular.module('<%= name %>').factory('<%= name %>Factory', <%= name %>Factory)
