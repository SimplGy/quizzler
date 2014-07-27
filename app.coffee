

isLoggedIn = false;
loginBtn = document.getElementById 'FacebookLogin'

window.fbAsyncInit = ->
  console.log 'facebook ready'

  FB.init
    appId      : '1538565359705638'
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

  FB.api 'me', (asdf) -> console.log asdf
  FB.api 'angularjs', (asdf) -> console.log asdf
  FB.api 'angularjs/feed', (asdf) -> console.log asdf


onLogOut = ->
  isLoggedIn = false
  loginBtn.textContent = 'Log In'

