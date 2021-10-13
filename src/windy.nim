import windy/common

export common

when defined(windows):
  import windy/platforms/win32/platform
elif defined(linux):
  import windy/platforms/x11/platform

type
  Window* = ref object
    platform: PlatformWindow


proc init*() {.raises: [WindyError]} =
  platformInit()

proc pollEvents*() =
  for window in windows:
    window.pollEvents()


proc newWindow*(
  windowTitle: string, width, height: int
): Window {.raises: [WindyError]} =
  result = Window()
  result.platform = newPlatformWindow(windowTitle, width, height)

proc makeContextCurrent*(window: Window) {.raises: [WindyError]} =
  window.platform.makeContextCurrent()

proc swapBuffers*(window: Window) {.raises: [WindyError]} =
  window.platform.swapBuffers()

proc `visible`*(window: Window): bool =
  discard

proc `visible=`*(window: Window, visible: bool) =
  if visible:
    window.platform.show()
  else:
    window.platform.hide()

proc isOpen*(window: Window): bool =
  window.platform.isOpen
