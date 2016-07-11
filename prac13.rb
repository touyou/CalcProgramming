class UnionFind
    def initialize()
        @parent = Array.new
    end

    def checkSize(i)
        size = @parent.length
        for j in size .. i
            @parent[j] = j
        end
    end

    def findSet(i)
        checkSize(i)
        if i != @parent[i]
            @parent[i] = findSet(@parent[i])
        end
        return @parent[i]
    end

    def sameComponent(i, j)
        return findSet(i) == findSet(j)
    end

    def union(i, j)
        ip = findSet(i)
        jp = findSet(j)
        if ip != jp
            @parent[ip] = jp
        end
    end
end

class UnionFind
    def toSet()
        setOfSets = Array.new
        for i in 0 .. @parent.length-1
            p = findSet(i)
            if setOfSets[p] = Array.new
                setOfSets[p] = Array.new
            end
            setOfSets[p] << i
        end
        result = Array.new
        for i in 0 .. setOfSets.length - 1
            if setOfSets[i] != nil
                result << setOfSets[i]
            end
        end
        return result
    end
end

# 練習2 ... 低いほうの木のrootが高い方の木のrootの親になるようにunionして行った時

class Graph
    def connectedComponent(u)
        for i in 0 .. @adjMatrix.length-1
            for j in 0 .. @adjMatrix[0].length-1
                if @adjMatrix[i][j] > 0
                    u.union(i,j)
                end
            end
        end
    end
end
def test1
    g = Graph.new("graph100.dat")
    u = UnionFind.new()
    g.connectedComponent(u)
    p u.toSet()
end

class Dijkstra
    def weightOrder()
        a = Array.new
        for i in 0 .. @list.length-1
            if t = @list[i]
                for j in 0 .. t.length-1
                    v = t[j].id
                    w = t[j].weight
                    a << [w,[i,v]]
                end
            end
        end
        return a
    end
end
def kruskal
    g = Dijkstra.new("kruskal.dat")
    a = g.weightOrder()
    QuickSort.new(a)
    u = UnionFind.new()
    size = g.list.length
    j = 0
    for i in 0 .. a.length-1
        x,y = a[i][1]
        if u.findSet(x) != u.findSet(y)
            u.union(x,y)
            print "connect ",x," and ",y,"\n"
            j += 1
            if j >= size-1
                break
            end
        end
    end
end
class QuickSort
    def initialize(a)
        @a = a
        quickSort(0, @a.length-1)
    end
    def quickSort(p,r)
        if p<r
            q = partition(p,r)
            quickSort(p,q-1)
            quickSort(q+1,r)
        end
    end
    def partition(p,r)
        x = @a[r]
        i = p-1
        for j in p..r-1
            if @a[j] <= x
                i += 1
                exchange(i,j)
            end
        end
        exchange(i+1,r)
        return i+1
    end
    def exchange(i,j)
        @a[i],@a[j] = @a[j],@a[i]
    end
end
def test2(a)
    s = QuickSort.new(a)
    print a*",","\n"
end

# 練習4 ... pivotの値と他の要素はすべて等しいのでif @a[j]<= xは常に実行される。よってpartition(p,r)の返り値は常にrに等しくなる。quickSort(r+1,r)は実行されても常になにもせず、quickSort(p,r-1)のrが次第にpに近づいていくので結局このquickSortは終了すると言える

# 練習5
def findNth(a, n)
    ah = Array.new
    al = Array.new
    x = a[0]
    if n == 1
        return x
    end
    for i in 0..a.length-1
        if x > a[i]
            al << a[i]
        else
            ah << a[i]
        end
    end
    if al.length >= n
        return findNth(al, n)
    else
        return findNth(ah, n-al.length)
    end
end

# MARK: Graph
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

# MARK: Dijkstra
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
