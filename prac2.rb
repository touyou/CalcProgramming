def simplesort(a)
    for i in 0 .. (a.length-1)
        k = i
        for j in i+1 .. (a.length-1)
            if a[j] < a[k]
                k = j
            end
        end
        v = a[i]
        a[i] = a[k]
        a[k] = v
    end
    return a
end

def mergesort(a)
    mergesortSub(a, 0, a.length)
end

def mergesortSub(a, l, r)
    if r > l+1
        m = (l + r) / 2
        mergesortSub(a, l, m)
        mergesortSub(a, m, r)
        merge2(a, l, m, r)
    end
    return a
end

def merge2(a, l, m, n)
    c = Array.new(n-1)
    ia = l
    ib = m
    for i in 0..c.length-1
        if ia >= m
            c[i] = a[ib]
            ib += 1
        elsif ib >= n
            c[i] = a[ia]
            ia += 1
        elsif a[ia] < a[ib]
            c[i] = a[ia]
            ia += 1
        else
            c[i] = a[ib]
            ib += 1
        end
    end
    for i in 0..c.length-1
        a[l+i] = c[i]
    end
end
