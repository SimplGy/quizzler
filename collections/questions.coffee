

# All the quiz questions
window.app.questions = []

# Parses raw questions and adds them to the list
app.questions.add = (rawQuestions) ->
  parseFacebookPosts rawQuestions
  console.log questions: app.questions



# Private Variables
parseFacebookPosts = (posts) ->
  for quizItem in posts
    parsed = {}
    # Questions are any post message
    parsed.Q = markdown.toHTML quizItem.message
    # TODO: Answers are any comment that starts with "answer:"
    parsed.A = quizItem.comments?.data[0].message
    # TODO: Anything else is "discussion"
    app.questions.push parsed
  app.questions


