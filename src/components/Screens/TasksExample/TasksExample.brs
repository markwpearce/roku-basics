
sub init()
  m.dadJokes = invalid
  m.jokeLabel = m.top.findNode("jokeLabel")
end sub

' onKeyEvent is called on the focused component when there is input from the remote
function onKeyEvent(key as string, press as boolean) as boolean
  if press
    if "OK" = key
      getJoke()
    else if "back" = key
      parent = m.top.getParent()
      parent.callFunc("screenRefocus")
    end if
  end if
end function

sub getJoke()
  m.jokeLabel.text = "..."
  m.dadJokes = createObject("roSGNode", "DadJoke")
  m.dadJokes.observeFieldScoped("isGettingJoke", "displayJoke")
  m.dadJokes.control = "RUN"

end sub

sub displayJoke()
  if invalid <> m.dadJokes and false = m.dadJokes.isGettingJoke
    m.jokeLabel.text = m.dadJokes.jokeText
    m.dadJokes.unobserveFieldScoped("isGettingJoke")
  end if
end sub