import ../../common, strutils, windefs

proc wstr*(str: string): string =
  let wlen = MultiByteToWideChar(
    CP_UTF8,
    0,
    str[0].unsafeAddr,
    str.len.int32,
    nil,
    0
  )
  result = newString(wlen * 2 + 1)
  discard MultiByteToWideChar(
    CP_UTF8,
    0,
    str[0].unsafeAddr,
    str.len.int32,
    cast[ptr WCHAR](result[0].addr),
    wlen
  )

proc checkHRESULT*(hresult: HRESULT) =
  if hresult != S_OK:
    raise newException(WindyError, "Unexpected hresult " & toHex(hresult))

proc wmEventName*(wm: int | UINT): string =
  case wm:
  of WM_GETMINMAXINFO:
    "WM_GETMINMAXINFO"
  of WM_NCCREATE:
    "WM_NCCREATE"
  of WM_CREATE:
    "WM_CREATE"
  of WM_NCCALCSIZE:
    "WM_NCCALCSIZE"
  of WM_SHOWWINDOW:
    "WM_SHOWWINDOW"
  of WM_WINDOWPOSCHANGING:
    "WM_WINDOWPOSCHANGING"
  of WM_WINDOWPOSCHANGED:
    "WM_WINDOWPOSCHANGED"
  of WM_ACTIVATEAPP:
    "WM_ACTIVATEAPP"
  of WM_ACTIVATE:
    "WM_ACTIVATE"
  of WM_NCACTIVATE:
    "WM_NCACTIVATE"
  of WM_NCPAINT:
    "WM_NCPAINT"
  of WM_ERASEBKGND:
    "WM_ERASEBKGND"
  of WM_PAINT:
    "WM_PAINT"
  of WM_GETICON:
    "WM_GETICON"
  of WM_IME_SETCONTEXT:
    "WM_IME_SETCONTEXT"
  of WM_IME_NOTIFY:
    "WM_IME_NOTIFY"
  of WM_DWMCOMPOSITIONCHANGED:
    "WM_DWMCOMPOSITIONCHANGED"
  of WM_DWMNCRENDERINGCHANGED:
    "WM_DWMNCRENDERINGCHANGED"
  of WM_DWMCOLORIZATIONCOLORCHANGED:
    "WM_DWMCOLORIZATIONCOLORCHANGED"
  of WM_DWMWINDOWMAXIMIZEDCHANGE:
    "WM_DWMWINDOWMAXIMIZEDCHANGE"
  of WM_DWMSENDICONICTHUMBNAIL:
    "WM_DWMSENDICONICTHUMBNAIL"
  of WM_DWMSENDICONICLIVEPREVIEWBITMAP:
    "WM_DWMSENDICONICLIVEPREVIEWBITMAP"
  of WM_SIZE:
    "WM_SIZE"
  of WM_MOVE:
    "WM_MOVE"
  of WM_SETFOCUS:
    "WM_SETFOCUS"
  of WM_KILLFOCUS:
    "WM_KILLFOCUS"
  of WM_ENABLE:
    "WM_ENABLE"
  of WM_DESTROY:
    "WM_DESTROY"
  of WM_DPICHANGED:
    "WM_DPICHANGED"
  of WM_NULL:
    "WM_NULL"
  of WM_MOUSEMOVE:
    "WM_MOUSEMOVE"
  of WM_MOUSEWHEEL:
    "WM_MOUSEWHEEL"
  of WM_MOUSEHWHEEL:
    "WM_MOUSEHWHEEL"
  of WM_MOUSELEAVE:
    "WM_MOUSELEAVE"
  else:
    "WM " & $wm & " " & $toHex(wm)
