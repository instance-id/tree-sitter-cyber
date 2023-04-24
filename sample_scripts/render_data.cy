#!/usr/local/bin/cyber

type Vector2 object:
  x number
  y number
type Vector3 object:
  x number
  y number
  z number

type Vector4 object:
  x number
  y number
  z number
  w number

type Quaternion Vector4
type Matrix object:
  m0 number
  m4 number
  m8 number
  m12 number
  m1 number
  m5 number
  m9 number
  m13 number
  m2 number
  m6 number
  m10 number
  m14 number
  m3 number
  m7 number
  m11 number
  m15 number

type Color object:
  r number
  g number
  b number
  a number

type Rectangle object:
  x number
  y number
  width number
  height number

type Image object:
  data pointer
  width number
  height number
  mipmaps number
  format number

type Texture object:
  id number
  width number
  height number
  mipmaps number
  format number

type Texture2D Texture
type TextureCubemap Texture
type RenderTexture object:
  id number
  texture Texture
  depth Texture

type RenderTexture2D RenderTexture
type NPatchInfo object:
  source Rectangle
  left number
  top number
  right number
  bottom number
  layout number

type GlyphInfo object:
  value number
  offsetX number
  offsetY number
  advanceX number
  image Image

type Font object:
  baseSize number
  glyphCount number
  glyphPadding number
  texture Texture2D
  recs pointer -- [*c]Rectangle
  glyphs pointer -- [*c]GlyphInfo

type Camera3D object:
  position Vector3
  target Vector3
  up Vector3
  fovy number
  projection number

type Camera Camera3D
type Camera2D object:
  offset Vector2
  target Vector2
  rotation number
  zoom number

type Mesh object:
  vertexCount number
  triangleCount number
  vertices pointer -- [*c]f32
  texcoords pointer -- [*c]f32
  texcoords2 pointer -- [*c]f32
  normals pointer -- [*c]f32
  tangents pointer -- [*c]f32
  colors pointer -- [*c]u8
  indices pointer -- [*c]c_ushort
  animVertices pointer -- [*c]f32
  animNormals pointer -- [*c]f32
  boneIds pointer -- [*c]u8
  boneWeights pointer -- [*c]f32
  vaoId number
  vboId pointer -- [*c]c_uint

type Shader object:
  id number
  locs pointer -- [*c]c_int

type MaterialMap object:
  texture Texture2D
  color Color
  value number

type Material object:
  shader Shader
  maps pointer -- [*c]MaterialMap
  params List -- [4]f32

type Transform object:
  translation Vector3
  rotation Quaternion
  scale Vector3

type BoneInfo object:
  name List -- [32]u8
  parent number

type Model object:
  transform Matrix
  meshCount number
  materialCount number
  meshes pointer -- [*c]Mesh
  materials pointer -- [*c]Material
  meshMaterial pointer -- [*c]c_int
  boneCount number
  bones pointer -- [*c]BoneInfo
  bindPose pointer -- [*c]Transform

type ModelAnimation object:
  boneCount number
  frameCount number
  bones pointer -- [*c]BoneInfo
  framePoses pointer -- [*c][*c]Transform

type Ray object:
  position Vector3
  direction Vector3

type RayCollision object:
  hit boolean
  distance number
  point Vector3
  normal Vector3

type BoundingBox object:
  min Vector3
  max Vector3

type Wave object:
  frameCount number
  sampleRate number
  sampleSize number
  channels number
  data pointer

type rAudioBuffer pointer
type rAudioProcessor pointer
type AudioStream object:
  buffer pointer -- ?*rAudioBuffer
  processor pointer -- ?*rAudioProcessor
  sampleRate number
  sampleSize number
  channels number

type Sound object:
  stream AudioStream
  frameCount number

type Music object:
  stream AudioStream
  frameCount number
  looping boolean
  ctxType number
  ctxData pointer

type VrDeviceInfo object:
  hResolution number
  vResolution number
  hScreenSize number
  vScreenSize number
  vScreenCenter number
  eyeToScreenDistance number
  lensSeparationDistance number
  interpupillaryDistance number
  lensDistortionValues List -- [4]f32
  chromaAbCorrection List -- [4]f32

type VrStereoConfig object:
  projection List -- [2]Matrix
  viewOffset List -- [2]Matrix
  leftLensCenter List -- [2]f32
  rightLensCenter List -- [2]f32
  leftScreenCenter List -- [2]f32
  rightScreenCenter List -- [2]f32
  scale List -- [2]f32
  scaleIn List -- [2]f32

type FilePathList object:
  capacity number
  count number
  paths pointer -- [*c][*c]u8

