sub init()
  m.videoPlayer = m.top.findNode("videoPlayer")
  m.playerUi = m.top.findNode("playerUi")
  m.progressBarBkgd = m.top.findNode("progressBackground")
  m.progressBar = m.top.findNode("progressBar")
  m.currentTimeLabel = m.top.findNode("currentTime")
  m.totalTimeLabel = m.top.findNode("totalTime")
  m.currentSeconds = 0
  m.totalSeconds = 10 * 60 + 35
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
  ' Set up video content object
  videoContent = createObject("RoSGNode", "ContentNode")
  videoContent.title = "Example Video"
  videoContent.streamformat = "mp4"
  videoContent.url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"

  ' Set Up player
  m.videoPlayer.EnableCookies()
  m.videoPlayer.setCertificatesFile("common:/certs/ca-bundle.crt")
  m.videoPlayer.InitClientCertificates()
  ' Set event handlers and position notification to 1 second
  m.videoPlayer.notificationInterval = 1
  m.videoPlayer.observeFieldScoped("position", "onPlayerPositionChanged")
  m.videoPlayer.observeFieldScoped("state", "onPlayerStateChanged")
  ' Set the content to the video node
  m.videoPlayer.content = videoContent
  m.videoPlayer.enableUI = true
  setUI(false)
  'm.videoPlayer.setFocus(true)
  ' Start it playing
  m.videoPlayer.control = "play"
end sub

sub onPlayerPositionChanged(obj)
  m.currentSeconds = obj.getData()
  ? "Player Position: ", m.currentSeconds
end sub


sub setUI(visible)
  m.playerUi.visible = visible
  m.currentTimeLabel.text = secondsToMMSS(m.currentSeconds)
  m.totalTimeLabel.text = secondsToMMSS(m.totalSeconds)
  m.progressBar.width = (m.currentSeconds / m.totalSeconds) * m.progressBarBkgd.width
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
    setUI(false)
  else
    m.videoPlayer.control = "pause"
    setUI(true)
  end if
end sub

sub closeVideo()
  m.videoPlayer.control = "stop"
  parent = m.top.getParent()
  parent.callFunc("screenRefocus")
end sub

function secondsToMMSS(timeInSeconds)
  minutes = fix(timeInSeconds / 60)
  seconds = timeInSeconds mod 60
  timeText = minutes.toStr() + ":"
  if seconds < 10
    timeText += "0"
  end if
  timeText += seconds.toStr()
  return timeText
end function
