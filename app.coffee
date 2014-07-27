

isLoggedIn = false;
loginBtn = document.getElementById 'FacebookLogin'
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
  el = document.getElementById 'Questions'
  parseFacebookPosts resp.data
  markup = ''
  for question in questions
    markup += question.Q
  el.innerHTML = markup
  Prism.highlightAll()



#  el.innerHTML = markup


parseFacebookPosts = (posts) ->
  for quizItem in posts
    parsed = {}
    parsed.A = quizItem.comments.data[0].message #.split('A:\n')
    q = quizItem.message.split('Q:\n')
    if q.length is 2
      parsed.Q = markdown.toHTML q[1]
    questions.push parsed
  questions