var FLAG_VSYNC_HINT: 64
var FLAG_FULLSCREEN_MODE: 2
var FLAG_WINDOW_RESIZABLE: 4
var FLAG_WINDOW_UNDECORATED: 8
var FLAG_WINDOW_HIDDEN: 128
var FLAG_WINDOW_MINIMIZED: 512
var FLAG_WINDOW_MAXIMIZED: 1024
var FLAG_WINDOW_UNFOCUSED: 2048
var FLAG_WINDOW_TOPMOST: 4096
var FLAG_WINDOW_ALWAYS_RUN: 256
var FLAG_WINDOW_TRANSPARENT: 16
var FLAG_WINDOW_HIGHDPI: 8192
var FLAG_WINDOW_MOUSE_PASSTHROUGH: 16384
var FLAG_MSAA_4X_HINT: 32
var FLAG_INTERLACED_HINT: 65536
type ConfigFlags number
var LOG_ALL: 0
var LOG_TRACE: 1
var LOG_DEBUG: 2
var LOG_INFO: 3
var LOG_WARNING: 4
var LOG_ERROR: 5
var LOG_FATAL: 6
var LOG_NONE: 7
type TraceLogLevel number
var KEY_NULL: 0
var KEY_APOSTROPHE: 39
var KEY_COMMA: 44
var KEY_MINUS: 45
var KEY_PERIOD: 46
var KEY_SLASH: 47
var KEY_ZERO: 48
var KEY_ONE: 49
var KEY_TWO: 50
var KEY_THREE: 51
var KEY_FOUR: 52
var KEY_FIVE: 53
var KEY_SIX: 54
var KEY_SEVEN: 55
var KEY_EIGHT: 56
var KEY_NINE: 57
var KEY_SEMICOLON: 59
var KEY_EQUAL: 61
var KEY_A: 65
var KEY_B: 66
var KEY_C: 67
var KEY_D: 68
var KEY_E: 69
var KEY_F: 70
var KEY_G: 71
var KEY_H: 72
var KEY_I: 73
var KEY_J: 74
var KEY_K: 75
var KEY_L: 76
var KEY_M: 77
var KEY_N: 78
var KEY_O: 79
var KEY_P: 80
var KEY_Q: 81
var KEY_R: 82
var KEY_S: 83
var KEY_T: 84
var KEY_U: 85
var KEY_V: 86
var KEY_W: 87
var KEY_X: 88
var KEY_Y: 89
var KEY_Z: 90
var KEY_LEFT_BRACKET: 91
var KEY_BACKSLASH: 92
var KEY_RIGHT_BRACKET: 93
var KEY_GRAVE: 96
var KEY_SPACE: 32
var KEY_ESCAPE: 256
var KEY_ENTER: 257
var KEY_TAB: 258
var KEY_BACKSPACE: 259
var KEY_INSERT: 260
var KEY_DELETE: 261
var KEY_RIGHT: 262
var KEY_LEFT: 263
var KEY_DOWN: 264
var KEY_UP: 265
var KEY_PAGE_UP: 266
var KEY_PAGE_DOWN: 267
var KEY_HOME: 268
var KEY_END: 269
var KEY_CAPS_LOCK: 280
var KEY_SCROLL_LOCK: 281
var KEY_NUM_LOCK: 282
var KEY_PRINT_SCREEN: 283
var KEY_PAUSE: 284
var KEY_F1: 290
var KEY_F2: 291
var KEY_F3: 292
var KEY_F4: 293
var KEY_F5: 294
var KEY_F6: 295
var KEY_F7: 296
var KEY_F8: 297
var KEY_F9: 298
var KEY_F10: 299
var KEY_F11: 300
var KEY_F12: 301
var KEY_LEFT_SHIFT: 340
var KEY_LEFT_CONTROL: 341
var KEY_LEFT_ALT: 342
var KEY_LEFT_SUPER: 343
var KEY_RIGHT_SHIFT: 344
var KEY_RIGHT_CONTROL: 345
var KEY_RIGHT_ALT: 346
var KEY_RIGHT_SUPER: 347
var KEY_KB_MENU: 348
var KEY_KP_0: 320
var KEY_KP_1: 321
var KEY_KP_2: 322
var KEY_KP_3: 323
var KEY_KP_4: 324
var KEY_KP_5: 325
var KEY_KP_6: 326
var KEY_KP_7: 327
var KEY_KP_8: 328
var KEY_KP_9: 329
var KEY_KP_DECIMAL: 330
var KEY_KP_DIVIDE: 331
var KEY_KP_MULTIPLY: 332
var KEY_KP_SUBTRACT: 333
var KEY_KP_ADD: 334
var KEY_KP_ENTER: 335
var KEY_KP_EQUAL: 336
var KEY_BACK: 4
var KEY_MENU: 82
var KEY_VOLUME_UP: 24
var KEY_VOLUME_DOWN: 25
type KeyboardKey number
var MOUSE_BUTTON_LEFT: 0
var MOUSE_BUTTON_RIGHT: 1
var MOUSE_BUTTON_MIDDLE: 2
var MOUSE_BUTTON_SIDE: 3
var MOUSE_BUTTON_EXTRA: 4
var MOUSE_BUTTON_FORWARD: 5
var MOUSE_BUTTON_BACK: 6
type MouseButton number
var MOUSE_CURSOR_DEFAULT: 0
var MOUSE_CURSOR_ARROW: 1
var MOUSE_CURSOR_IBEAM: 2
var MOUSE_CURSOR_CROSSHAIR: 3
var MOUSE_CURSOR_POINTING_HAND: 4
var MOUSE_CURSOR_RESIZE_EW: 5
var MOUSE_CURSOR_RESIZE_NS: 6
var MOUSE_CURSOR_RESIZE_NWSE: 7
var MOUSE_CURSOR_RESIZE_NESW: 8
var MOUSE_CURSOR_RESIZE_ALL: 9
var MOUSE_CURSOR_NOT_ALLOWED: 10
type MouseCursor number
var GAMEPAD_BUTTON_UNKNOWN: 0
var GAMEPAD_BUTTON_LEFT_FACE_UP: 1
var GAMEPAD_BUTTON_LEFT_FACE_RIGHT: 2
var GAMEPAD_BUTTON_LEFT_FACE_DOWN: 3
var GAMEPAD_BUTTON_LEFT_FACE_LEFT: 4
var GAMEPAD_BUTTON_RIGHT_FACE_UP: 5
var GAMEPAD_BUTTON_RIGHT_FACE_RIGHT: 6
var GAMEPAD_BUTTON_RIGHT_FACE_DOWN: 7
var GAMEPAD_BUTTON_RIGHT_FACE_LEFT: 8
var GAMEPAD_BUTTON_LEFT_TRIGGER_1: 9
var GAMEPAD_BUTTON_LEFT_TRIGGER_2: 10
var GAMEPAD_BUTTON_RIGHT_TRIGGER_1: 11
var GAMEPAD_BUTTON_RIGHT_TRIGGER_2: 12
var GAMEPAD_BUTTON_MIDDLE_LEFT: 13
var GAMEPAD_BUTTON_MIDDLE: 14
var GAMEPAD_BUTTON_MIDDLE_RIGHT: 15
var GAMEPAD_BUTTON_LEFT_THUMB: 16
var GAMEPAD_BUTTON_RIGHT_THUMB: 17
type GamepadButton number
var GAMEPAD_AXIS_LEFT_X: 0
var GAMEPAD_AXIS_LEFT_Y: 1
var GAMEPAD_AXIS_RIGHT_X: 2
var GAMEPAD_AXIS_RIGHT_Y: 3
var GAMEPAD_AXIS_LEFT_TRIGGER: 4
var GAMEPAD_AXIS_RIGHT_TRIGGER: 5
type GamepadAxis number
var MATERIAL_MAP_ALBEDO: 0
var MATERIAL_MAP_METALNESS: 1
var MATERIAL_MAP_NORMAL: 2
var MATERIAL_MAP_ROUGHNESS: 3
var MATERIAL_MAP_OCCLUSION: 4
var MATERIAL_MAP_EMISSION: 5
var MATERIAL_MAP_HEIGHT: 6
var MATERIAL_MAP_CUBEMAP: 7
var MATERIAL_MAP_IRRADIANCE: 8
var MATERIAL_MAP_PREFILTER: 9
var MATERIAL_MAP_BRDF: 10
type MaterialMapIndex number
var SHADER_LOC_VERTEX_POSITION: 0
var SHADER_LOC_VERTEX_TEXCOORD01: 1
var SHADER_LOC_VERTEX_TEXCOORD02: 2
var SHADER_LOC_VERTEX_NORMAL: 3
var SHADER_LOC_VERTEX_TANGENT: 4
var SHADER_LOC_VERTEX_COLOR: 5
var SHADER_LOC_MATRIX_MVP: 6
var SHADER_LOC_MATRIX_VIEW: 7
var SHADER_LOC_MATRIX_PROJECTION: 8
var SHADER_LOC_MATRIX_MODEL: 9
var SHADER_LOC_MATRIX_NORMAL: 10
var SHADER_LOC_VECTOR_VIEW: 11
var SHADER_LOC_COLOR_DIFFUSE: 12
var SHADER_LOC_COLOR_SPECULAR: 13
var SHADER_LOC_COLOR_AMBIENT: 14
var SHADER_LOC_MAP_ALBEDO: 15
var SHADER_LOC_MAP_METALNESS: 16
var SHADER_LOC_MAP_NORMAL: 17
var SHADER_LOC_MAP_ROUGHNESS: 18
var SHADER_LOC_MAP_OCCLUSION: 19
var SHADER_LOC_MAP_EMISSION: 20
var SHADER_LOC_MAP_HEIGHT: 21
var SHADER_LOC_MAP_CUBEMAP: 22
var SHADER_LOC_MAP_IRRADIANCE: 23
var SHADER_LOC_MAP_PREFILTER: 24
var SHADER_LOC_MAP_BRDF: 25
type ShaderLocationIndex number
var SHADER_UNIFORM_FLOAT: 0
var SHADER_UNIFORM_VEC2: 1
var SHADER_UNIFORM_VEC3: 2
var SHADER_UNIFORM_VEC4: 3
var SHADER_UNIFORM_INT: 4
var SHADER_UNIFORM_IVEC2: 5
var SHADER_UNIFORM_IVEC3: 6
var SHADER_UNIFORM_IVEC4: 7
var SHADER_UNIFORM_SAMPLER2D: 8
type ShaderUniformDataType number
var SHADER_ATTRIB_FLOAT: 0
var SHADER_ATTRIB_VEC2: 1
var SHADER_ATTRIB_VEC3: 2
var SHADER_ATTRIB_VEC4: 3
type ShaderAttributeDataType number
var PIXELFORMAT_UNCOMPRESSED_GRAYSCALE: 1
var PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA: 2
var PIXELFORMAT_UNCOMPRESSED_R5G6B5: 3
var PIXELFORMAT_UNCOMPRESSED_R8G8B8: 4
var PIXELFORMAT_UNCOMPRESSED_R5G5B5A1: 5
var PIXELFORMAT_UNCOMPRESSED_R4G4B4A4: 6
var PIXELFORMAT_UNCOMPRESSED_R8G8B8A8: 7
var PIXELFORMAT_UNCOMPRESSED_R32: 8
var PIXELFORMAT_UNCOMPRESSED_R32G32B32: 9
var PIXELFORMAT_UNCOMPRESSED_R32G32B32A32: 10
var PIXELFORMAT_COMPRESSED_DXT1_RGB: 11
var PIXELFORMAT_COMPRESSED_DXT1_RGBA: 12
var PIXELFORMAT_COMPRESSED_DXT3_RGBA: 13
var PIXELFORMAT_COMPRESSED_DXT5_RGBA: 14
var PIXELFORMAT_COMPRESSED_ETC1_RGB: 15
var PIXELFORMAT_COMPRESSED_ETC2_RGB: 16
var PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA: 17
var PIXELFORMAT_COMPRESSED_PVRT_RGB: 18
var PIXELFORMAT_COMPRESSED_PVRT_RGBA: 19
var PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA: 20
var PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA: 21
type PixelFormat number
var TEXTURE_FILTER_POINT: 0
var TEXTURE_FILTER_BILINEAR: 1
var TEXTURE_FILTER_TRILINEAR: 2
var TEXTURE_FILTER_ANISOTROPIC_4X: 3
var TEXTURE_FILTER_ANISOTROPIC_8X: 4
var TEXTURE_FILTER_ANISOTROPIC_16X: 5
type TextureFilter number
var TEXTURE_WRAP_REPEAT: 0
var TEXTURE_WRAP_CLAMP: 1
var TEXTURE_WRAP_MIRROR_REPEAT: 2
var TEXTURE_WRAP_MIRROR_CLAMP: 3
type TextureWrap number
var CUBEMAP_LAYOUT_AUTO_DETECT: 0
var CUBEMAP_LAYOUT_LINE_VERTICAL: 1
var CUBEMAP_LAYOUT_LINE_HORIZONTAL: 2
var CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR: 3
var CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE: 4
var CUBEMAP_LAYOUT_PANORAMA: 5
type CubemapLayout number
var FONT_DEFAULT: 0
var FONT_BITMAP: 1
var FONT_SDF: 2
type FontType number
var BLEND_ALPHA: 0
var BLEND_ADDITIVE: 1
var BLEND_MULTIPLIED: 2
var BLEND_ADD_COLORS: 3
var BLEND_SUBTRACT_COLORS: 4
var BLEND_ALPHA_PREMULTIPLY: 5
var BLEND_CUSTOM: 6
var BLEND_CUSTOM_SEPARATE: 7
type BlendMode number
var GESTURE_NONE: 0
var GESTURE_TAP: 1
var GESTURE_DOUBLETAP: 2
var GESTURE_HOLD: 4
var GESTURE_DRAG: 8
var GESTURE_SWIPE_RIGHT: 16
var GESTURE_SWIPE_LEFT: 32
var GESTURE_SWIPE_UP: 64
var GESTURE_SWIPE_DOWN: 128
var GESTURE_PINCH_IN: 256
var GESTURE_PINCH_OUT: 512
type Gesture number
var CAMERA_CUSTOM: 0
var CAMERA_FREE: 1
var CAMERA_ORBITAL: 2
var CAMERA_FIRST_PERSON: 3
var CAMERA_THIRD_PERSON: 4
type CameraMode number
var CAMERA_PERSPECTIVE: 0
var CAMERA_ORTHOGRAPHIC: 1
type CameraProjection number
var NPATCH_NINE_PATCH: 0
var NPATCH_THREE_PATCH_VERTICAL: 1
var NPATCH_THREE_PATCH_HORIZONTAL: 2
type NPatchLayout number
type TraceLogCallback pointer
type LoadFileDataCallback pointer
type SaveFileDataCallback pointer
type LoadFileTextCallback pointer
type SaveFileTextCallback pointer
func InitWindow(width number, height number, title pointer) pointer = lib.InitWindow
func WindowShouldClose() boolean = lib.WindowShouldClose
func CloseWindow() pointer = lib.CloseWindow
func IsWindowReady() boolean = lib.IsWindowReady
func IsWindowFullscreen() boolean = lib.IsWindowFullscreen
func IsWindowHidden() boolean = lib.IsWindowHidden
func IsWindowMinimized() boolean = lib.IsWindowMinimized
func IsWindowMaximized() boolean = lib.IsWindowMaximized
func IsWindowFocused() boolean = lib.IsWindowFocused
func IsWindowResized() boolean = lib.IsWindowResized
func IsWindowState(flag number) boolean = lib.IsWindowState
func SetWindowState(flags number) pointer = lib.SetWindowState
func ClearWindowState(flags number) pointer = lib.ClearWindowState
func ToggleFullscreen() pointer = lib.ToggleFullscreen
func MaximizeWindow() pointer = lib.MaximizeWindow
func MinimizeWindow() pointer = lib.MinimizeWindow
func RestoreWindow() pointer = lib.RestoreWindow
func SetWindowIcon(image Image) pointer = lib.SetWindowIcon
func SetWindowIcons(images pointer, count number) pointer = lib.SetWindowIcons
func SetWindowTitle(title pointer) pointer = lib.SetWindowTitle
func SetWindowPosition(x number, y number) pointer = lib.SetWindowPosition
func SetWindowMonitor(monitor number) pointer = lib.SetWindowMonitor
func SetWindowMinSize(width number, height number) pointer = lib.SetWindowMinSize
func SetWindowSize(width number, height number) pointer = lib.SetWindowSize
func SetWindowOpacity(opacity number) pointer = lib.SetWindowOpacity
func GetWindowHandle() pointer = lib.GetWindowHandle
func GetScreenWidth() number = lib.GetScreenWidth
func GetScreenHeight() number = lib.GetScreenHeight
func GetRenderWidth() number = lib.GetRenderWidth
func GetRenderHeight() number = lib.GetRenderHeight
func GetMonitorCount() number = lib.GetMonitorCount
func GetCurrentMonitor() number = lib.GetCurrentMonitor
func GetMonitorPosition(monitor number) Vector2 = lib.GetMonitorPosition
func GetMonitorWidth(monitor number) number = lib.GetMonitorWidth
func GetMonitorHeight(monitor number) number = lib.GetMonitorHeight
func GetMonitorPhysicalWidth(monitor number) number = lib.GetMonitorPhysicalWidth
func GetMonitorPhysicalHeight(monitor number) number = lib.GetMonitorPhysicalHeight
func GetMonitorRefreshRate(monitor number) number = lib.GetMonitorRefreshRate
func GetWindowPosition() Vector2 = lib.GetWindowPosition
func GetWindowScaleDPI() Vector2 = lib.GetWindowScaleDPI
func GetMonitorName(monitor number) pointer = lib.GetMonitorName
func SetClipboardText(text pointer) pointer = lib.SetClipboardText
func GetClipboardText() pointer = lib.GetClipboardText
func EnableEventWaiting() pointer = lib.EnableEventWaiting
func DisableEventWaiting() pointer = lib.DisableEventWaiting
func SwapScreenBuffer() pointer = lib.SwapScreenBuffer
func PollInputEvents() pointer = lib.PollInputEvents
func WaitTime(seconds number) pointer = lib.WaitTime
func ShowCursor() pointer = lib.ShowCursor
func HideCursor() pointer = lib.HideCursor
func IsCursorHidden() boolean = lib.IsCursorHidden
func EnableCursor() pointer = lib.EnableCursor
func DisableCursor() pointer = lib.DisableCursor
func IsCursorOnScreen() boolean = lib.IsCursorOnScreen
func ClearBackground(color Color) pointer = lib.ClearBackground
func BeginDrawing() pointer = lib.BeginDrawing
func EndDrawing() pointer = lib.EndDrawing
func BeginMode2D(camera Camera2D) pointer = lib.BeginMode2D
func EndMode2D() pointer = lib.EndMode2D
func BeginMode3D(camera Camera3D) pointer = lib.BeginMode3D
func EndMode3D() pointer = lib.EndMode3D
func BeginTextureMode(target RenderTexture) pointer = lib.BeginTextureMode
func EndTextureMode() pointer = lib.EndTextureMode
func BeginShaderMode(shader Shader) pointer = lib.BeginShaderMode
func EndShaderMode() pointer = lib.EndShaderMode
func BeginBlendMode(mode number) pointer = lib.BeginBlendMode
func EndBlendMode() pointer = lib.EndBlendMode
func BeginScissorMode(x number, y number, width number, height number) pointer = lib.BeginScissorMode
func EndScissorMode() pointer = lib.EndScissorMode
func BeginVrStereoMode(config VrStereoConfig) pointer = lib.BeginVrStereoMode
func EndVrStereoMode() pointer = lib.EndVrStereoMode
func LoadVrStereoConfig(device VrDeviceInfo) VrStereoConfig = lib.LoadVrStereoConfig
func UnloadVrStereoConfig(config VrStereoConfig) pointer = lib.UnloadVrStereoConfig
func LoadShader(vsFileName pointer, fsFileName pointer) Shader = lib.LoadShader
func LoadShaderFromMemory(vsCode pointer, fsCode pointer) Shader = lib.LoadShaderFromMemory
func IsShaderReady(shader Shader) boolean = lib.IsShaderReady
func GetShaderLocation(shader Shader, uniformName pointer) number = lib.GetShaderLocation
func GetShaderLocationAttrib(shader Shader, attribName pointer) number = lib.GetShaderLocationAttrib
func SetShaderValue(shader Shader, locIndex number, value pointer, uniformType number) pointer = lib.SetShaderValue
func SetShaderValueV(shader Shader, locIndex number, value pointer, uniformType number, count number) pointer = lib.SetShaderValueV
func SetShaderValueMatrix(shader Shader, locIndex number, mat Matrix) pointer = lib.SetShaderValueMatrix
func SetShaderValueTexture(shader Shader, locIndex number, texture Texture) pointer = lib.SetShaderValueTexture
func UnloadShader(shader Shader) pointer = lib.UnloadShader
func GetMouseRay(mousePosition Vector2, camera Camera3D) Ray = lib.GetMouseRay
func GetCameraMatrix(camera Camera3D) Matrix = lib.GetCameraMatrix
func GetCameraMatrix2D(camera Camera2D) Matrix = lib.GetCameraMatrix2D
func GetWorldToScreen(position Vector3, camera Camera3D) Vector2 = lib.GetWorldToScreen
func GetScreenToWorld2D(position Vector2, camera Camera2D) Vector2 = lib.GetScreenToWorld2D
func GetWorldToScreenEx(position Vector3, camera Camera3D, width number, height number) Vector2 = lib.GetWorldToScreenEx
func GetWorldToScreen2D(position Vector2, camera Camera2D) Vector2 = lib.GetWorldToScreen2D
func SetTargetFPS(fps number) pointer = lib.SetTargetFPS
func GetFPS() number = lib.GetFPS
func GetFrameTime() number = lib.GetFrameTime
func GetTime() number = lib.GetTime
func GetRandomValue(min number, max number) number = lib.GetRandomValue
func SetRandomSeed(seed number) pointer = lib.SetRandomSeed
func TakeScreenshot(fileName pointer) pointer = lib.TakeScreenshot
func SetConfigFlags(flags number) pointer = lib.SetConfigFlags
func SetTraceLogLevel(logLevel number) pointer = lib.SetTraceLogLevel
func MemAlloc(size number) pointer = lib.MemAlloc
func MemRealloc(ptr pointer, size number) pointer = lib.MemRealloc
func MemFree(ptr pointer) pointer = lib.MemFree
func OpenURL(url pointer) pointer = lib.OpenURL
func SetTraceLogCallback(callback pointer) pointer = lib.SetTraceLogCallback
func SetLoadFileDataCallback(callback pointer) pointer = lib.SetLoadFileDataCallback
func SetSaveFileDataCallback(callback pointer) pointer = lib.SetSaveFileDataCallback
func SetLoadFileTextCallback(callback pointer) pointer = lib.SetLoadFileTextCallback
func SetSaveFileTextCallback(callback pointer) pointer = lib.SetSaveFileTextCallback
func LoadFileData(fileName pointer, bytesRead pointer) pointer = lib.LoadFileData
func UnloadFileData(data pointer) pointer = lib.UnloadFileData
func SaveFileData(fileName pointer, data pointer, bytesToWrite number) boolean = lib.SaveFileData
func ExportDataAsCode(data pointer, size number, fileName pointer) boolean = lib.ExportDataAsCode
func LoadFileText(fileName pointer) pointer = lib.LoadFileText
func UnloadFileText(text pointer) pointer = lib.UnloadFileText
func SaveFileText(fileName pointer, text pointer) boolean = lib.SaveFileText
func FileExists(fileName pointer) boolean = lib.FileExists
func DirectoryExists(dirPath pointer) boolean = lib.DirectoryExists
func IsFileExtension(fileName pointer, ext pointer) boolean = lib.IsFileExtension
func GetFileLength(fileName pointer) number = lib.GetFileLength
func GetFileExtension(fileName pointer) pointer = lib.GetFileExtension
func GetFileName(filePath pointer) pointer = lib.GetFileName
func GetFileNameWithoutExt(filePath pointer) pointer = lib.GetFileNameWithoutExt
func GetDirectoryPath(filePath pointer) pointer = lib.GetDirectoryPath
func GetPrevDirectoryPath(dirPath pointer) pointer = lib.GetPrevDirectoryPath
func GetWorkingDirectory() pointer = lib.GetWorkingDirectory
func GetApplicationDirectory() pointer = lib.GetApplicationDirectory
func ChangeDirectory(dir pointer) boolean = lib.ChangeDirectory
func IsPathFile(path pointer) boolean = lib.IsPathFile
func LoadDirectoryFiles(dirPath pointer) FilePathList = lib.LoadDirectoryFiles
func LoadDirectoryFilesEx(basePath pointer, filter pointer, scanSubdirs boolean) FilePathList = lib.LoadDirectoryFilesEx
func UnloadDirectoryFiles(files FilePathList) pointer = lib.UnloadDirectoryFiles
func IsFileDropped() boolean = lib.IsFileDropped
func LoadDroppedFiles() FilePathList = lib.LoadDroppedFiles
func UnloadDroppedFiles(files FilePathList) pointer = lib.UnloadDroppedFiles
func GetFileModTime(fileName pointer) number = lib.GetFileModTime
func CompressData(data pointer, dataSize number, compDataSize pointer) pointer = lib.CompressData
func DecompressData(compData pointer, compDataSize number, dataSize pointer) pointer = lib.DecompressData
func EncodeDataBase64(data pointer, dataSize number, outputSize pointer) pointer = lib.EncodeDataBase64
func DecodeDataBase64(data pointer, outputSize pointer) pointer = lib.DecodeDataBase64
func IsKeyPressed(key number) boolean = lib.IsKeyPressed
func IsKeyDown(key number) boolean = lib.IsKeyDown
func IsKeyReleased(key number) boolean = lib.IsKeyReleased
func IsKeyUp(key number) boolean = lib.IsKeyUp
func SetExitKey(key number) pointer = lib.SetExitKey
func GetKeyPressed() number = lib.GetKeyPressed
func GetCharPressed() number = lib.GetCharPressed
func IsGamepadAvailable(gamepad number) boolean = lib.IsGamepadAvailable
func GetGamepadName(gamepad number) pointer = lib.GetGamepadName
func IsGamepadButtonPressed(gamepad number, button number) boolean = lib.IsGamepadButtonPressed
func IsGamepadButtonDown(gamepad number, button number) boolean = lib.IsGamepadButtonDown
func IsGamepadButtonReleased(gamepad number, button number) boolean = lib.IsGamepadButtonReleased
func IsGamepadButtonUp(gamepad number, button number) boolean = lib.IsGamepadButtonUp
func GetGamepadButtonPressed() number = lib.GetGamepadButtonPressed
func GetGamepadAxisCount(gamepad number) number = lib.GetGamepadAxisCount
func GetGamepadAxisMovement(gamepad number, axis number) number = lib.GetGamepadAxisMovement
func SetGamepadMappings(mappings pointer) number = lib.SetGamepadMappings
func IsMouseButtonPressed(button number) boolean = lib.IsMouseButtonPressed
func IsMouseButtonDown(button number) boolean = lib.IsMouseButtonDown
func IsMouseButtonReleased(button number) boolean = lib.IsMouseButtonReleased
func IsMouseButtonUp(button number) boolean = lib.IsMouseButtonUp
func GetMouseX() number = lib.GetMouseX
func GetMouseY() number = lib.GetMouseY
func GetMousePosition() Vector2 = lib.GetMousePosition
func GetMouseDelta() Vector2 = lib.GetMouseDelta
func SetMousePosition(x number, y number) pointer = lib.SetMousePosition
func SetMouseOffset(offsetX number, offsetY number) pointer = lib.SetMouseOffset
func SetMouseScale(scaleX number, scaleY number) pointer = lib.SetMouseScale
func GetMouseWheelMove() number = lib.GetMouseWheelMove
func GetMouseWheelMoveV() Vector2 = lib.GetMouseWheelMoveV
func SetMouseCursor(cursor number) pointer = lib.SetMouseCursor
func GetTouchX() number = lib.GetTouchX
func GetTouchY() number = lib.GetTouchY
func GetTouchPosition(index number) Vector2 = lib.GetTouchPosition
func GetTouchPointId(index number) number = lib.GetTouchPointId
func GetTouchPointCount() number = lib.GetTouchPointCount
func SetGesturesEnabled(flags number) pointer = lib.SetGesturesEnabled
func IsGestureDetected(gesture number) boolean = lib.IsGestureDetected
func GetGestureDetected() number = lib.GetGestureDetected
func GetGestureHoldDuration() number = lib.GetGestureHoldDuration
func GetGestureDragVector() Vector2 = lib.GetGestureDragVector
func GetGestureDragAngle() number = lib.GetGestureDragAngle
func GetGesturePinchVector() Vector2 = lib.GetGesturePinchVector
func GetGesturePinchAngle() number = lib.GetGesturePinchAngle
func UpdateCamera(camera pointer, mode number) pointer = lib.UpdateCamera
func UpdateCameraPro(camera pointer, movement Vector3, rotation Vector3, zoom number) pointer = lib.UpdateCameraPro
func SetShapesTexture(texture Texture, source Rectangle) pointer = lib.SetShapesTexture
func DrawPixel(posX number, posY number, color Color) pointer = lib.DrawPixel
func DrawPixelV(position Vector2, color Color) pointer = lib.DrawPixelV
func DrawLine(startPosX number, startPosY number, endPosX number, endPosY number, color Color) pointer = lib.DrawLine
func DrawLineV(startPos Vector2, endPos Vector2, color Color) pointer = lib.DrawLineV
func DrawLineEx(startPos Vector2, endPos Vector2, thick number, color Color) pointer = lib.DrawLineEx
func DrawLineBezier(startPos Vector2, endPos Vector2, thick number, color Color) pointer = lib.DrawLineBezier
func DrawLineBezierQuad(startPos Vector2, endPos Vector2, controlPos Vector2, thick number, color Color) pointer = lib.DrawLineBezierQuad
func DrawLineBezierCubic(startPos Vector2, endPos Vector2, startControlPos Vector2, endControlPos Vector2, thick number, color Color) pointer = lib.DrawLineBezierCubic
func DrawLineStrip(points pointer, pointCount number, color Color) pointer = lib.DrawLineStrip
func DrawCircle(centerX number, centerY number, radius number, color Color) pointer = lib.DrawCircle
func DrawCircleSector(center Vector2, radius number, startAngle number, endAngle number, segments number, color Color) pointer = lib.DrawCircleSector
func DrawCircleSectorLines(center Vector2, radius number, startAngle number, endAngle number, segments number, color Color) pointer = lib.DrawCircleSectorLines
func DrawCircleGradient(centerX number, centerY number, radius number, color1 Color, color2 Color) pointer = lib.DrawCircleGradient
func DrawCircleV(center Vector2, radius number, color Color) pointer = lib.DrawCircleV
func DrawCircleLines(centerX number, centerY number, radius number, color Color) pointer = lib.DrawCircleLines
func DrawEllipse(centerX number, centerY number, radiusH number, radiusV number, color Color) pointer = lib.DrawEllipse
func DrawEllipseLines(centerX number, centerY number, radiusH number, radiusV number, color Color) pointer = lib.DrawEllipseLines
func DrawRing(center Vector2, innerRadius number, outerRadius number, startAngle number, endAngle number, segments number, color Color) pointer = lib.DrawRing
func DrawRingLines(center Vector2, innerRadius number, outerRadius number, startAngle number, endAngle number, segments number, color Color) pointer = lib.DrawRingLines
func DrawRectangle(posX number, posY number, width number, height number, color Color) pointer = lib.DrawRectangle
func DrawRectangleV(position Vector2, size Vector2, color Color) pointer = lib.DrawRectangleV
func DrawRectangleRec(rec Rectangle, color Color) pointer = lib.DrawRectangleRec
func DrawRectanglePro(rec Rectangle, origin Vector2, rotation number, color Color) pointer = lib.DrawRectanglePro
func DrawRectangleGradientV(posX number, posY number, width number, height number, color1 Color, color2 Color) pointer = lib.DrawRectangleGradientV
func DrawRectangleGradientH(posX number, posY number, width number, height number, color1 Color, color2 Color) pointer = lib.DrawRectangleGradientH
func DrawRectangleGradientEx(rec Rectangle, col1 Color, col2 Color, col3 Color, col4 Color) pointer = lib.DrawRectangleGradientEx
func DrawRectangleLines(posX number, posY number, width number, height number, color Color) pointer = lib.DrawRectangleLines
func DrawRectangleLinesEx(rec Rectangle, lineThick number, color Color) pointer = lib.DrawRectangleLinesEx
func DrawRectangleRounded(rec Rectangle, roundness number, segments number, color Color) pointer = lib.DrawRectangleRounded
func DrawRectangleRoundedLines(rec Rectangle, roundness number, segments number, lineThick number, color Color) pointer = lib.DrawRectangleRoundedLines
func DrawTriangle(v1 Vector2, v2 Vector2, v3 Vector2, color Color) pointer = lib.DrawTriangle
func DrawTriangleLines(v1 Vector2, v2 Vector2, v3 Vector2, color Color) pointer = lib.DrawTriangleLines
func DrawTriangleFan(points pointer, pointCount number, color Color) pointer = lib.DrawTriangleFan
func DrawTriangleStrip(points pointer, pointCount number, color Color) pointer = lib.DrawTriangleStrip
func DrawPoly(center Vector2, sides number, radius number, rotation number, color Color) pointer = lib.DrawPoly
func DrawPolyLines(center Vector2, sides number, radius number, rotation number, color Color) pointer = lib.DrawPolyLines
func DrawPolyLinesEx(center Vector2, sides number, radius number, rotation number, lineThick number, color Color) pointer = lib.DrawPolyLinesEx
func CheckCollisionRecs(rec1 Rectangle, rec2 Rectangle) boolean = lib.CheckCollisionRecs
func CheckCollisionCircles(center1 Vector2, radius1 number, center2 Vector2, radius2 number) boolean = lib.CheckCollisionCircles
func CheckCollisionCircleRec(center Vector2, radius number, rec Rectangle) boolean = lib.CheckCollisionCircleRec
func CheckCollisionPointRec(point Vector2, rec Rectangle) boolean = lib.CheckCollisionPointRec
func CheckCollisionPointCircle(point Vector2, center Vector2, radius number) boolean = lib.CheckCollisionPointCircle
func CheckCollisionPointTriangle(point Vector2, p1 Vector2, p2 Vector2, p3 Vector2) boolean = lib.CheckCollisionPointTriangle
func CheckCollisionPointPoly(point Vector2, points pointer, pointCount number) boolean = lib.CheckCollisionPointPoly
func CheckCollisionLines(startPos1 Vector2, endPos1 Vector2, startPos2 Vector2, endPos2 Vector2, collisionPoint pointer) boolean = lib.CheckCollisionLines
func CheckCollisionPointLine(point Vector2, p1 Vector2, p2 Vector2, threshold number) boolean = lib.CheckCollisionPointLine
func GetCollisionRec(rec1 Rectangle, rec2 Rectangle) Rectangle = lib.GetCollisionRec
func LoadImage(fileName pointer) Image = lib.LoadImage
func LoadImageRaw(fileName pointer, width number, height number, format number, headerSize number) Image = lib.LoadImageRaw
func LoadImageAnim(fileName pointer, frames pointer) Image = lib.LoadImageAnim
func LoadImageFromMemory(fileType pointer, fileData pointer, dataSize number) Image = lib.LoadImageFromMemory
func LoadImageFromTexture(texture Texture) Image = lib.LoadImageFromTexture
func LoadImageFromScreen() Image = lib.LoadImageFromScreen
func IsImageReady(image Image) boolean = lib.IsImageReady
func UnloadImage(image Image) pointer = lib.UnloadImage
func ExportImage(image Image, fileName pointer) boolean = lib.ExportImage
func ExportImageAsCode(image Image, fileName pointer) boolean = lib.ExportImageAsCode
func GenImageColor(width number, height number, color Color) Image = lib.GenImageColor
func GenImageGradientV(width number, height number, top Color, bottom Color) Image = lib.GenImageGradientV
func GenImageGradientH(width number, height number, left Color, right Color) Image = lib.GenImageGradientH
func GenImageGradientRadial(width number, height number, density number, inner Color, outer Color) Image = lib.GenImageGradientRadial
func GenImageChecked(width number, height number, checksX number, checksY number, col1 Color, col2 Color) Image = lib.GenImageChecked
func GenImageWhiteNoise(width number, height number, factor number) Image = lib.GenImageWhiteNoise
func GenImagePerlinNoise(width number, height number, offsetX number, offsetY number, scale number) Image = lib.GenImagePerlinNoise
func GenImageCellular(width number, height number, tileSize number) Image = lib.GenImageCellular
func GenImageText(width number, height number, text pointer) Image = lib.GenImageText
func ImageCopy(image Image) Image = lib.ImageCopy
func ImageFromImage(image Image, rec Rectangle) Image = lib.ImageFromImage
func ImageText(text pointer, fontSize number, color Color) Image = lib.ImageText
func ImageTextEx(font Font, text pointer, fontSize number, spacing number, tint Color) Image = lib.ImageTextEx
func ImageFormat(image pointer, newFormat number) pointer = lib.ImageFormat
func ImageToPOT(image pointer, fill Color) pointer = lib.ImageToPOT
func ImageCrop(image pointer, crop Rectangle) pointer = lib.ImageCrop
func ImageAlphaCrop(image pointer, threshold number) pointer = lib.ImageAlphaCrop
func ImageAlphaClear(image pointer, color Color, threshold number) pointer = lib.ImageAlphaClear
func ImageAlphaMask(image pointer, alphaMask Image) pointer = lib.ImageAlphaMask
func ImageAlphaPremultiply(image pointer) pointer = lib.ImageAlphaPremultiply
func ImageBlurGaussian(image pointer, blurSize number) pointer = lib.ImageBlurGaussian
func ImageResize(image pointer, newWidth number, newHeight number) pointer = lib.ImageResize
func ImageResizeNN(image pointer, newWidth number, newHeight number) pointer = lib.ImageResizeNN
func ImageResizeCanvas(image pointer, newWidth number, newHeight number, offsetX number, offsetY number, fill Color) pointer = lib.ImageResizeCanvas
func ImageMipmaps(image pointer) pointer = lib.ImageMipmaps
func ImageDither(image pointer, rBpp number, gBpp number, bBpp number, aBpp number) pointer = lib.ImageDither
func ImageFlipVertical(image pointer) pointer = lib.ImageFlipVertical
func ImageFlipHorizontal(image pointer) pointer = lib.ImageFlipHorizontal
func ImageRotateCW(image pointer) pointer = lib.ImageRotateCW
func ImageRotateCCW(image pointer) pointer = lib.ImageRotateCCW
func ImageColorTint(image pointer, color Color) pointer = lib.ImageColorTint
func ImageColorInvert(image pointer) pointer = lib.ImageColorInvert
func ImageColorGrayscale(image pointer) pointer = lib.ImageColorGrayscale
func ImageColorContrast(image pointer, contrast number) pointer = lib.ImageColorContrast
func ImageColorBrightness(image pointer, brightness number) pointer = lib.ImageColorBrightness
func ImageColorReplace(image pointer, color Color, replace Color) pointer = lib.ImageColorReplace
func LoadImageColors(image Image) pointer = lib.LoadImageColors
func LoadImagePalette(image Image, maxPaletteSize number, colorCount pointer) pointer = lib.LoadImagePalette
func UnloadImageColors(colors pointer) pointer = lib.UnloadImageColors
func UnloadImagePalette(colors pointer) pointer = lib.UnloadImagePalette
func GetImageAlphaBorder(image Image, threshold number) Rectangle = lib.GetImageAlphaBorder
func GetImageColor(image Image, x number, y number) Color = lib.GetImageColor
func ImageClearBackground(dst pointer, color Color) pointer = lib.ImageClearBackground
func ImageDrawPixel(dst pointer, posX number, posY number, color Color) pointer = lib.ImageDrawPixel
func ImageDrawPixelV(dst pointer, position Vector2, color Color) pointer = lib.ImageDrawPixelV
func ImageDrawLine(dst pointer, startPosX number, startPosY number, endPosX number, endPosY number, color Color) pointer = lib.ImageDrawLine
func ImageDrawLineV(dst pointer, start Vector2, end Vector2, color Color) pointer = lib.ImageDrawLineV
func ImageDrawCircle(dst pointer, centerX number, centerY number, radius number, color Color) pointer = lib.ImageDrawCircle
func ImageDrawCircleV(dst pointer, center Vector2, radius number, color Color) pointer = lib.ImageDrawCircleV
func ImageDrawCircleLines(dst pointer, centerX number, centerY number, radius number, color Color) pointer = lib.ImageDrawCircleLines
func ImageDrawCircleLinesV(dst pointer, center Vector2, radius number, color Color) pointer = lib.ImageDrawCircleLinesV
func ImageDrawRectangle(dst pointer, posX number, posY number, width number, height number, color Color) pointer = lib.ImageDrawRectangle
func ImageDrawRectangleV(dst pointer, position Vector2, size Vector2, color Color) pointer = lib.ImageDrawRectangleV
func ImageDrawRectangleRec(dst pointer, rec Rectangle, color Color) pointer = lib.ImageDrawRectangleRec
func ImageDrawRectangleLines(dst pointer, rec Rectangle, thick number, color Color) pointer = lib.ImageDrawRectangleLines
func ImageDraw(dst pointer, src Image, srcRec Rectangle, dstRec Rectangle, tint Color) pointer = lib.ImageDraw
func ImageDrawText(dst pointer, text pointer, posX number, posY number, fontSize number, color Color) pointer = lib.ImageDrawText
func ImageDrawTextEx(dst pointer, font Font, text pointer, position Vector2, fontSize number, spacing number, tint Color) pointer = lib.ImageDrawTextEx
func LoadTexture(fileName pointer) Texture = lib.LoadTexture
func LoadTextureFromImage(image Image) Texture = lib.LoadTextureFromImage
func LoadTextureCubemap(image Image, layout number) Texture = lib.LoadTextureCubemap
func LoadRenderTexture(width number, height number) RenderTexture = lib.LoadRenderTexture
func IsTextureReady(texture Texture) boolean = lib.IsTextureReady
func UnloadTexture(texture Texture) pointer = lib.UnloadTexture
func IsRenderTextureReady(target RenderTexture) boolean = lib.IsRenderTextureReady
func UnloadRenderTexture(target RenderTexture) pointer = lib.UnloadRenderTexture
func UpdateTexture(texture Texture, pixels pointer) pointer = lib.UpdateTexture
func UpdateTextureRec(texture Texture, rec Rectangle, pixels pointer) pointer = lib.UpdateTextureRec
func GenTextureMipmaps(texture pointer) pointer = lib.GenTextureMipmaps
func SetTextureFilter(texture Texture, filter number) pointer = lib.SetTextureFilter
func SetTextureWrap(texture Texture, wrap number) pointer = lib.SetTextureWrap
func DrawTexture(texture Texture, posX number, posY number, tint Color) pointer = lib.DrawTexture
func DrawTextureV(texture Texture, position Vector2, tint Color) pointer = lib.DrawTextureV
func DrawTextureEx(texture Texture, position Vector2, rotation number, scale number, tint Color) pointer = lib.DrawTextureEx
func DrawTextureRec(texture Texture, source Rectangle, position Vector2, tint Color) pointer = lib.DrawTextureRec
func DrawTexturePro(texture Texture, source Rectangle, dest Rectangle, origin Vector2, rotation number, tint Color) pointer = lib.DrawTexturePro
func DrawTextureNPatch(texture Texture, nPatchInfo NPatchInfo, dest Rectangle, origin Vector2, rotation number, tint Color) pointer = lib.DrawTextureNPatch
func Fade(color Color, alpha number) Color = lib.Fade
func ColorToInt(color Color) number = lib.ColorToInt
func ColorNormalize(color Color) Vector4 = lib.ColorNormalize
func ColorFromNormalized(normalized Vector4) Color = lib.ColorFromNormalized
func ColorToHSV(color Color) Vector3 = lib.ColorToHSV
func ColorFromHSV(hue number, saturation number, value number) Color = lib.ColorFromHSV
func ColorTint(color Color, tint Color) Color = lib.ColorTint
func ColorBrightness(color Color, factor number) Color = lib.ColorBrightness
func ColorContrast(color Color, contrast number) Color = lib.ColorContrast
func ColorAlpha(color Color, alpha number) Color = lib.ColorAlpha
func ColorAlphaBlend(dst Color, src Color, tint Color) Color = lib.ColorAlphaBlend
func GetColor(hexValue number) Color = lib.GetColor
func GetPixelColor(srcPtr pointer, format number) Color = lib.GetPixelColor
func SetPixelColor(dstPtr pointer, color Color, format number) pointer = lib.SetPixelColor
func GetPixelDataSize(width number, height number, format number) number = lib.GetPixelDataSize
func GetFontDefault() Font = lib.GetFontDefault
func LoadFont(fileName pointer) Font = lib.LoadFont
func LoadFontEx(fileName pointer, fontSize number, fontChars pointer, glyphCount number) Font = lib.LoadFontEx
func LoadFontFromImage(image Image, key Color, firstChar number) Font = lib.LoadFontFromImage
func LoadFontFromMemory(fileType pointer, fileData pointer, dataSize number, fontSize number, fontChars pointer, glyphCount number) Font = lib.LoadFontFromMemory
func IsFontReady(font Font) boolean = lib.IsFontReady
func LoadFontData(fileData pointer, dataSize number, fontSize number, fontChars pointer, glyphCount number, type number) pointer = lib.LoadFontData
func GenImageFontAtlas(chars pointer, recs pointer, glyphCount number, fontSize number, padding number, packMethod number) Image = lib.GenImageFontAtlas
func UnloadFontData(chars pointer, glyphCount number) pointer = lib.UnloadFontData
func UnloadFont(font Font) pointer = lib.UnloadFont
func ExportFontAsCode(font Font, fileName pointer) boolean = lib.ExportFontAsCode
func DrawFPS(posX number, posY number) pointer = lib.DrawFPS
func DrawText(text pointer, posX number, posY number, fontSize number, color Color) pointer = lib.DrawText
func DrawTextEx(font Font, text pointer, position Vector2, fontSize number, spacing number, tint Color) pointer = lib.DrawTextEx
func DrawTextPro(font Font, text pointer, position Vector2, origin Vector2, rotation number, fontSize number, spacing number, tint Color) pointer = lib.DrawTextPro
func DrawTextCodepoint(font Font, codepoint number, position Vector2, fontSize number, tint Color) pointer = lib.DrawTextCodepoint
func DrawTextCodepoints(font Font, codepoints pointer, count number, position Vector2, fontSize number, spacing number, tint Color) pointer = lib.DrawTextCodepoints
func MeasureText(text pointer, fontSize number) number = lib.MeasureText
func MeasureTextEx(font Font, text pointer, fontSize number, spacing number) Vector2 = lib.MeasureTextEx
func GetGlyphIndex(font Font, codepoint number) number = lib.GetGlyphIndex
func GetGlyphInfo(font Font, codepoint number) GlyphInfo = lib.GetGlyphInfo
func GetGlyphAtlasRec(font Font, codepoint number) Rectangle = lib.GetGlyphAtlasRec
func LoadUTF8(codepoints pointer, length number) pointer = lib.LoadUTF8
func UnloadUTF8(text pointer) pointer = lib.UnloadUTF8
func LoadCodepoints(text pointer, count pointer) pointer = lib.LoadCodepoints
func UnloadCodepoints(codepoints pointer) pointer = lib.UnloadCodepoints
func GetCodepointCount(text pointer) number = lib.GetCodepointCount
func GetCodepoint(text pointer, codepointSize pointer) number = lib.GetCodepoint
func GetCodepointNext(text pointer, codepointSize pointer) number = lib.GetCodepointNext
func GetCodepointPrevious(text pointer, codepointSize pointer) number = lib.GetCodepointPrevious
func CodepointToUTF8(codepoint number, utf8Size pointer) pointer = lib.CodepointToUTF8
func TextCopy(dst pointer, src pointer) number = lib.TextCopy
func TextIsEqual(text1 pointer, text2 pointer) boolean = lib.TextIsEqual
func TextLength(text pointer) number = lib.TextLength
func TextSubtext(text pointer, position number, length number) pointer = lib.TextSubtext
func TextReplace(text pointer, replace pointer, by pointer) pointer = lib.TextReplace
func TextInsert(text pointer, insert pointer, position number) pointer = lib.TextInsert
func TextJoin(textList pointer, count number, delimiter pointer) pointer = lib.TextJoin
func TextSplit(text pointer, delimiter number, count pointer) pointer = lib.TextSplit
func TextAppend(text pointer, append pointer, position pointer) pointer = lib.TextAppend
func TextFindIndex(text pointer, find pointer) number = lib.TextFindIndex
func TextToUpper(text pointer) pointer = lib.TextToUpper
func TextToLower(text pointer) pointer = lib.TextToLower
func TextToPascal(text pointer) pointer = lib.TextToPascal
func TextToInteger(text pointer) number = lib.TextToInteger
func DrawLine3D(startPos Vector3, endPos Vector3, color Color) pointer = lib.DrawLine3D
func DrawPoint3D(position Vector3, color Color) pointer = lib.DrawPoint3D
func DrawCircle3D(center Vector3, radius number, rotationAxis Vector3, rotationAngle number, color Color) pointer = lib.DrawCircle3D
func DrawTriangle3D(v1 Vector3, v2 Vector3, v3 Vector3, color Color) pointer = lib.DrawTriangle3D
func DrawTriangleStrip3D(points pointer, pointCount number, color Color) pointer = lib.DrawTriangleStrip3D
func DrawCube(position Vector3, width number, height number, length number, color Color) pointer = lib.DrawCube
func DrawCubeV(position Vector3, size Vector3, color Color) pointer = lib.DrawCubeV
func DrawCubeWires(position Vector3, width number, height number, length number, color Color) pointer = lib.DrawCubeWires
func DrawCubeWiresV(position Vector3, size Vector3, color Color) pointer = lib.DrawCubeWiresV
func DrawSphere(centerPos Vector3, radius number, color Color) pointer = lib.DrawSphere
func DrawSphereEx(centerPos Vector3, radius number, rings number, slices number, color Color) pointer = lib.DrawSphereEx
func DrawSphereWires(centerPos Vector3, radius number, rings number, slices number, color Color) pointer = lib.DrawSphereWires
func DrawCylinder(position Vector3, radiusTop number, radiusBottom number, height number, slices number, color Color) pointer = lib.DrawCylinder
func DrawCylinderEx(startPos Vector3, endPos Vector3, startRadius number, endRadius number, sides number, color Color) pointer = lib.DrawCylinderEx
func DrawCylinderWires(position Vector3, radiusTop number, radiusBottom number, height number, slices number, color Color) pointer = lib.DrawCylinderWires
func DrawCylinderWiresEx(startPos Vector3, endPos Vector3, startRadius number, endRadius number, sides number, color Color) pointer = lib.DrawCylinderWiresEx
func DrawCapsule(startPos Vector3, endPos Vector3, radius number, slices number, rings number, color Color) pointer = lib.DrawCapsule
func DrawCapsuleWires(startPos Vector3, endPos Vector3, radius number, slices number, rings number, color Color) pointer = lib.DrawCapsuleWires
func DrawPlane(centerPos Vector3, size Vector2, color Color) pointer = lib.DrawPlane
func DrawRay(ray Ray, color Color) pointer = lib.DrawRay
func DrawGrid(slices number, spacing number) pointer = lib.DrawGrid
func LoadModel(fileName pointer) Model = lib.LoadModel
func LoadModelFromMesh(mesh Mesh) Model = lib.LoadModelFromMesh
func IsModelReady(model Model) boolean = lib.IsModelReady
func UnloadModel(model Model) pointer = lib.UnloadModel
func GetModelBoundingBox(model Model) BoundingBox = lib.GetModelBoundingBox
func DrawModel(model Model, position Vector3, scale number, tint Color) pointer = lib.DrawModel
func DrawModelEx(model Model, position Vector3, rotationAxis Vector3, rotationAngle number, scale Vector3, tint Color) pointer = lib.DrawModelEx
func DrawModelWires(model Model, position Vector3, scale number, tint Color) pointer = lib.DrawModelWires
func DrawModelWiresEx(model Model, position Vector3, rotationAxis Vector3, rotationAngle number, scale Vector3, tint Color) pointer = lib.DrawModelWiresEx
func DrawBoundingBox(box BoundingBox, color Color) pointer = lib.DrawBoundingBox
func DrawBillboard(camera Camera3D, texture Texture, position Vector3, size number, tint Color) pointer = lib.DrawBillboard
func DrawBillboardRec(camera Camera3D, texture Texture, source Rectangle, position Vector3, size Vector2, tint Color) pointer = lib.DrawBillboardRec
func DrawBillboardPro(camera Camera3D, texture Texture, source Rectangle, position Vector3, up Vector3, size Vector2, origin Vector2, rotation number, tint Color) pointer = lib.DrawBillboardPro
func UploadMesh(mesh pointer, dynamic boolean) pointer = lib.UploadMesh
func UpdateMeshBuffer(mesh Mesh, index number, data pointer, dataSize number, offset number) pointer = lib.UpdateMeshBuffer
func UnloadMesh(mesh Mesh) pointer = lib.UnloadMesh
func DrawMesh(mesh Mesh, material Material, transform Matrix) pointer = lib.DrawMesh
func DrawMeshInstanced(mesh Mesh, material Material, transforms pointer, instances number) pointer = lib.DrawMeshInstanced
func ExportMesh(mesh Mesh, fileName pointer) boolean = lib.ExportMesh
func GetMeshBoundingBox(mesh Mesh) BoundingBox = lib.GetMeshBoundingBox
func GenMeshTangents(mesh pointer) pointer = lib.GenMeshTangents
func GenMeshPoly(sides number, radius number) Mesh = lib.GenMeshPoly
func GenMeshPlane(width number, length number, resX number, resZ number) Mesh = lib.GenMeshPlane
func GenMeshCube(width number, height number, length number) Mesh = lib.GenMeshCube
func GenMeshSphere(radius number, rings number, slices number) Mesh = lib.GenMeshSphere
func GenMeshHemiSphere(radius number, rings number, slices number) Mesh = lib.GenMeshHemiSphere
func GenMeshCylinder(radius number, height number, slices number) Mesh = lib.GenMeshCylinder
func GenMeshCone(radius number, height number, slices number) Mesh = lib.GenMeshCone
func GenMeshTorus(radius number, size number, radSeg number, sides number) Mesh = lib.GenMeshTorus
func GenMeshKnot(radius number, size number, radSeg number, sides number) Mesh = lib.GenMeshKnot
func GenMeshHeightmap(heightmap Image, size Vector3) Mesh = lib.GenMeshHeightmap
func GenMeshCubicmap(cubicmap Image, cubeSize Vector3) Mesh = lib.GenMeshCubicmap
func LoadMaterials(fileName pointer, materialCount pointer) pointer = lib.LoadMaterials
func LoadMaterialDefault() Material = lib.LoadMaterialDefault
func IsMaterialReady(material Material) boolean = lib.IsMaterialReady
func UnloadMaterial(material Material) pointer = lib.UnloadMaterial
func SetMaterialTexture(material pointer, mapType number, texture Texture) pointer = lib.SetMaterialTexture
func SetModelMeshMaterial(model pointer, meshId number, materialId number) pointer = lib.SetModelMeshMaterial
func LoadModelAnimations(fileName pointer, animCount pointer) pointer = lib.LoadModelAnimations
func UpdateModelAnimation(model Model, anim ModelAnimation, frame number) pointer = lib.UpdateModelAnimation
func UnloadModelAnimation(anim ModelAnimation) pointer = lib.UnloadModelAnimation
func UnloadModelAnimations(animations pointer, count number) pointer = lib.UnloadModelAnimations
func IsModelAnimationValid(model Model, anim ModelAnimation) boolean = lib.IsModelAnimationValid
func CheckCollisionSpheres(center1 Vector3, radius1 number, center2 Vector3, radius2 number) boolean = lib.CheckCollisionSpheres
func CheckCollisionBoxes(box1 BoundingBox, box2 BoundingBox) boolean = lib.CheckCollisionBoxes
func CheckCollisionBoxSphere(box BoundingBox, center Vector3, radius number) boolean = lib.CheckCollisionBoxSphere
func GetRayCollisionSphere(ray Ray, center Vector3, radius number) RayCollision = lib.GetRayCollisionSphere
func GetRayCollisionBox(ray Ray, box BoundingBox) RayCollision = lib.GetRayCollisionBox
func GetRayCollisionMesh(ray Ray, mesh Mesh, transform Matrix) RayCollision = lib.GetRayCollisionMesh
func GetRayCollisionTriangle(ray Ray, p1 Vector3, p2 Vector3, p3 Vector3) RayCollision = lib.GetRayCollisionTriangle
func GetRayCollisionQuad(ray Ray, p1 Vector3, p2 Vector3, p3 Vector3, p4 Vector3) RayCollision = lib.GetRayCollisionQuad
type AudioCallback pointer
func InitAudioDevice() pointer = lib.InitAudioDevice
func CloseAudioDevice() pointer = lib.CloseAudioDevice
func IsAudioDeviceReady() boolean = lib.IsAudioDeviceReady
func SetMasterVolume(volume number) pointer = lib.SetMasterVolume
func LoadWave(fileName pointer) Wave = lib.LoadWave
func LoadWaveFromMemory(fileType pointer, fileData pointer, dataSize number) Wave = lib.LoadWaveFromMemory
func IsWaveReady(wave Wave) boolean = lib.IsWaveReady
func LoadSound(fileName pointer) Sound = lib.LoadSound
func LoadSoundFromWave(wave Wave) Sound = lib.LoadSoundFromWave
func IsSoundReady(sound Sound) boolean = lib.IsSoundReady
func UpdateSound(sound Sound, data pointer, sampleCount number) pointer = lib.UpdateSound
func UnloadWave(wave Wave) pointer = lib.UnloadWave
func UnloadSound(sound Sound) pointer = lib.UnloadSound
func ExportWave(wave Wave, fileName pointer) boolean = lib.ExportWave
func ExportWaveAsCode(wave Wave, fileName pointer) boolean = lib.ExportWaveAsCode
func PlaySound(sound Sound) pointer = lib.PlaySound
func StopSound(sound Sound) pointer = lib.StopSound
func PauseSound(sound Sound) pointer = lib.PauseSound
func ResumeSound(sound Sound) pointer = lib.ResumeSound
func IsSoundPlaying(sound Sound) boolean = lib.IsSoundPlaying
func SetSoundVolume(sound Sound, volume number) pointer = lib.SetSoundVolume
func SetSoundPitch(sound Sound, pitch number) pointer = lib.SetSoundPitch
func SetSoundPan(sound Sound, pan number) pointer = lib.SetSoundPan
func WaveCopy(wave Wave) Wave = lib.WaveCopy
func WaveCrop(wave pointer, initSample number, finalSample number) pointer = lib.WaveCrop
func WaveFormat(wave pointer, sampleRate number, sampleSize number, channels number) pointer = lib.WaveFormat
func LoadWaveSamples(wave Wave) pointer = lib.LoadWaveSamples
func UnloadWaveSamples(samples pointer) pointer = lib.UnloadWaveSamples
func LoadMusicStream(fileName pointer) Music = lib.LoadMusicStream
func LoadMusicStreamFromMemory(fileType pointer, data pointer, dataSize number) Music = lib.LoadMusicStreamFromMemory
func IsMusicReady(music Music) boolean = lib.IsMusicReady
func UnloadMusicStream(music Music) pointer = lib.UnloadMusicStream
func PlayMusicStream(music Music) pointer = lib.PlayMusicStream
func IsMusicStreamPlaying(music Music) boolean = lib.IsMusicStreamPlaying
func UpdateMusicStream(music Music) pointer = lib.UpdateMusicStream
func StopMusicStream(music Music) pointer = lib.StopMusicStream
func PauseMusicStream(music Music) pointer = lib.PauseMusicStream
func ResumeMusicStream(music Music) pointer = lib.ResumeMusicStream
func SeekMusicStream(music Music, position number) pointer = lib.SeekMusicStream
func SetMusicVolume(music Music, volume number) pointer = lib.SetMusicVolume
func SetMusicPitch(music Music, pitch number) pointer = lib.SetMusicPitch
func SetMusicPan(music Music, pan number) pointer = lib.SetMusicPan
func GetMusicTimeLength(music Music) number = lib.GetMusicTimeLength
func GetMusicTimePlayed(music Music) number = lib.GetMusicTimePlayed
func LoadAudioStream(sampleRate number, sampleSize number, channels number) AudioStream = lib.LoadAudioStream
func IsAudioStreamReady(stream AudioStream) boolean = lib.IsAudioStreamReady
func UnloadAudioStream(stream AudioStream) pointer = lib.UnloadAudioStream
func UpdateAudioStream(stream AudioStream, data pointer, frameCount number) pointer = lib.UpdateAudioStream
func IsAudioStreamProcessed(stream AudioStream) boolean = lib.IsAudioStreamProcessed
func PlayAudioStream(stream AudioStream) pointer = lib.PlayAudioStream
func PauseAudioStream(stream AudioStream) pointer = lib.PauseAudioStream
func ResumeAudioStream(stream AudioStream) pointer = lib.ResumeAudioStream
func IsAudioStreamPlaying(stream AudioStream) boolean = lib.IsAudioStreamPlaying
func StopAudioStream(stream AudioStream) pointer = lib.StopAudioStream
func SetAudioStreamVolume(stream AudioStream, volume number) pointer = lib.SetAudioStreamVolume
func SetAudioStreamPitch(stream AudioStream, pitch number) pointer = lib.SetAudioStreamPitch
func SetAudioStreamPan(stream AudioStream, pan number) pointer = lib.SetAudioStreamPan
func SetAudioStreamBufferSizeDefault(size number) pointer = lib.SetAudioStreamBufferSizeDefault
func SetAudioStreamCallback(stream AudioStream, callback pointer) pointer = lib.SetAudioStreamCallback
func AttachAudioStreamProcessor(stream AudioStream, processor pointer) pointer = lib.AttachAudioStreamProcessor
func DetachAudioStreamProcessor(stream AudioStream, processor pointer) pointer = lib.DetachAudioStreamProcessor
func AttachAudioMixedProcessor(processor pointer) pointer = lib.AttachAudioMixedProcessor
func DetachAudioMixedProcessor(processor pointer) pointer = lib.DetachAudioMixedProcessor
var RAYLIB_VERSION: "4.6-dev"
var MOUSE_LEFT_BUTTON: MOUSE_BUTTON_LEFT
var MOUSE_RIGHT_BUTTON: MOUSE_BUTTON_RIGHT
var MOUSE_MIDDLE_BUTTON: MOUSE_BUTTON_MIDDLE
var MATERIAL_MAP_DIFFUSE: MATERIAL_MAP_ALBEDO
var MATERIAL_MAP_SPECULAR: MATERIAL_MAP_METALNESS
var SHADER_LOC_MAP_DIFFUSE: SHADER_LOC_MAP_ALBEDO
var SHADER_LOC_MAP_SPECULAR: SHADER_LOC_MAP_METALNESS

