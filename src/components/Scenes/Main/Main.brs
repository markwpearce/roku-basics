

' Each component has an "init" function that is called at the beginning of the lifecycle
sub init()
  ' "m" is like "this"
  ' "m.top" is a reference to the component's Scenegraph node
  ' Get a reference to a children of the node so you can interact with it
  ' findNode(child_id) can be used to get a reference to a node
  m.helloLabel = m.top.findNode("helloLabel")

  m.helloLabel.setFocus(true)

  m.colors = ["0x990000AA", "0x009900AA", "0x000099AA", "0x000000AA"]
  m.currentColor = 0

  m.people = [
    ["Super Man", "Batman", "Wonder Woman"],
    ["Black Widow", "Hulk", "Thor", "Scarlet Witch", "Gamora"],
    ["Fred", "Wilma", "Barney", "Bam Bam"],
    ["Ron", "Harry", "Hermione"]
  ]
  m.currentGreeting = 0
end sub


' onKeyEvent is called on the focused component when there is input from the remote
function onKeyEvent(key as string, press as boolean) as boolean
  if press
    if "up" = key
      setNextColor()
      return true
    end if
    if "down" = key
      setGreetings()
      return true
    end if
    if "right" = key or "left" = key
      moveLabel(key)
      return true
    end if
  end if
end function


' Change the label's bg to the next color
sub setNextColor()
  m.helloLabel.color = m.colors[m.currentColor]
  m.currentColor = (m.currentColor + 1) mod m.colors.count()
end sub

' Set the greetings for the custom label
sub setGreetings()
  m.helloLabel.greetings = m.people[m.currentGreeting]
  m.currentGreeting = (m.currentGreeting + 1) mod m.people.count()
end sub

' Move the label around
sub moveLabel(key)
  currentTranslation = m.helloLabel.translation ' translation is a vector [x, y]
  xDelta = 200
  if "left" = key
    xDelta *= -1
  end if
  currentTranslation[0] += xDelta
  m.helloLabel.setFields({
    translation: currentTranslation
  })
end sub