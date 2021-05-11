

' Each component has an "init" function that is called at the beginning of the lifecycle

function init()
  ' Set up List actions
  m.exampleList = m.top.findNode("exampleList")
  m.exampleList.observeFieldScoped("itemSelected", "onExampleSelected")
  m.subScreen = invalid
  screenRefocus()
end function

sub onExampleSelected(obj)
  example = m.exampleList.content.getChild(obj.getData())
  ? "onExampleSelected selected ContentNode: ";example
  if invalid <> example.description
    m.subScreen = CreateObject("roSgNode", example.description)
    m.top.appendChild(m.subScreen)
    m.subScreen.setFocus(true)
    m.exampleList.visible = false
  end if
end sub


sub screenRefocus()
  m.exampleList.visible = true
  if m.subScreen <> invalid
    m.top.removeChild(m.subScreen)
  end if
  m.exampleList.setFocus(true)
end sub