import os 'os'
var lib: os.bindLib('libraylib.dylib', [
  os.CFunc{ sym: 'InitWindow', args: [#int, #int, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'WindowShouldClose', args: [], ret: #bool }
  os.CFunc{ sym: 'CloseWindow', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'IsWindowReady', args: [], ret: #bool }
  os.CFunc{ sym: 'IsWindowFullscreen', args: [], ret: #bool }
  os.CFunc{ sym: 'IsWindowHidden', args: [], ret: #bool }
  os.CFunc{ sym: 'IsWindowMinimized', args: [], ret: #bool }
  os.CFunc{ sym: 'IsWindowMaximized', args: [], ret: #bool }
  os.CFunc{ sym: 'IsWindowFocused', args: [], ret: #bool }
  os.CFunc{ sym: 'IsWindowResized', args: [], ret: #bool }
  os.CFunc{ sym: 'IsWindowState', args: [#uint], ret: #bool }
  os.CFunc{ sym: 'SetWindowState', args: [#uint], ret: #voidPtr }
  os.CFunc{ sym: 'ClearWindowState', args: [#uint], ret: #voidPtr }
  os.CFunc{ sym: 'ToggleFullscreen', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'MaximizeWindow', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'MinimizeWindow', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'RestoreWindow', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'SetWindowIcon', args: [Image], ret: #voidPtr }
  os.CFunc{ sym: 'SetWindowIcons', args: [#voidPtr, #int], ret: #voidPtr }
  os.CFunc{ sym: 'SetWindowTitle', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'SetWindowPosition', args: [#int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'SetWindowMonitor', args: [#int], ret: #voidPtr }
  os.CFunc{ sym: 'SetWindowMinSize', args: [#int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'SetWindowSize', args: [#int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'SetWindowOpacity', args: [#float], ret: #voidPtr }
  os.CFunc{ sym: 'GetWindowHandle', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'GetScreenWidth', args: [], ret: #int }
  os.CFunc{ sym: 'GetScreenHeight', args: [], ret: #int }
  os.CFunc{ sym: 'GetRenderWidth', args: [], ret: #int }
  os.CFunc{ sym: 'GetRenderHeight', args: [], ret: #int }
  os.CFunc{ sym: 'GetMonitorCount', args: [], ret: #int }
  os.CFunc{ sym: 'GetCurrentMonitor', args: [], ret: #int }
  os.CFunc{ sym: 'GetMonitorPosition', args: [#int], ret: Vector2 }
  os.CFunc{ sym: 'GetMonitorWidth', args: [#int], ret: #int }
  os.CFunc{ sym: 'GetMonitorHeight', args: [#int], ret: #int }
  os.CFunc{ sym: 'GetMonitorPhysicalWidth', args: [#int], ret: #int }
  os.CFunc{ sym: 'GetMonitorPhysicalHeight', args: [#int], ret: #int }
  os.CFunc{ sym: 'GetMonitorRefreshRate', args: [#int], ret: #int }
  os.CFunc{ sym: 'GetWindowPosition', args: [], ret: Vector2 }
  os.CFunc{ sym: 'GetWindowScaleDPI', args: [], ret: Vector2 }
  os.CFunc{ sym: 'GetMonitorName', args: [#int], ret: #voidPtr }
  os.CFunc{ sym: 'SetClipboardText', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'GetClipboardText', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'EnableEventWaiting', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'DisableEventWaiting', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'SwapScreenBuffer', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'PollInputEvents', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'WaitTime', args: [#double], ret: #voidPtr }
  os.CFunc{ sym: 'ShowCursor', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'HideCursor', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'IsCursorHidden', args: [], ret: #bool }
  os.CFunc{ sym: 'EnableCursor', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'DisableCursor', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'IsCursorOnScreen', args: [], ret: #bool }
  os.CFunc{ sym: 'ClearBackground', args: [Color], ret: #voidPtr }
  os.CFunc{ sym: 'BeginDrawing', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'EndDrawing', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'BeginMode2D', args: [Camera2D], ret: #voidPtr }
  os.CFunc{ sym: 'EndMode2D', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'BeginMode3D', args: [Camera3D], ret: #voidPtr }
  os.CFunc{ sym: 'EndMode3D', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'BeginTextureMode', args: [RenderTexture], ret: #voidPtr }
  os.CFunc{ sym: 'EndTextureMode', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'BeginShaderMode', args: [Shader], ret: #voidPtr }
  os.CFunc{ sym: 'EndShaderMode', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'BeginBlendMode', args: [#int], ret: #voidPtr }
  os.CFunc{ sym: 'EndBlendMode', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'BeginScissorMode', args: [#int, #int, #int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'EndScissorMode', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'BeginVrStereoMode', args: [VrStereoConfig], ret: #voidPtr }
  os.CFunc{ sym: 'EndVrStereoMode', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'LoadVrStereoConfig', args: [VrDeviceInfo], ret: VrStereoConfig }
  os.CFunc{ sym: 'UnloadVrStereoConfig', args: [VrStereoConfig], ret: #voidPtr }
  os.CFunc{ sym: 'LoadShader', args: [#voidPtr, #voidPtr], ret: Shader }
  os.CFunc{ sym: 'LoadShaderFromMemory', args: [#voidPtr, #voidPtr], ret: Shader }
  os.CFunc{ sym: 'IsShaderReady', args: [Shader], ret: #bool }
  os.CFunc{ sym: 'GetShaderLocation', args: [Shader, #voidPtr], ret: #int }
  os.CFunc{ sym: 'GetShaderLocationAttrib', args: [Shader, #voidPtr], ret: #int }
  os.CFunc{ sym: 'SetShaderValue', args: [Shader, #int, #voidPtr, #int], ret: #voidPtr }
  os.CFunc{ sym: 'SetShaderValueV', args: [Shader, #int, #voidPtr, #int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'SetShaderValueMatrix', args: [Shader, #int, Matrix], ret: #voidPtr }
  os.CFunc{ sym: 'SetShaderValueTexture', args: [Shader, #int, Texture], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadShader', args: [Shader], ret: #voidPtr }
  os.CFunc{ sym: 'GetMouseRay', args: [Vector2, Camera3D], ret: Ray }
  os.CFunc{ sym: 'GetCameraMatrix', args: [Camera3D], ret: Matrix }
  os.CFunc{ sym: 'GetCameraMatrix2D', args: [Camera2D], ret: Matrix }
  os.CFunc{ sym: 'GetWorldToScreen', args: [Vector3, Camera3D], ret: Vector2 }
  os.CFunc{ sym: 'GetScreenToWorld2D', args: [Vector2, Camera2D], ret: Vector2 }
  os.CFunc{ sym: 'GetWorldToScreenEx', args: [Vector3, Camera3D, #int, #int], ret: Vector2 }
  os.CFunc{ sym: 'GetWorldToScreen2D', args: [Vector2, Camera2D], ret: Vector2 }
  os.CFunc{ sym: 'SetTargetFPS', args: [#int], ret: #voidPtr }
  os.CFunc{ sym: 'GetFPS', args: [], ret: #int }
  os.CFunc{ sym: 'GetFrameTime', args: [], ret: #float }
  os.CFunc{ sym: 'GetTime', args: [], ret: #double }
  os.CFunc{ sym: 'GetRandomValue', args: [#int, #int], ret: #int }
  os.CFunc{ sym: 'SetRandomSeed', args: [#uint], ret: #voidPtr }
  os.CFunc{ sym: 'TakeScreenshot', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'SetConfigFlags', args: [#uint], ret: #voidPtr }
  os.CFunc{ sym: 'SetTraceLogLevel', args: [#int], ret: #voidPtr }
  os.CFunc{ sym: 'MemAlloc', args: [#uint], ret: #voidPtr }
  os.CFunc{ sym: 'MemRealloc', args: [#voidPtr, #uint], ret: #voidPtr }
  os.CFunc{ sym: 'MemFree', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'OpenURL', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'SetTraceLogCallback', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'SetLoadFileDataCallback', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'SetSaveFileDataCallback', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'SetLoadFileTextCallback', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'SetSaveFileTextCallback', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'LoadFileData', args: [#voidPtr, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadFileData', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'SaveFileData', args: [#voidPtr, #voidPtr, #uint], ret: #bool }
  os.CFunc{ sym: 'ExportDataAsCode', args: [#voidPtr, #uint, #voidPtr], ret: #bool }
  os.CFunc{ sym: 'LoadFileText', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadFileText', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'SaveFileText', args: [#voidPtr, #voidPtr], ret: #bool }
  os.CFunc{ sym: 'FileExists', args: [#voidPtr], ret: #bool }
  os.CFunc{ sym: 'DirectoryExists', args: [#voidPtr], ret: #bool }
  os.CFunc{ sym: 'IsFileExtension', args: [#voidPtr, #voidPtr], ret: #bool }
  os.CFunc{ sym: 'GetFileLength', args: [#voidPtr], ret: #int }
  os.CFunc{ sym: 'GetFileExtension', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'GetFileName', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'GetFileNameWithoutExt', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'GetDirectoryPath', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'GetPrevDirectoryPath', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'GetWorkingDirectory', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'GetApplicationDirectory', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'ChangeDirectory', args: [#voidPtr], ret: #bool }
  os.CFunc{ sym: 'IsPathFile', args: [#voidPtr], ret: #bool }
  os.CFunc{ sym: 'LoadDirectoryFiles', args: [#voidPtr], ret: FilePathList }
  os.CFunc{ sym: 'LoadDirectoryFilesEx', args: [#voidPtr, #voidPtr, #bool], ret: FilePathList }
  os.CFunc{ sym: 'UnloadDirectoryFiles', args: [FilePathList], ret: #voidPtr }
  os.CFunc{ sym: 'IsFileDropped', args: [], ret: #bool }
  os.CFunc{ sym: 'LoadDroppedFiles', args: [], ret: FilePathList }
  os.CFunc{ sym: 'UnloadDroppedFiles', args: [FilePathList], ret: #voidPtr }
  os.CFunc{ sym: 'GetFileModTime', args: [#voidPtr], ret: #long }
  os.CFunc{ sym: 'CompressData', args: [#voidPtr, #int, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'DecompressData', args: [#voidPtr, #int, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'EncodeDataBase64', args: [#voidPtr, #int, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'DecodeDataBase64', args: [#voidPtr, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'IsKeyPressed', args: [#int], ret: #bool }
  os.CFunc{ sym: 'IsKeyDown', args: [#int], ret: #bool }
  os.CFunc{ sym: 'IsKeyReleased', args: [#int], ret: #bool }
  os.CFunc{ sym: 'IsKeyUp', args: [#int], ret: #bool }
  os.CFunc{ sym: 'SetExitKey', args: [#int], ret: #voidPtr }
  os.CFunc{ sym: 'GetKeyPressed', args: [], ret: #int }
  os.CFunc{ sym: 'GetCharPressed', args: [], ret: #int }
  os.CFunc{ sym: 'IsGamepadAvailable', args: [#int], ret: #bool }
  os.CFunc{ sym: 'GetGamepadName', args: [#int], ret: #voidPtr }
  os.CFunc{ sym: 'IsGamepadButtonPressed', args: [#int, #int], ret: #bool }
  os.CFunc{ sym: 'IsGamepadButtonDown', args: [#int, #int], ret: #bool }
  os.CFunc{ sym: 'IsGamepadButtonReleased', args: [#int, #int], ret: #bool }
  os.CFunc{ sym: 'IsGamepadButtonUp', args: [#int, #int], ret: #bool }
  os.CFunc{ sym: 'GetGamepadButtonPressed', args: [], ret: #int }
  os.CFunc{ sym: 'GetGamepadAxisCount', args: [#int], ret: #int }
  os.CFunc{ sym: 'GetGamepadAxisMovement', args: [#int, #int], ret: #float }
  os.CFunc{ sym: 'SetGamepadMappings', args: [#voidPtr], ret: #int }
  os.CFunc{ sym: 'IsMouseButtonPressed', args: [#int], ret: #bool }
  os.CFunc{ sym: 'IsMouseButtonDown', args: [#int], ret: #bool }
  os.CFunc{ sym: 'IsMouseButtonReleased', args: [#int], ret: #bool }
  os.CFunc{ sym: 'IsMouseButtonUp', args: [#int], ret: #bool }
  os.CFunc{ sym: 'GetMouseX', args: [], ret: #int }
  os.CFunc{ sym: 'GetMouseY', args: [], ret: #int }
  os.CFunc{ sym: 'GetMousePosition', args: [], ret: Vector2 }
  os.CFunc{ sym: 'GetMouseDelta', args: [], ret: Vector2 }
  os.CFunc{ sym: 'SetMousePosition', args: [#int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'SetMouseOffset', args: [#int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'SetMouseScale', args: [#float, #float], ret: #voidPtr }
  os.CFunc{ sym: 'GetMouseWheelMove', args: [], ret: #float }
  os.CFunc{ sym: 'GetMouseWheelMoveV', args: [], ret: Vector2 }
  os.CFunc{ sym: 'SetMouseCursor', args: [#int], ret: #voidPtr }
  os.CFunc{ sym: 'GetTouchX', args: [], ret: #int }
  os.CFunc{ sym: 'GetTouchY', args: [], ret: #int }
  os.CFunc{ sym: 'GetTouchPosition', args: [#int], ret: Vector2 }
  os.CFunc{ sym: 'GetTouchPointId', args: [#int], ret: #int }
  os.CFunc{ sym: 'GetTouchPointCount', args: [], ret: #int }
  os.CFunc{ sym: 'SetGesturesEnabled', args: [#uint], ret: #voidPtr }
  os.CFunc{ sym: 'IsGestureDetected', args: [#int], ret: #bool }
  os.CFunc{ sym: 'GetGestureDetected', args: [], ret: #int }
  os.CFunc{ sym: 'GetGestureHoldDuration', args: [], ret: #float }
  os.CFunc{ sym: 'GetGestureDragVector', args: [], ret: Vector2 }
  os.CFunc{ sym: 'GetGestureDragAngle', args: [], ret: #float }
  os.CFunc{ sym: 'GetGesturePinchVector', args: [], ret: Vector2 }
  os.CFunc{ sym: 'GetGesturePinchAngle', args: [], ret: #float }
  os.CFunc{ sym: 'UpdateCamera', args: [#voidPtr, #int], ret: #voidPtr }
  os.CFunc{ sym: 'UpdateCameraPro', args: [#voidPtr, Vector3, Vector3, #float], ret: #voidPtr }
  os.CFunc{ sym: 'SetShapesTexture', args: [Texture, Rectangle], ret: #voidPtr }
  os.CFunc{ sym: 'DrawPixel', args: [#int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawPixelV', args: [Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawLine', args: [#int, #int, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawLineV', args: [Vector2, Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawLineEx', args: [Vector2, Vector2, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawLineBezier', args: [Vector2, Vector2, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawLineBezierQuad', args: [Vector2, Vector2, Vector2, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawLineBezierCubic', args: [Vector2, Vector2, Vector2, Vector2, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawLineStrip', args: [#voidPtr, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCircle', args: [#int, #int, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCircleSector', args: [Vector2, #float, #float, #float, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCircleSectorLines', args: [Vector2, #float, #float, #float, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCircleGradient', args: [#int, #int, #float, Color, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCircleV', args: [Vector2, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCircleLines', args: [#int, #int, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawEllipse', args: [#int, #int, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawEllipseLines', args: [#int, #int, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRing', args: [Vector2, #float, #float, #float, #float, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRingLines', args: [Vector2, #float, #float, #float, #float, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRectangle', args: [#int, #int, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRectangleV', args: [Vector2, Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRectangleRec', args: [Rectangle, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRectanglePro', args: [Rectangle, Vector2, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRectangleGradientV', args: [#int, #int, #int, #int, Color, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRectangleGradientH', args: [#int, #int, #int, #int, Color, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRectangleGradientEx', args: [Rectangle, Color, Color, Color, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRectangleLines', args: [#int, #int, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRectangleLinesEx', args: [Rectangle, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRectangleRounded', args: [Rectangle, #float, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRectangleRoundedLines', args: [Rectangle, #float, #int, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTriangle', args: [Vector2, Vector2, Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTriangleLines', args: [Vector2, Vector2, Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTriangleFan', args: [#voidPtr, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTriangleStrip', args: [#voidPtr, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawPoly', args: [Vector2, #int, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawPolyLines', args: [Vector2, #int, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawPolyLinesEx', args: [Vector2, #int, #float, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'CheckCollisionRecs', args: [Rectangle, Rectangle], ret: #bool }
  os.CFunc{ sym: 'CheckCollisionCircles', args: [Vector2, #float, Vector2, #float], ret: #bool }
  os.CFunc{ sym: 'CheckCollisionCircleRec', args: [Vector2, #float, Rectangle], ret: #bool }
  os.CFunc{ sym: 'CheckCollisionPointRec', args: [Vector2, Rectangle], ret: #bool }
  os.CFunc{ sym: 'CheckCollisionPointCircle', args: [Vector2, Vector2, #float], ret: #bool }
  os.CFunc{ sym: 'CheckCollisionPointTriangle', args: [Vector2, Vector2, Vector2, Vector2], ret: #bool }
  os.CFunc{ sym: 'CheckCollisionPointPoly', args: [Vector2, #voidPtr, #int], ret: #bool }
  os.CFunc{ sym: 'CheckCollisionLines', args: [Vector2, Vector2, Vector2, Vector2, #voidPtr], ret: #bool }
  os.CFunc{ sym: 'CheckCollisionPointLine', args: [Vector2, Vector2, Vector2, #int], ret: #bool }
  os.CFunc{ sym: 'GetCollisionRec', args: [Rectangle, Rectangle], ret: Rectangle }
  os.CFunc{ sym: 'LoadImage', args: [#voidPtr], ret: Image }
  os.CFunc{ sym: 'LoadImageRaw', args: [#voidPtr, #int, #int, #int, #int], ret: Image }
  os.CFunc{ sym: 'LoadImageAnim', args: [#voidPtr, #voidPtr], ret: Image }
  os.CFunc{ sym: 'LoadImageFromMemory', args: [#voidPtr, #voidPtr, #int], ret: Image }
  os.CFunc{ sym: 'LoadImageFromTexture', args: [Texture], ret: Image }
  os.CFunc{ sym: 'LoadImageFromScreen', args: [], ret: Image }
  os.CFunc{ sym: 'IsImageReady', args: [Image], ret: #bool }
  os.CFunc{ sym: 'UnloadImage', args: [Image], ret: #voidPtr }
  os.CFunc{ sym: 'ExportImage', args: [Image, #voidPtr], ret: #bool }
  os.CFunc{ sym: 'ExportImageAsCode', args: [Image, #voidPtr], ret: #bool }
  os.CFunc{ sym: 'GenImageColor', args: [#int, #int, Color], ret: Image }
  os.CFunc{ sym: 'GenImageGradientV', args: [#int, #int, Color, Color], ret: Image }
  os.CFunc{ sym: 'GenImageGradientH', args: [#int, #int, Color, Color], ret: Image }
  os.CFunc{ sym: 'GenImageGradientRadial', args: [#int, #int, #float, Color, Color], ret: Image }
  os.CFunc{ sym: 'GenImageChecked', args: [#int, #int, #int, #int, Color, Color], ret: Image }
  os.CFunc{ sym: 'GenImageWhiteNoise', args: [#int, #int, #float], ret: Image }
  os.CFunc{ sym: 'GenImagePerlinNoise', args: [#int, #int, #int, #int, #float], ret: Image }
  os.CFunc{ sym: 'GenImageCellular', args: [#int, #int, #int], ret: Image }
  os.CFunc{ sym: 'GenImageText', args: [#int, #int, #voidPtr], ret: Image }
  os.CFunc{ sym: 'ImageCopy', args: [Image], ret: Image }
  os.CFunc{ sym: 'ImageFromImage', args: [Image, Rectangle], ret: Image }
  os.CFunc{ sym: 'ImageText', args: [#voidPtr, #int, Color], ret: Image }
  os.CFunc{ sym: 'ImageTextEx', args: [Font, #voidPtr, #float, #float, Color], ret: Image }
  os.CFunc{ sym: 'ImageFormat', args: [#voidPtr, #int], ret: #voidPtr }
  os.CFunc{ sym: 'ImageToPOT', args: [#voidPtr, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageCrop', args: [#voidPtr, Rectangle], ret: #voidPtr }
  os.CFunc{ sym: 'ImageAlphaCrop', args: [#voidPtr, #float], ret: #voidPtr }
  os.CFunc{ sym: 'ImageAlphaClear', args: [#voidPtr, Color, #float], ret: #voidPtr }
  os.CFunc{ sym: 'ImageAlphaMask', args: [#voidPtr, Image], ret: #voidPtr }
  os.CFunc{ sym: 'ImageAlphaPremultiply', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'ImageBlurGaussian', args: [#voidPtr, #int], ret: #voidPtr }
  os.CFunc{ sym: 'ImageResize', args: [#voidPtr, #int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'ImageResizeNN', args: [#voidPtr, #int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'ImageResizeCanvas', args: [#voidPtr, #int, #int, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageMipmaps', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDither', args: [#voidPtr, #int, #int, #int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'ImageFlipVertical', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'ImageFlipHorizontal', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'ImageRotateCW', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'ImageRotateCCW', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'ImageColorTint', args: [#voidPtr, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageColorInvert', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'ImageColorGrayscale', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'ImageColorContrast', args: [#voidPtr, #float], ret: #voidPtr }
  os.CFunc{ sym: 'ImageColorBrightness', args: [#voidPtr, #int], ret: #voidPtr }
  os.CFunc{ sym: 'ImageColorReplace', args: [#voidPtr, Color, Color], ret: #voidPtr }
  os.CFunc{ sym: 'LoadImageColors', args: [Image], ret: #voidPtr }
  os.CFunc{ sym: 'LoadImagePalette', args: [Image, #int, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadImageColors', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadImagePalette', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'GetImageAlphaBorder', args: [Image, #float], ret: Rectangle }
  os.CFunc{ sym: 'GetImageColor', args: [Image, #int, #int], ret: Color }
  os.CFunc{ sym: 'ImageClearBackground', args: [#voidPtr, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawPixel', args: [#voidPtr, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawPixelV', args: [#voidPtr, Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawLine', args: [#voidPtr, #int, #int, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawLineV', args: [#voidPtr, Vector2, Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawCircle', args: [#voidPtr, #int, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawCircleV', args: [#voidPtr, Vector2, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawCircleLines', args: [#voidPtr, #int, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawCircleLinesV', args: [#voidPtr, Vector2, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawRectangle', args: [#voidPtr, #int, #int, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawRectangleV', args: [#voidPtr, Vector2, Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawRectangleRec', args: [#voidPtr, Rectangle, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawRectangleLines', args: [#voidPtr, Rectangle, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDraw', args: [#voidPtr, Image, Rectangle, Rectangle, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawText', args: [#voidPtr, #voidPtr, #int, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawTextEx', args: [#voidPtr, Font, #voidPtr, Vector2, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'LoadTexture', args: [#voidPtr], ret: Texture }
  os.CFunc{ sym: 'LoadTextureFromImage', args: [Image], ret: Texture }
  os.CFunc{ sym: 'LoadTextureCubemap', args: [Image, #int], ret: Texture }
  os.CFunc{ sym: 'LoadRenderTexture', args: [#int, #int], ret: RenderTexture }
  os.CFunc{ sym: 'IsTextureReady', args: [Texture], ret: #bool }
  os.CFunc{ sym: 'UnloadTexture', args: [Texture], ret: #voidPtr }
  os.CFunc{ sym: 'IsRenderTextureReady', args: [RenderTexture], ret: #bool }
  os.CFunc{ sym: 'UnloadRenderTexture', args: [RenderTexture], ret: #voidPtr }
  os.CFunc{ sym: 'UpdateTexture', args: [Texture, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'UpdateTextureRec', args: [Texture, Rectangle, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'GenTextureMipmaps', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'SetTextureFilter', args: [Texture, #int], ret: #voidPtr }
  os.CFunc{ sym: 'SetTextureWrap', args: [Texture, #int], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTexture', args: [Texture, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTextureV', args: [Texture, Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTextureEx', args: [Texture, Vector2, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTextureRec', args: [Texture, Rectangle, Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTexturePro', args: [Texture, Rectangle, Rectangle, Vector2, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTextureNPatch', args: [Texture, NPatchInfo, Rectangle, Vector2, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'Fade', args: [Color, #float], ret: Color }
  os.CFunc{ sym: 'ColorToInt', args: [Color], ret: #int }
  os.CFunc{ sym: 'ColorNormalize', args: [Color], ret: Vector4 }
  os.CFunc{ sym: 'ColorFromNormalized', args: [Vector4], ret: Color }
  os.CFunc{ sym: 'ColorToHSV', args: [Color], ret: Vector3 }
  os.CFunc{ sym: 'ColorFromHSV', args: [#float, #float, #float], ret: Color }
  os.CFunc{ sym: 'ColorTint', args: [Color, Color], ret: Color }
  os.CFunc{ sym: 'ColorBrightness', args: [Color, #float], ret: Color }
  os.CFunc{ sym: 'ColorContrast', args: [Color, #float], ret: Color }
  os.CFunc{ sym: 'ColorAlpha', args: [Color, #float], ret: Color }
  os.CFunc{ sym: 'ColorAlphaBlend', args: [Color, Color, Color], ret: Color }
  os.CFunc{ sym: 'GetColor', args: [#uint], ret: Color }
  os.CFunc{ sym: 'GetPixelColor', args: [#voidPtr, #int], ret: Color }
  os.CFunc{ sym: 'SetPixelColor', args: [#voidPtr, Color, #int], ret: #voidPtr }
  os.CFunc{ sym: 'GetPixelDataSize', args: [#int, #int, #int], ret: #int }
  os.CFunc{ sym: 'GetFontDefault', args: [], ret: Font }
  os.CFunc{ sym: 'LoadFont', args: [#voidPtr], ret: Font }
  os.CFunc{ sym: 'LoadFontEx', args: [#voidPtr, #int, #voidPtr, #int], ret: Font }
  os.CFunc{ sym: 'LoadFontFromImage', args: [Image, Color, #int], ret: Font }
  os.CFunc{ sym: 'LoadFontFromMemory', args: [#voidPtr, #voidPtr, #int, #int, #voidPtr, #int], ret: Font }
  os.CFunc{ sym: 'IsFontReady', args: [Font], ret: #bool }
  os.CFunc{ sym: 'LoadFontData', args: [#voidPtr, #int, #int, #voidPtr, #int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'GenImageFontAtlas', args: [#voidPtr, #voidPtr, #int, #int, #int, #int], ret: Image }
  os.CFunc{ sym: 'UnloadFontData', args: [#voidPtr, #int], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadFont', args: [Font], ret: #voidPtr }
  os.CFunc{ sym: 'ExportFontAsCode', args: [Font, #voidPtr], ret: #bool }
  os.CFunc{ sym: 'DrawFPS', args: [#int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'DrawText', args: [#voidPtr, #int, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTextEx', args: [Font, #voidPtr, Vector2, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTextPro', args: [Font, #voidPtr, Vector2, Vector2, #float, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTextCodepoint', args: [Font, #int, Vector2, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTextCodepoints', args: [Font, #voidPtr, #int, Vector2, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'MeasureText', args: [#voidPtr, #int], ret: #int }
  os.CFunc{ sym: 'MeasureTextEx', args: [Font, #voidPtr, #float, #float], ret: Vector2 }
  os.CFunc{ sym: 'GetGlyphIndex', args: [Font, #int], ret: #int }
  os.CFunc{ sym: 'GetGlyphInfo', args: [Font, #int], ret: GlyphInfo }
  os.CFunc{ sym: 'GetGlyphAtlasRec', args: [Font, #int], ret: Rectangle }
  os.CFunc{ sym: 'LoadUTF8', args: [#voidPtr, #int], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadUTF8', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'LoadCodepoints', args: [#voidPtr, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadCodepoints', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'GetCodepointCount', args: [#voidPtr], ret: #int }
  os.CFunc{ sym: 'GetCodepoint', args: [#voidPtr, #voidPtr], ret: #int }
  os.CFunc{ sym: 'GetCodepointNext', args: [#voidPtr, #voidPtr], ret: #int }
  os.CFunc{ sym: 'GetCodepointPrevious', args: [#voidPtr, #voidPtr], ret: #int }
  os.CFunc{ sym: 'CodepointToUTF8', args: [#int, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'TextCopy', args: [#voidPtr, #voidPtr], ret: #int }
  os.CFunc{ sym: 'TextIsEqual', args: [#voidPtr, #voidPtr], ret: #bool }
  os.CFunc{ sym: 'TextLength', args: [#voidPtr], ret: #uint }
  os.CFunc{ sym: 'TextSubtext', args: [#voidPtr, #int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'TextReplace', args: [#voidPtr, #voidPtr, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'TextInsert', args: [#voidPtr, #voidPtr, #int], ret: #voidPtr }
  os.CFunc{ sym: 'TextJoin', args: [#voidPtr, #int, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'TextSplit', args: [#voidPtr, #uchar, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'TextAppend', args: [#voidPtr, #voidPtr, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'TextFindIndex', args: [#voidPtr, #voidPtr], ret: #int }
  os.CFunc{ sym: 'TextToUpper', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'TextToLower', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'TextToPascal', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'TextToInteger', args: [#voidPtr], ret: #int }
  os.CFunc{ sym: 'DrawLine3D', args: [Vector3, Vector3, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawPoint3D', args: [Vector3, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCircle3D', args: [Vector3, #float, Vector3, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTriangle3D', args: [Vector3, Vector3, Vector3, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTriangleStrip3D', args: [#voidPtr, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCube', args: [Vector3, #float, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCubeV', args: [Vector3, Vector3, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCubeWires', args: [Vector3, #float, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCubeWiresV', args: [Vector3, Vector3, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawSphere', args: [Vector3, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawSphereEx', args: [Vector3, #float, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawSphereWires', args: [Vector3, #float, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCylinder', args: [Vector3, #float, #float, #float, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCylinderEx', args: [Vector3, Vector3, #float, #float, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCylinderWires', args: [Vector3, #float, #float, #float, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCylinderWiresEx', args: [Vector3, Vector3, #float, #float, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCapsule', args: [Vector3, Vector3, #float, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawCapsuleWires', args: [Vector3, Vector3, #float, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawPlane', args: [Vector3, Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawRay', args: [Ray, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawGrid', args: [#int, #float], ret: #voidPtr }
  os.CFunc{ sym: 'LoadModel', args: [#voidPtr], ret: Model }
  os.CFunc{ sym: 'LoadModelFromMesh', args: [Mesh], ret: Model }
  os.CFunc{ sym: 'IsModelReady', args: [Model], ret: #bool }
  os.CFunc{ sym: 'UnloadModel', args: [Model], ret: #voidPtr }
  os.CFunc{ sym: 'GetModelBoundingBox', args: [Model], ret: BoundingBox }
  os.CFunc{ sym: 'DrawModel', args: [Model, Vector3, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawModelEx', args: [Model, Vector3, Vector3, #float, Vector3, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawModelWires', args: [Model, Vector3, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawModelWiresEx', args: [Model, Vector3, Vector3, #float, Vector3, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawBoundingBox', args: [BoundingBox, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawBillboard', args: [Camera3D, Texture, Vector3, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawBillboardRec', args: [Camera3D, Texture, Rectangle, Vector3, Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawBillboardPro', args: [Camera3D, Texture, Rectangle, Vector3, Vector3, Vector2, Vector2, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'UploadMesh', args: [#voidPtr, #bool], ret: #voidPtr }
  os.CFunc{ sym: 'UpdateMeshBuffer', args: [Mesh, #int, #voidPtr, #int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadMesh', args: [Mesh], ret: #voidPtr }
  os.CFunc{ sym: 'DrawMesh', args: [Mesh, Material, Matrix], ret: #voidPtr }
  os.CFunc{ sym: 'DrawMeshInstanced', args: [Mesh, Material, #voidPtr, #int], ret: #voidPtr }
  os.CFunc{ sym: 'ExportMesh', args: [Mesh, #voidPtr], ret: #bool }
  os.CFunc{ sym: 'GetMeshBoundingBox', args: [Mesh], ret: BoundingBox }
  os.CFunc{ sym: 'GenMeshTangents', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'GenMeshPoly', args: [#int, #float], ret: Mesh }
  os.CFunc{ sym: 'GenMeshPlane', args: [#float, #float, #int, #int], ret: Mesh }
  os.CFunc{ sym: 'GenMeshCube', args: [#float, #float, #float], ret: Mesh }
  os.CFunc{ sym: 'GenMeshSphere', args: [#float, #int, #int], ret: Mesh }
  os.CFunc{ sym: 'GenMeshHemiSphere', args: [#float, #int, #int], ret: Mesh }
  os.CFunc{ sym: 'GenMeshCylinder', args: [#float, #float, #int], ret: Mesh }
  os.CFunc{ sym: 'GenMeshCone', args: [#float, #float, #int], ret: Mesh }
  os.CFunc{ sym: 'GenMeshTorus', args: [#float, #float, #int, #int], ret: Mesh }
  os.CFunc{ sym: 'GenMeshKnot', args: [#float, #float, #int, #int], ret: Mesh }
  os.CFunc{ sym: 'GenMeshHeightmap', args: [Image, Vector3], ret: Mesh }
  os.CFunc{ sym: 'GenMeshCubicmap', args: [Image, Vector3], ret: Mesh }
  os.CFunc{ sym: 'LoadMaterials', args: [#voidPtr, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'LoadMaterialDefault', args: [], ret: Material }
  os.CFunc{ sym: 'IsMaterialReady', args: [Material], ret: #bool }
  os.CFunc{ sym: 'UnloadMaterial', args: [Material], ret: #voidPtr }
  os.CFunc{ sym: 'SetMaterialTexture', args: [#voidPtr, #int, Texture], ret: #voidPtr }
  os.CFunc{ sym: 'SetModelMeshMaterial', args: [#voidPtr, #int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'LoadModelAnimations', args: [#voidPtr, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'UpdateModelAnimation', args: [Model, ModelAnimation, #int], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadModelAnimation', args: [ModelAnimation], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadModelAnimations', args: [#voidPtr, #uint], ret: #voidPtr }
  os.CFunc{ sym: 'IsModelAnimationValid', args: [Model, ModelAnimation], ret: #bool }
  os.CFunc{ sym: 'CheckCollisionSpheres', args: [Vector3, #float, Vector3, #float], ret: #bool }
  os.CFunc{ sym: 'CheckCollisionBoxes', args: [BoundingBox, BoundingBox], ret: #bool }
  os.CFunc{ sym: 'CheckCollisionBoxSphere', args: [BoundingBox, Vector3, #float], ret: #bool }
  os.CFunc{ sym: 'GetRayCollisionSphere', args: [Ray, Vector3, #float], ret: RayCollision }
  os.CFunc{ sym: 'GetRayCollisionBox', args: [Ray, BoundingBox], ret: RayCollision }
  os.CFunc{ sym: 'GetRayCollisionMesh', args: [Ray, Mesh, Matrix], ret: RayCollision }
  os.CFunc{ sym: 'GetRayCollisionTriangle', args: [Ray, Vector3, Vector3, Vector3], ret: RayCollision }
  os.CFunc{ sym: 'GetRayCollisionQuad', args: [Ray, Vector3, Vector3, Vector3, Vector3], ret: RayCollision }
  os.CFunc{ sym: 'InitAudioDevice', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'CloseAudioDevice', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'IsAudioDeviceReady', args: [], ret: #bool }
  os.CFunc{ sym: 'SetMasterVolume', args: [#float], ret: #voidPtr }
  os.CFunc{ sym: 'LoadWave', args: [#voidPtr], ret: Wave }
  os.CFunc{ sym: 'LoadWaveFromMemory', args: [#voidPtr, #voidPtr, #int], ret: Wave }
  os.CFunc{ sym: 'IsWaveReady', args: [Wave], ret: #bool }
  os.CFunc{ sym: 'LoadSound', args: [#voidPtr], ret: Sound }
  os.CFunc{ sym: 'LoadSoundFromWave', args: [Wave], ret: Sound }
  os.CFunc{ sym: 'IsSoundReady', args: [Sound], ret: #bool }
  os.CFunc{ sym: 'UpdateSound', args: [Sound, #voidPtr, #int], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadWave', args: [Wave], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadSound', args: [Sound], ret: #voidPtr }
  os.CFunc{ sym: 'ExportWave', args: [Wave, #voidPtr], ret: #bool }
  os.CFunc{ sym: 'ExportWaveAsCode', args: [Wave, #voidPtr], ret: #bool }
  os.CFunc{ sym: 'PlaySound', args: [Sound], ret: #voidPtr }
  os.CFunc{ sym: 'StopSound', args: [Sound], ret: #voidPtr }
  os.CFunc{ sym: 'PauseSound', args: [Sound], ret: #voidPtr }
  os.CFunc{ sym: 'ResumeSound', args: [Sound], ret: #voidPtr }
  os.CFunc{ sym: 'IsSoundPlaying', args: [Sound], ret: #bool }
  os.CFunc{ sym: 'SetSoundVolume', args: [Sound, #float], ret: #voidPtr }
  os.CFunc{ sym: 'SetSoundPitch', args: [Sound, #float], ret: #voidPtr }
  os.CFunc{ sym: 'SetSoundPan', args: [Sound, #float], ret: #voidPtr }
  os.CFunc{ sym: 'WaveCopy', args: [Wave], ret: Wave }
  os.CFunc{ sym: 'WaveCrop', args: [#voidPtr, #int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'WaveFormat', args: [#voidPtr, #int, #int, #int], ret: #voidPtr }
  os.CFunc{ sym: 'LoadWaveSamples', args: [Wave], ret: #voidPtr }
  os.CFunc{ sym: 'UnloadWaveSamples', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'LoadMusicStream', args: [#voidPtr], ret: Music }
  os.CFunc{ sym: 'LoadMusicStreamFromMemory', args: [#voidPtr, #voidPtr, #int], ret: Music }
  os.CFunc{ sym: 'IsMusicReady', args: [Music], ret: #bool }
  os.CFunc{ sym: 'UnloadMusicStream', args: [Music], ret: #voidPtr }
  os.CFunc{ sym: 'PlayMusicStream', args: [Music], ret: #voidPtr }
  os.CFunc{ sym: 'IsMusicStreamPlaying', args: [Music], ret: #bool }
  os.CFunc{ sym: 'UpdateMusicStream', args: [Music], ret: #voidPtr }
  os.CFunc{ sym: 'StopMusicStream', args: [Music], ret: #voidPtr }
  os.CFunc{ sym: 'PauseMusicStream', args: [Music], ret: #voidPtr }
  os.CFunc{ sym: 'ResumeMusicStream', args: [Music], ret: #voidPtr }
  os.CFunc{ sym: 'SeekMusicStream', args: [Music, #float], ret: #voidPtr }
  os.CFunc{ sym: 'SetMusicVolume', args: [Music, #float], ret: #voidPtr }
  os.CFunc{ sym: 'SetMusicPitch', args: [Music, #float], ret: #voidPtr }
  os.CFunc{ sym: 'SetMusicPan', args: [Music, #float], ret: #voidPtr }
  os.CFunc{ sym: 'GetMusicTimeLength', args: [Music], ret: #float }
  os.CFunc{ sym: 'GetMusicTimePlayed', args: [Music], ret: #float }
  os.CFunc{ sym: 'LoadAudioStream', args: [#uint, #uint, #uint], ret: AudioStream }
  os.CFunc{ sym: 'IsAudioStreamReady', args: [AudioStream], ret: #bool }
  os.CFunc{ sym: 'UnloadAudioStream', args: [AudioStream], ret: #voidPtr }
  os.CFunc{ sym: 'UpdateAudioStream', args: [AudioStream, #voidPtr, #int], ret: #voidPtr }
  os.CFunc{ sym: 'IsAudioStreamProcessed', args: [AudioStream], ret: #bool }
  os.CFunc{ sym: 'PlayAudioStream', args: [AudioStream], ret: #voidPtr }
  os.CFunc{ sym: 'PauseAudioStream', args: [AudioStream], ret: #voidPtr }
  os.CFunc{ sym: 'ResumeAudioStream', args: [AudioStream], ret: #voidPtr }
  os.CFunc{ sym: 'IsAudioStreamPlaying', args: [AudioStream], ret: #bool }
  os.CFunc{ sym: 'StopAudioStream', args: [AudioStream], ret: #voidPtr }
  os.CFunc{ sym: 'SetAudioStreamVolume', args: [AudioStream, #float], ret: #voidPtr }
  os.CFunc{ sym: 'SetAudioStreamPitch', args: [AudioStream, #float], ret: #voidPtr }
  os.CFunc{ sym: 'SetAudioStreamPan', args: [AudioStream, #float], ret: #voidPtr }
  os.CFunc{ sym: 'SetAudioStreamBufferSizeDefault', args: [#int], ret: #voidPtr }
  os.CFunc{ sym: 'SetAudioStreamCallback', args: [AudioStream, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'AttachAudioStreamProcessor', args: [AudioStream, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'DetachAudioStreamProcessor', args: [AudioStream, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'AttachAudioMixedProcessor', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'DetachAudioMixedProcessor', args: [#voidPtr], ret: #voidPtr }
], { genMap: true })

