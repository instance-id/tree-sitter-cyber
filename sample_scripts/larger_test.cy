#!/usr/local/bin/cyber 

import os 'os'
args = os.args()

foo = 1
if true:
  foo = 123

func fib(n int) int:
  coyield
  if n < 2:
    return n
  return fib(n - 1) + fib(n - 2)

fib(1)
count = 0    -- Counts number of recursive calls to fib.
fiber = coinit fib(28)

while fiber.status() != #done:
  res = coresume fiber
  count += 1

print '{res} {count}'

str = 'abc aabbcc acb aabb c'
cur = 0
while str[cur..].findRune(0u'c') some i:
    print 'Found char at {cur + i}.'
    cur += i + 1

type Node object:
  data any
  next Node
  func new(data):
    return Node { data: data, next: none }
  func insert(self, node):
    if self.next == none: self.next = node
    else:
      node.next = self.next
      self.next = node

list = Node.new(1)
list.insert(Node.new(2))
list.insert(Node.new(3))

type Node2 object:
    value
    next

    -- A static function.
    func create():
        return Node2{ value: 123, next: none }

    -- A method.
    func dump(self):
        print self.value

n = Node2.create()
n.dump()

while list != none:
  print list.data
  list = list.next
