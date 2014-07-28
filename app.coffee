


# Global Appliation Object/Namespace
window.app =
  # App State
  isLoggedIn: false
  # Cache DOM Elements
  els:
    body: body = document.getElementsByTagName('body')[0]
  # "Page" Objects/Controllerviews
  pages: {}
  # Methods
  init: ->
    FB.init
      appId  : if window.location.hostname is 'localhost' then '1538582919703882' else '1538565359705638'
      xfbml  : true
      version: 'v2.0'
    app.showPage('landing');
  showPage: (pageName) ->
    body.className = pageName
    newPage = app.pages[pageName]
    if typeof newPage?.show is 'function'
      newPage.show()
      app.curPage?.hide()
      app.curPage = newPage
    else
      console.warn "No show method for page [#{pageName}]"



# Helper Utils ----------------------------------------------------------------------------------------
window.dom =
  hasClass: (node, className) ->
    idx = Array.prototype.indexOf.call node, className
    if idx < 0
      return undefined
    else
      return idx
  removeClass: (node, className) ->
    idx = Array.prototype.indexOf.call node, className
    return if idx < 0
    node.classList.splice idx, 1


# Navigation --------------------------------------------------------------------------------------
#  page = pages[pageName]
#  return unless page
#  for page in pages
#    removeClass page 'show'





