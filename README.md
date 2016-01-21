# swift-simple-queue
A very simple implementation of a fifo-queue in swift.
This queue allows both enqueuing and dequeuing in constant time.

The whole package does not use Foundation, that means it's good to go for linux :penguin:.


## Examples
```
var q = FifoQueue<Int>()
q.push(1)
q.push(5)
print(q.count) // Size is 2
print(q.pop()) // 1
```
```
var q = FifoQueue(array: [1,2,3])
```
