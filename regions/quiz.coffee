

app.els.skipBtn = document.getElementById 'SkipBtn'
app.els.questions = document.getElementById 'Questions'
app.els.answers = document.getElementById 'Answers'
questionIndex = 0
#pageEls = document.getElementsByClassName 'page'
#pages = {}
# Transform page els into a hash by pageName
#for page in pageEls


# Quiz Page --------------------------------------------------------------------------------------
window.app.pages.quiz =
  show: ->
    console.log 'showing quiz page'
    showNextQuestion()
  hide: ->
    console.log 'hiding quiz page'

# Private Event Bindings
app.els.skipBtn.onclick = (evt) ->
  evt.preventDefault()
  showNextQuestion()

# Private Methods
showNextQuestion = ->
  showQuestion questionIndex
  questionIndex++
  if questionIndex is app.questions.length then questionIndex = 0 # Restart at 0
  questionIndex

showQuestion = (idx) ->
  app.els.questions.innerHTML = (questionIndex+1) + ': ' + app.questions[idx].Q
  app.els.answers.innerHTML = buildAnswerButtons [ 'true', 'false' ]
  Prism.highlightAll() #TODO: highlight only the new element

#showAllQuestions = ->
#  markup = ''
#  for question in app.questions
#    markup += question.Q
#  app.els.questions.innerHTML = markup
#  Prism.highlightAll()

buildAnswerButtons = (answers) ->
  markup = ''
  for answer in answers
    markup += "<a class='btn' href='javascript:void(0);'>#{answer}</a>"
  markup