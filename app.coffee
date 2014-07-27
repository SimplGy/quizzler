
# Global Appliation Variables
isLoggedIn = false
questions = []
thinkingClass = 'thinking'

# Cache DOM Elements
goBtn = document.getElementById 'GoButton'
questionsEl = document.getElementById 'Questions'


# Helper Utils ----------------------------------------------------------------------------------------
hasClass = (node, className) ->
  idx = Array.prototype.indexOf.call node, className
  if idx < 0
    return undefined
  else
    return idx

removeClass = (node, className) ->
  idx = Array.prototype.indexOf.call node, className
  return if idx < 0
  node.classList.splice idx, 1


# App Bootstrap ----------------------------------------------------------------------------------------
window.fbAsyncInit = ->
  console.log 'facebook ready'

  FB.init
    appId  : if window.location.hostname is 'localhost' then '1538582919703882' else '1538565359705638'
    xfbml  : true
    version: 'v2.0'

  FB.getLoginStatus (response) ->
    removeClass goBtn, thinkingClass
    if response.status is 'connected'
      onLogIn()
    else
      onLogOut()


# Navigation --------------------------------------------------------------------------------------
app = {}
app.showPage = (page) ->
  pageEl = document.getElementsByClassName page + ' page' # Pages are expected to have 2 classes: the page name and the class `page`
  return unless pageEl.length is 1
  pageEl = pageEl[0]




# Landing Page --------------------------------------------------------------------------------------
goBtn.onclick = (evt) ->
  return if hasClass goBtn, thinkingClass
  goBtn.classList.push thinkingClass
  evt.preventDefault()
  if isLoggedIn
    FB.logout onLogOut
  else
    FB.login  (resp) ->
      if resp.authResponse
        console.log 'Login successful'
        onLogIn()
      else
        console.warn 'User cancelled login or did not fully authorize.'
        onLogOut()

onLogIn = ->
  isLoggedIn = true
  goBtn.textContent = 'Start'
  FB.api 'me', (resp) -> console.log me:resp
  FB.api 'jsquizzler/statuses', gotQuizData

onLogOut = ->
  isLoggedIn = false
  goBtn.textContent = 'Log In'

gotQuizData = (resp) ->
  console.log resp.data
  parseFacebookPosts resp.data




# Quiz Page --------------------------------------------------------------------------------------

#  showAllQuestions()

parseFacebookPosts = (posts) ->
  for quizItem in posts
    parsed = {}
    parsed.A = quizItem.comments?.data[0].message #.split('A:\n')
    q = quizItem.message.split('Q:\n')
    if q.length is 2
      parsed.Q = markdown.toHTML q[1]
    questions.push parsed
  questions

showOneQuestion = (idx) ->
  idx = idx || 0
  questionsEl.innerHTML = questions[idx].Q
  Prism.highlightAll()

showAllQuestions = ->
  markup = ''
  for question in questions
    markup += question.Q
  questionsEl.innerHTML = markup
  Prism.highlightAll()