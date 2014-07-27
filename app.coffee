
# Global Appliation Variables
isLoggedIn = false
questions = []
thinkingClass = 'thinking'

# Cache DOM Elements
goBtn = document.getElementById 'GoButton'
skipBtn = document.getElementById 'SkipBtn'
logOutBtn = document.getElementById 'LogOutBtn'
body = document.getElementsByTagName('body')[0]
questionsEl = document.getElementById 'Questions'
#pageEls = document.getElementsByClassName 'page'
#pages = {}
# Transform page els into a hash by pageName
#for page in pageEls



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


# Navigation --------------------------------------------------------------------------------------
app = {}
app.showPage = (pageName) ->
  body.className = pageName
#  page = pages[pageName]
#  return unless page
#  for page in pages
#    removeClass page 'show'

app.showPage 'landing' # start page



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






# Landing Page --------------------------------------------------------------------------------------
goBtn.onclick = (evt) ->
  evt.preventDefault()
  return if hasClass goBtn, thinkingClass
  if isLoggedIn
#    FB.logout onLogOut
    app.showPage 'quiz'
  else
    Array.prototype.push.call goBtn.classList, thinkingClass
    FB.login  (resp) ->
      if resp.authResponse
        console.log 'Login successful'
        onLogIn()
      else
        console.warn 'User cancelled login or did not fully authorize.'
        onLogOut()

onLogIn = ->
  console.log 'isLoggedIn', isLoggedIn = true
  goBtn.textContent = 'Start'
  FB.api 'me', (resp) -> console.log me:resp
  FB.api 'jsquizzler/statuses', gotQuizData

onLogOut = ->
  console.log 'isLoggedIn', isLoggedIn = false
  app.showPage 'landing'
  goBtn.textContent = 'Log In'

gotQuizData = (resp) ->
  console.log resp.data
  parseFacebookPosts resp.data




# Quiz Page --------------------------------------------------------------------------------------
skipBtn.onclick = (evt) ->
  evt.preventDefault()
  app.showPage 'results'

logOutBtn.onclick = (evt) ->
  evt.prevendDefault()
  FB.logout onLogOut

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