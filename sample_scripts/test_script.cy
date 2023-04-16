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
while str[cur..].findRune(0u'c') some i:
    print 'Found char at {cur + i}.'
    cur += i + 1
