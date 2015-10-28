def swap(a, i, j)
  tmp = a[i]
  a[i] = a[j]
  a[j] = tmp
end

def sort_rec(a, i_start, i_end)
  if i_start == i_end
    return [a[i_start]]
  elsif i_start == i_end - 1
    if a[i_start] > a[i_end]
      return [a[i_end], a[i_start]]
    else
      return [a[i_start], a[i_end]]
    end
  else
    middle = (i_end + i_start) / 2
    t = sort_rec(a, i_start, middle)
    u = sort_rec(a, middle + 1, i_end)
    k = 0
    l = 0
    outcome = []

    while k < t.count && l < u.count
      if t[k] < u[l]
        outcome << t[k]
        k += 1
      else
        outcome << u[l]
        l += 1
      end
    end

    if l >= u.count
      while k < t.count
        outcome << t[k]
        k += 1
      end
    else
      while l < u.count
        outcome << u[l]
        l += 1
      end
    end

    return outcome
  end
end

def sort(a)
  sort_rec(a, 0, a.count - 1)
end

sort [45, 89, 14, 13598, 1487, 2, 3, 568, 81]