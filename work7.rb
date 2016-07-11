class Heap
    attr_reader :a
    def initialize(a)
        @a = a
        @size = a.length
    end

    def parent(i)
        return (i-1)/2
    end

    def left(i)
        return 2*i+1
    end

    def right(i)
        return 2*i+2
    end
end

class Heap
    def MakeHeap(i)
        l = left(i)
        r = right(i)
        largest = i
        if l < @size and @a[l] > @a[largest]
            largest = l
        end
        if r < @size and @a[r] > @a[largest]
            largest = r
        end
        if largest != i
            @a[i], @a[largest] = @a[largest], @a[i]
            MakeHeap(largest)
        end
    end

    def BuildHeap()
        i = @size / 2 - 1
        while i >= 0
            MakeHeap(i)
            i -= 1
        end
    end

    def HeapSort()
        BuildHeap()
        while @size >= 2
            @a[0], @a[@size-1] = @a[@size-1], @a[0]
            @size -= 1
            MakeHeap(0)
        end
    end

    def enq(d)
        @a[@size] = d
        @size += 1
        HeapUp(@size-1)
    end

    def HeapUp(i)
        if i > 0
            if @a[parent(i)] < @a[i]
                @a[parent(i)], @a[i] = @a[i], @a[parent(i)]
                HeapUp(parent(i))
            end
        end
    end

    def deq()
        if @size <= 0
            return nil
        end
        max = @a[0]
        @size -= 1
        @a[0] = @a[@size]
        MakeHeap(0)
        return max
    end
end


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
    c = Array.new(n-l)
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


# 課題１
def work1(a)
    oldTime = Time.now
    simplesort(a.clone)
    sT = Time.now - oldTime
    oldTime = Time.now
    mergesort(a.clone)
    mT = Time.now - oldTime
    h = Heap.new(a)
    oldTime = Time.now
    h.HeapSort()
    hT = Time.now - oldTime
    p sT
    p mT
    p hT
end

# サイズ100000のランダムな数列で
# 単純整列が297.85447sec,マージソートが0.370356sec,ヒープソートが0.470932sec
# オーダーがこの順にO(N^2),O(N log N),O(N log N)なので実行時間はたしかにオーダーの大小に一致している。

# 課題２
# 左右の木がヒープ木である時、親とそのどちらかの根を交換することによって交換された方ではない木はヒープ木のままである。すなわち交換を一回行ったのちにヒープ木でないのは交換をおこなった子供の部分木である。
# この操作を繰り返すと最終的に最小単位の部分木に辿り着き、すなわち交換される部分木がノード一個の木であるところまで繰り返せば交換された後もそのノード一個の木もヒープ木なので結果全体としてヒープ木になる

# 課題３
# ヒープ木の定義から末尾に追加した時末尾を除いた部分はヒープ木になっているはずである。HeapUp()は追加した末尾に行う操作であり操作されるのは追加された要素との親子関係が逆転している部分のみ
# ヒープ木がなりたっているから交換される親のもう一方の子は必ず親の値より小さい、すなわち逆転している子よりも小さいので交換したときその下の部分木はヒープ木となる

# 課題４
class Heap
    def HeapDecreaseKey(i,value)
        if value > @a[i]
            return "new value must be smaller"
        else
            @a[i] = value
            while i > 0 && @a[parent(i)] < @a[i]
                @a[parent(i)], @a[i] = @a[i], @a[parent(i)]
                i = parent(i)
            end
        end
    end
end

# 課題５
class Heap
    def delete(i)
        @a[i], @a[@size-1] = @a[@size-1], @a[i]
        deq()
    end
end

# 課題６
class Heap
    def search(i, value)
        l = left(i)
        r = right(i)
        if @a[i] == value
            return i
        end
        ret = -1
        if l < @size && @a[l] >= value
            ret = search(l, value)
        end
        if r < @size && @a[r] >= value
            ret = search(r, value)
        end
        return ret
    end
end
