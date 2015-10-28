def swap(a, i, j)
  tmp = a[i]
  a[i] = a[j]
  a[j] = tmp
end

def partition(a, i_start, i_end, i_pivot)
  swap(a, i_end, i_pivot)
  i_pivot = i_end

  i = i_start
  j = i_start
  while i < i_end
    if a[i] < a[i_pivot]
      swap(a, i, j)
      j += 1
    end
    i += 1
  end

  swap(a, j, i_pivot)
  j
end

def quick_sort_rec(a, i_start, i_end)
  if i_start < i_end
    pivot = i_start
    p = partition a, i_start, i_end, pivot
    quick_sort_rec a, i_start, p - 1
    quick_sort_rec a, p + 1, i_end
  end
end

def sort(a)
  quick_sort_rec(a, 0, a.count - 1)
  a
end

sort [45, 89, 14, 13598, 1487, 2, 3, 568, 81]