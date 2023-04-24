#!/usr/local/bin/cyber

type ThisType object:
  type1 int

import os 'os'
var lib: os.bindLib('libraylib.dylib', [
  os.CFunc{ sym: 'StopAudioStream', args: [ AudioStream ], ret: #voidPtr }
  os.CFunc{ sym: 'SetAudioStreamPitch', args: [AudioStream, #float], ret: #voidPtr }
  os.CFunc{ sym: 'SetAudioStreamPan', args: [AudioStream, #float], ret: #voidPtr }
  os.CFunc{ sym: 'SetAudioStreamBufferSizeDefault', args: [#int], ret: #voidPtr }
  os.CFunc{ sym: 'SetAudioStreamCallback', args: [AudioStream, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'AttachAudioStreamProcessor', args: [AudioStream, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'DetachAudioStreamProcessor', args: [AudioStream, #voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'AttachAudioMixedProcessor', args: [#voidPtr], ret: #voidPtr }
  os.CFunc{ sym: 'DetachAudioMixedProcessor', args: [#voidPtr], ret: #voidPtr }
], { genMap: true })

