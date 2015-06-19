N = 30100100

sort = require './sort'

a1 = new Float64Array N
t = new Float64Array N
a2 = new Float64Array N
a3 = new Array N

console.time 'load'
for i in [0...N]
 v = Math.floor Math.random() * N
 a1[i] = a2[i] = a3[i] = v
console.timeEnd 'load'

console.time 'quicksort'
sort.quicksort a1
console.timeEnd 'quicksort'

for i in [0..N - 1]
 if a1[i] > a1[i + 1]
  throw new Error "#{a1[i]} #{a1[i + 1]} #{i} unordered"

console.time 'sort'
Array.prototype.sort.call a2, (x, y) -> x - y
console.timeEnd 'sort'

console.time 'sortArray'
a3.sort (x, y) -> x - y
console.timeEnd 'sortArray'
