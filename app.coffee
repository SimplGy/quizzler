

isLoggedIn = false;
loginBtn = document.getElementById 'FacebookLogin'
questionsEl = document.getElementById 'Questions'
questions = []

window.fbAsyncInit = ->
  console.log 'facebook ready'

  FB.init
    appId      : if window.location.hostname is 'localhost' then '1538582919703882' else '1538565359705638'
    xfbml      : true
    version    : 'v2.0'

  FB.getLoginStatus (response) ->
    if response.status is 'connected'
      onLogIn()
    else
      onLogOut()


loginBtn.onclick = (evt) ->
  evt.preventDefault()
  loginBtn.textContent = '...'
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
  loginBtn.textContent = 'Log Out'

  FB.api 'me',                  (resp) -> console.log me:resp
#  FB.api 'jsquizzler',          (resp) -> console.log jsQuizzler:resp
#  FB.api 'jsquizzler/feed',     (resp) -> console.log jsQuizzlerFeed:resp
  FB.api 'jsquizzler/statuses', gotQuizData


onLogOut = ->
  isLoggedIn = false
  loginBtn.textContent = 'Log In'

gotQuizData = (resp) ->
  console.log resp.data
  parseFacebookPosts resp.data
  showOneQuestion()

parseFacebookPosts = (posts) ->
  for quizItem in posts
    parsed = {}
    parsed.A = quizItem.comments.data[0].message #.split('A:\n')
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