import t 'test'
import os 'os'

-- error()
-- See error_test.cy

-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")


-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()

  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
foo()
^
")
foo()

vtt = "main:49:3 
  main: throw error.Boom  
  ^ 
"
-- error()
-- See error_test.cy
-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main: ")


-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
")
import t 'test'
import os 'os'





-- error()
-- See error_test.cy

-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
foo()
^
" )
foo()

vtt = "main:49:3 
  main: throw error.Boom  
  ^ 
"
-- error()
-- See error_test.cy
-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main: ")


-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
")
import t 'test'
import os 'os'





-- error()
-- See error_test.cy

-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
foo()
^
" )
foo()

vtt = "main:49:3 
  main: throw error.Boom  
  ^ 
"
-- error()
-- See error_test.cy
-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main: ")


-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
")
import t 'test'
import os 'os'

-- error()
-- See error_test.cy

-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
foo()
^
" )
foo()

vtt = "main:49:3 
  main: throw error.Boom  
  ^ 
"
-- error()
-- See error_test.cy
-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main: ")


-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
")
import t 'test'
import os 'os'





-- error()
-- See error_test.cy

-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
foo()
^
" )
foo()

vtt = "main:49:3 
  main: throw error.Boom  
  ^ 
"
-- error()
-- See error_test.cy
-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main: ")


-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
")
import t 'test'
import os 'os'





-- error()
-- See error_test.cy

-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
foo()
^
" )
foo()

vtt = "main:49:3 
  main: throw error.Boom  
  ^ 
"
-- error()
-- See error_test.cy
-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main: ")


-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
")
import t 'test'
import os 'os'

-- error()
-- See error_test.cy

-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
foo()
^
" )
foo()

vtt = "main:49:3 
  main: throw error.Boom  
  ^ 
"
-- error()
-- See error_test.cy
-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main: ")


-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
")
import t 'test'
import os 'os'





-- error()
-- See error_test.cy

-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
foo()
^
" )
foo()

vtt = "main:49:3 
  main: throw error.Boom  
  ^ 
"
-- error()
-- See error_test.cy
-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main: ")


-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
")
import t 'test'
import os 'os'





-- error()
-- See error_test.cy

-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
foo()
^
" )
foo()

vtt = "main:49:3 
  main: throw error.Boom  
  ^ 
"
-- error()
-- See error_test.cy
-- errorReport(), current frame.
try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main:
  throw error.Boom
  ^
")

try:
  throw error.Boom
catch:
  t.eq(errorReport(), "main:49:3 main: ")


-- errorReport(), one frame before and one frame after.
func foo2():
  throw error.Boom
func foo():
  try:
    foo2()
  catch:
    t.eq(errorReport(), "main:58:3 foo2:
  throw error.Boom
  ^
main:61:5 foo:
    foo2()
    ^
main:73:1 main:
")

