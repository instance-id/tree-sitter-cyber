#!/usr/local/bin/cyber

import os 'os'
args = os.args()

func fib(n int) int:
  coyield
  if n < 2:
    return n
  return fib(n - 1) + fib(n - 2)

count = 0    -- Counts number of recursive calls to fib.
fiber = coinit fib(28)

while fiber.status() != #done:
  res = coresume fiber
  count += 1

print '{res} {count}'

str = 'abc aabbcc acb aabb c'
cur = 0
for str[cur..].indexChar('c') as i:
  print 'Found char at {cur + i}.'
  cur += i + 1

object Node:
  data any
  next Node
  func new(data):
    return Node{ data: data, next: none }
  func insert(self, node):
    if self.next == none: self.next = node
    else:
      node.next = self.next
      self.next = node

list = Node.new(1)
list.insert(Node.new(2))
list.insert(Node.new(3))

while list != none:
  print list.data
  list = list.next
