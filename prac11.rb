class Dijkstra
    attr_accessor :list, :d, :prev
    def initialize(fname)
        f = open(fname)
        size = f.gets.to_i
        @list = Array.new(size)
        @d = Array.new(size, Float::INFINITY)
        @prev = Array.new(size)
        while (s = f.gets) != nil
            d1, d2, w = s.split(/ /)
            connect(d1.to_i, d2.to_i, w.to_i)
        end
        f.close
    end
    def connect(x, y, w)
        if t = @list[x]
            for i in 0..t.length-1
                if t[i].id == y
                    return
                end
            end
        else
            @list[x] = Array.new
        end
        @list[x] << IdWeight.new(y,w)
    end
end
class IdWeight
    attr_accessor :id, :weight
    def initialize(id, weight)
        @id = id
        @weight = weight
    end
end
class Dijkstra
    def trav(s)
        @d[s] = 0
        @pq = PriorityQueue.new()
        @pq.enq(s,0)
        while u = @pq.deq()
            if t = @list[u]
                for i in 0..t.length-1
                    v = t[i].id
                    weight = t[i].weight
                    print "update ",u,"->",v," before weight=",@d[v],"\n"
                    if @d[v] > @d[u]+weight
                        @d[v] = @d[u]+weight
                        print "update ",u,"->",v," after weight=",@d[v],"\n"
                        @pq.enq(v,@d[v])
                        @prev[v] = u
                    end
                end
            end
        end
    end
    def pans
        for i in 0..@d.length-1
            print i, " d=",@d[i],"\n"
        end
    end
end
class PriorityQueue
    attr_accessor :size, :a
    def initialize()
        @a = Array.new
        @size = 0
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
    def MakeHeap(i)
        l = left(i)
        r = right(i)
        largest = i
        if l < @size and @a[l].weight < @a[largest].weight
            largest = l
        end
        if r < @size and @a[r].weight < @a[largest].weight
            largest = r
        end
        if largest != i
            @a[i], @a[largest] = @a[largest], @a[i]
            MakeHeap(largest)
        end
    end
    def enq(d,w)
        if i = find(d)
            if w > @a[i].weight
                return "new value must be smaller"
            else
                @a[i].weight = w
                HeapUp(i)
            end
        else
            @a[@size] = IdWeight.new(d,w)
            @size += 1
            HeapUp(@size-1)
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
        return max.id
    end
    def HeapUp(i)
        if i > 0
            if @a[parent(i)].weight > @a[i].weight
                @a[parent(i)], @a[i] = @a[i], @a[parent(i)]
                HeapUp(parent(i))
            end
        end
    end
    def find(d)
        for i in 0..@size-1
            if @a[i].id == d
                return i
            end
        end
        return nil
    end
end

def test
    h = PriorityQueue.new()
    h.enq(4,10)
    h.enq(2,3)
    h.enq(7,5)
    h.enq(8,3)
    h.enq(4,4)
    while t=h.deq()
        p t
    end
end

class Graph
    attr_accessor :adjMatrix
    def initialize(fname)
        f = open(fname)
        size = f.gets.to_i
        @adjMatrix = Array.new(size)
        for i in 0..size-1
            @adjMatrix[i] = Array.new(size+1, Float::INFINITY)
            @adjMatrix[i][i] = 0
        end
        while (s = f.gets) != nil
            d1, d2, w = s.split(/ /)
            connect1(d1.to_i,d2.to_i,w.to_i)
        end
        f.close
    end
    def connect1(x,y,w)
        @adjMatrix[x][y] = w
    end

    def floyd()
        size = @adjMatrix.length
        d = copy(@adjMatrix)
        pi = Array.new(size)
        for i in 0..size-1
            pi[i] = Array.new(size)
            for j in 0..size-1
                if d[i][j] != Float::INFINITY
                    pi[i][j] = i
                end
            end
        end
        for k in 0..size-1
            newd = copy(d)
            newpi = copy(pi)
            for i in 0..size-1
                for j in 0..size-1
                    if d[i][j] > d[i][k]+d[k][j]
                        newd[i][j] = d[i][k]+d[k][j]
                        newpi[i][j] = pi[k][j]
                    end
                end
            end
            d = newd
            pi = newpi
        end
        return [d,pi]
    end
end
def copy(a)
    size = a.length
    d = Array.new(size)
    for i in 0..size-1
        d[i] = Array.new(size)
        for j in 0..size-1
            d[i][j] = a[i][j]
        end
    end
    return d
end
