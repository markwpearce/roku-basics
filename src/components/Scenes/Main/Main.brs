' Each component has an "init" function that is called at the beginning of the lifecycle
sub init()
  ' "m" is like "this"
  ' "m.top" is a reference to the component's Scenegraph node
  m.top.setFocus(true)

  ' Get a reference to a children of the node so you can interact with it
  ' findNode(child_id) can be used to get a reference to a node
  m.helloLabel = m.top.findNode("helloLabel")
end sub


' onKeyEvent is called on the focused component when there is input from the remote
function onKeyEvent(key as string, press as boolean) as boolean
  if press
    print "Button press: "; key

    if "OK" = key
      changeGreeting()
    end if
  end if
end function


' Functions can be defined, an can be used in the scope of the component
sub changeGreeting()
  ' Define an array
  greetings = ["world", "Alice", "Bob", "Charlie", "Debbie"]
  ' Change the label's text to a random string
  m.helloLabel.text = "Hello " + greetings[rnd(greetings.count()) - 1]
end sub