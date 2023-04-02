#!/usr/local/bin/cyber
import os 'os'

args = os.args()

func fib(n int) int:
  coyield
  if n < 2:
    return n
  return fib(n - 1) + fib(n - 2)

str = 'abc aabbcc acb aabb c'
cur = 0

for str[cur..].indexChar('c') as i:
  print 'Found char at {cur + i}.'
  cur += i + 1

