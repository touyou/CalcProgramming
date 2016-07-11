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
end

def test
    h = Heap.new([4,8,2,5,1,9])
    h.HeapSort()
    print h.a*",","\n"
end

class Heap
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

    def HeapIncreaseKey(i,value)
        if value < @a[i]
            return "new value must be larger"
        else
            @a[i] = value
            while i > 0 && @a[parent(i)] < @a[i]
                @a[parent(i)], @a[i] = @a[i], @a[parent(i)]
                i = parent(i)
            end
        end
    end
end

def test2
    h = Heap.new([])
    h.enq(4); h.enq(2); h.enq(7)
    h.enq(1); h.enq(3); h.enq(5)
    p h.a[1]
    h.HeapIncreaseKey(1, 6)
    while i = h.deq()
        p i
    end
end
