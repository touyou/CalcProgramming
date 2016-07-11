require 'set'
def test
    s = SortedSet.new()
    s.add("c")
    s.add("a")
    s.add("b")
    t = SortedSet.new(["d","c","b"])
    p s
    p t
    p s+t
    p s-t
    p s&t
end

# 練習１　O(N)

class H
    attr_reader :x,:y
    def initialize(x,y)
        @x = x
        @y = y
    end
    def <=>(anOther)
        if @x == anOther.x
            return @y <=> anOther.y
        else
            return @x <=> anOther.x
        end
    end
    def eql?(anOther)
        return (self <=> anOther) == 0
    end
    def hash()
        return @x.hash() + 13 * @y.hash()
    end
end

def test2
    s = SortedSet.new()
    s.add(H.new(2,1))
    s.add(H.new(1,2))
    s.add(H.new(2,1))
end

# 練習３
# 1. 集合に入っているか？→f[object] != nilでO(1)
# 2. ハッシュリストを走査してnilでないものを表示→O(max-min)
# 3. O(1) 4. O(1)?

def findPrime(size)
    v = 0
    for i in 2..size-1
        if (v&(1<<i)) == 0
            print i,"\n"
            j = 2*i
            while j < size
                v |= 1<<j
                j += i
            end
        end
    end
end

# 練習5
def findPrimeSet(size)
    v = SortedSet.new(2..size-1)
    v.each do |n|
        i = n * 2
        while i < size
            v.delete(i)
            i += n
        end
    end
end

class UnionFind
    def initialize()
        @parent = Array.new
    end
    def checkSize(i)
        size = @parent.length
        for j in size..i
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
    def sameComponent(i,j)
        return findSet(i) == findSet(j)
    end
    def union(i,j)
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
        for i in 0..@parent.length-1
            p = findSet(i)
            if setOfSets[p] == nil
                setOfSets[p] = Array.new
            end
            setOfSets[p] << i
        end
        result = Array.new
        for i in 0..setOfSets.length-1
            if setOfSets[i] != nil
                result << setOfSets[i]
            end
        end
        return result
    end
end

# 練習6 ... 低いほうの木のrootが高い方の木のrootの親になるようにunionして行った時

# 練習7 ... pivotの値と他の要素はすべて等しいのでif @a[j]<= xは常に実行される。よってpartition(p,r)の返り値は常にrに等しくなる。quickSort(r+1,r)は実行されても常になにもせず、quickSort(p,r-1)のrが次第にpに近づいていくので結局このquickSortは終了すると言える

# 練習8
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
