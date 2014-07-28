app.els.logOutBtn = document.getElementById 'LogOutBtn'

app.els.logOutBtn.onclick = (evt) ->
  evt.prevendDefault()
  FB.logout onLogOut