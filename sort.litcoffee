#Quicksort

    quicksort = (a) ->
     swap = (x, y) ->
      t = a[x]
      a[x] = a[y]
      a[y] = t

     stack = []
     stack.push [0, a.length - 1]

     while stack.length > 0
      [s, e] = stack.pop()
      if e - s is 1
       swap e, s if a[e] < a[s]
       continue

      m = Math.floor (s + e) / 2
      swap s, m
      p = a[s]
      i = s + 1
      j = e
      while true
       while i <= j and a[i] < p
        ++i
       while i < j and a[j] >= p
        --j

       break if i >= j
       swap i, j

      swap s, i - 1
      if (i - 2) - s > 0
       stack.push [s, i - 2]
      while i < e and a[i] <= p
       ++i
      if e - i > 0
       stack.push [i, e]
      #console.log 'test', stack

      #str = ''
      #for i in [s..e]
      # str += "#{a[i]} "
      #console.log p, str

     a = undefined
     stack = undefined
     undefined

    mergesort = (a1, a2) ->
     N = a1.length
     n = 1
     while n < N
      o = 0
      while o + n < N
       i1 = o
       j1 = i2 = i1 + n
       j2 = Math.min j1 + n, N

       k = i1
       i = i1
       j = j1
       while k < j2
        if i is i2
         while j < j2
          a2[k++] = a1[j++]
        else if j is j2
         while i < i2
          a2[k++] = a1[i++]
        else if a1[i] < a1[j]
         a2[k++] = a1[i++]
        else
         a2[k++] = a1[j++]

       o = j2

      while o < N
       a2[o] = a1[o]
       ++o


      #str = ''
      #for x in a2
      # str += "#{x} "
      #console.log str
      #console.log n

      n <<= 1
      t = a1
      a1 = a2
      a2 = t

     return a1

##Export

    if module?
     exports.quicksort = quicksort
     exports.mergesort = mergesort
    else
     @jshelpersSort =
      quicksort: quicksort
      mergesort: mergesort
