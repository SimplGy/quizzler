
app.els.goBtn = document.getElementById 'GoButton'
thinkingClass = 'thinking'


# Landing Page --------------------------------------------------------------------------------------
window.app.pages.landing =
  show: ->
    console.log 'showing landing page'
    FB.getLoginStatus (response) ->
      dom.removeClass app.els.goBtn, thinkingClass
      if response.status is 'connected'
        onLogIn()
      else
        onLogOut()
  hide: ->
    console.log 'hiding landing page'


# Private Event Bindings
app.els.goBtn.onclick = (evt) ->
  evt.preventDefault()
  return if dom.hasClass app.els.goBtn, thinkingClass
  if app.isLoggedIn
#    FB.logout onLogOut
    app.showPage 'quiz'
  else
    Array.prototype.push.call app.els.goBtn.classList, thinkingClass
    FB.login (resp) ->
      if resp.authResponse
        console.log 'Login successful'
        onLogIn()
      else
        console.warn 'User cancelled login or did not fully authorize.'
        onLogOut()


# Private Event Handlers
onLogIn = ->
  console.log 'isLoggedIn', app.isLoggedIn = true
  app.els.goBtn.textContent = 'Start'
#  FB.api 'me', (resp) -> console.log me:resp
  FB.api 'jsquizzler/statuses', gotQuizData

onLogOut = ->
  console.log 'isLoggedIn', app.isLoggedIn = false
  app.showPage 'landing'
  app.els.goBtn.textContent = 'Log In'

gotQuizData = (resp) ->
  console.log rawData: resp.data
  app.questions.add resp.data
