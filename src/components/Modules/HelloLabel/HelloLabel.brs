' Each component has an "init" function that is called at the beginning of the lifecycle
sub init()
  ' Get a reference to a children of the node so you can interact with it
  ' findNode(child_id) can be used to get a reference to a node
  m.textLabel = m.top.findNode("textLabel")
  if invalid = m.top.greetings
    ' define a default array
    m.top.greetings = ["world", "Alice", "Bob", "Charlie", "Debbie"]
  end if
  changeGreeting()
end sub


' onKeyEvent is called on the focused component when there is input from the remote
function onKeyEvent(key as string, press as boolean) as boolean
  if press
    print "Button press: "; key

    if "OK" = key
      changeGreeting()
      return true
    end if
  end if
end function


' Functions can be defined, an can be used in the scope of the component
sub changeGreeting()
  if invalid = m.top.greetings
    return
  end if
  ' Change the label's text to a random string
  m.textLabel.text = "Hello " + m.top.greetings[rnd(m.top.greetings.count()) - 1]
end sub

