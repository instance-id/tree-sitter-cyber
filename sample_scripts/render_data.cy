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

type rAudioBuffer pointer
type rAudioProcessor pointer
type AudioStream object:
  buffer pointer -- ?*rAudioBuffer
  processor pointer -- ?*rAudioProcessor
  sampleRate number
  sampleSize number
  channels number

var FLAG_VSYNC_HINT: 64
type MouseButton number
var MOUSE_CURSOR_DEFAULT: 0
type Gesture number
var CAMERA_ORTHOGRAPHIC: 1
type CameraProjection number
var NPATCH_NINE_PATCH: 0
var NPATCH_THREE_PATCH_HORIZONTAL: 2
type NPatchLayout number
type LoadFileDataCallback pointer
func InitWindow(width number, height number, title pointer) pointer = lib.InitWindow
func WindowShouldClose() boolean = lib.WindowShouldClose
func CloseWindow() pointer = lib.CloseWindow
func GenMeshPlane(width number, length number, resX number, resZ number) Mesh = lib.GenMeshPlane
func GetRayCollisionMesh(ray Ray, mesh Mesh, transform Matrix) RayCollision = lib.GetRayCollisionMesh
func GetRayCollisionTriangle(ray Ray, p1 Vector3, p2 Vector3, p3 Vector3) RayCollision = lib.GetRayCollisionTriangle
func GetRayCollisionQuad(ray Ray, p1 Vector3, p2 Vector3, p3 Vector3, p4 Vector3) RayCollision = lib.GetRayCollisionQuad
type AudioCallback pointer
func InitAudioDevice() pointer = lib.InitAudioDevice
func LoadMusicStreamFromMemory(fileType pointer, data pointer, dataSize number) Music = lib.LoadMusicStreamFromMemory
func AttachAudioStreamProcessor(stream AudioStream, processor pointer) pointer = lib.AttachAudioStreamProcessor
func DetachAudioStreamProcessor(stream AudioStream, processor pointer) pointer = lib.DetachAudioStreamProcessor
func AttachAudioMixedProcessor(processor pointer) pointer = lib.AttachAudioMixedProcessor
func DetachAudioMixedProcessor(processor pointer) pointer = lib.DetachAudioMixedProcessor
var RAYLIB_VERSION: "4.6-dev"
var MOUSE_LEFT_BUTTON: MOUSE_BUTTON_LEFT

import os 'os'
var lib: os.bindLib('libraylib.dylib', [
  os.CFunc{ sym: 'InitWindow', args: [#int, #int, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'WindowShouldClose', args: [], ret: #bool }
  os.CFunc{ sym: 'CloseWindow', args: [], ret: #voidPtr }
  os.CFunc{ sym: 'IsWindowState', args: [#uint], ret: #bool }
  os.CFunc{ sym: 'SetWindowState', args: [#uint], ret: #voidPtr }
  os.CFunc{ sym: 'ClearWindowState', args: [#uint], ret: #voidPtr }
  os.CFunc{ sym: 'LoadDirectoryFilesEx', args: [#voidPtr, #voidPtr, #bool], ret: FilePathList }
  os.CFunc{ sym: 'ImageDrawText', args: [#voidPtr, #voidPtr, #int, #int, #int, Color], ret: #voidPtr }
  os.CFunc{ sym: 'ImageDrawTextEx', args: [#voidPtr, Font, #voidPtr, Vector2, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTextureEx', args: [Texture, Vector2, #float, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTextureRec', args: [Texture, Rectangle, Vector2, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTexturePro', args: [Texture, Rectangle, Rectangle, Vector2, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'DrawTextureNPatch', args: [Texture, NPatchInfo, Rectangle, Vector2, #float, Color], ret: #voidPtr }
  os.CFunc{ sym: 'LoadModel', args: [#voidPtr], ret: Model }
], { genMap: true })
