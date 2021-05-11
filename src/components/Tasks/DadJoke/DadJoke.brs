' Task init function
'
sub init()
  ' Specify the name of the function to run when task starts
  m.top.functionName = "getJoke"
  m.port = createObject("roMessagePort")
end sub

' Gets a Dad Joke from the https://icanhazdadjoke.com/ API
sub getJoke()
  ' Set up request
  url = "https://icanhazdadjoke.com/"
  httpRequest = CreateObject("roUrlTransfer")
  httpRequest.setPort(m.port)
  httpRequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
  httpRequest.SetUrl(url)
  httpRequest.SetHeaders({Accept: "application/json"})
  ' Add flag for other nodes to observe
  m.top.isGettingJoke = true

  ' Send GET request
  httpRequest.asyncGetToString()

  ' Wait for message
  msg = wait(10000, m.port)
  jokeText = ""

  if "roUrlEvent" = type(msg)
    ' handle HTTP Response
    m.top.status = msg.getResponseCode()

    if 200 = m.top.status
      ' Parse data from successful request
      responseStr = msg.getString()
      print "Joke response: "; responseStr
      responseJson = ParseJson(responseStr)
      if invalid <> responseJson and invalid <> responseJson.joke
        m.top.jokeText = responseJson.joke
      end if
    else
      ' Error handling
      print "Error requesting jokes: "; msg.getFailureReason(); " "; m.top.status; " "; url
    end if
  else if invalid = msg
    print "Error requesting jokes"
    m.top.jokeText = ""
  end if
  m.top.isGettingJoke = false
end sub

