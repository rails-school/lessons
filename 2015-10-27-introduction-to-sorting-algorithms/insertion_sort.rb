def swap(a, i, j)
  tmp = a[i]
  a[i] = a[j]
  a[j] = tmp
end

def sort(a)
  i = 0

  while i < a.length
    j = i + 1
    min = a[i]
    k = i
    while j < a.length
      if a[j] < min
        min = a[j]
        k = j
      end
      j += 1
    end

    swap(a, i, k)
    i += 1
  end

  a
end

sort [45, 89, 14, 13598, 1487, 2, 3, 568, 81]