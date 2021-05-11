sub init()
  m.videoPlayer = m.top.findNode("videoPlayer")
  initializeVideoPlayer()
end sub

' onKeyEvent is called on the focused component when there is input from the remote
function onKeyEvent(key as string, press as boolean) as boolean
  if press
    if "play" = key
      togglePlayPause()
    else if "back" = key
      closeVideo()
    end if
  end if
end function

sub initializeVideoPlayer()
  videoContent = createObject("RoSGNode", "ContentNode")
  videoContent.title = "Example Video"
  videoContent.streamformat = "mp4"
  videoContent.url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"

  m.videoPlayer.EnableCookies()
  m.videoPlayer.setCertificatesFile("common:/certs/ca-bundle.crt")
  m.videoPlayer.InitClientCertificates()
  'set position notification to 1 second
  m.videoPlayer.notificationInterval = 1
  m.videoPlayer.observeFieldScoped("position", "onPlayerPositionChanged")
  m.videoPlayer.observeFieldScoped("state", "onPlayerStateChanged")
  m.videoPlayer.enableUI = true
  m.videoPlayer.enableTrickPlay = true
  m.videoPlayer.content = videoContent
  m.videoPlayer.setFocus(true)
  m.videoPlayer.control = "play"

end sub


sub onPlayerPositionChanged(obj)
  ? "Player Position: ", obj.getData()
end sub

sub onPlayerStateChanged(obj)
  state = obj.getData()
  ? "onPlayerStateChanged: ";state
  if state = "error"
    ?m.videoPlayer.errorMsg;" ";"Error Code: " + m.videoPlayer.errorCode.toStr()
  else if state = "finished"
    closeVideo()
  end if
end sub


sub togglePlayPause()
  if "paused" = m.videoPlayer.state
    m.videoPlayer.control = "resume"
  else
    m.videoPlayer.control = "pause"
  end if
end sub

sub closeVideo()
  m.videoPlayer.control = "stop"
  parent = m.top.getParent()
  parent.callFunc("screenRefocus")
end sub