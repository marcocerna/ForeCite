angular.module('ForeCite')
.filter 'domains', ->
  return (str) ->
    url = document.createElement('a')
    url.href = str
    return url.hostname
