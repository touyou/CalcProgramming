class Graph
    attr_reader :prev, :list
    def initialize(fname)
        f = open(fname)
        size = f.gets.to_i
        @list = Array.new(size+1)
        @prev = Array.new(size+1)
        while (s = f.gets) != nil
            d1, d2 = s.split(/ /)
            connect1(d1.to_i,d2.to_i)
        end
        f.close
    end
    def connect(x, y)
        connect1(x, y)
        connect1(y, x)
    end
    def connect1(x, y)
        t = @list[x]
        if t == nil
            @list[x] = [y]
        else
            if t.index(y) == nil
                t << y
            end
        end
    end
    def to_s
        s = ""
        for i in 0..@list.length-1
            if (t = @list[i]) != nil
                for j in 0..t.length-1
                    s += i.to_s+" "+t[j].to_s+"\n"
                end
            end
        end
        return s
    end

    def travx(from, to)
        q =Array.new
        d = from
        while d != nil and d != to
            if t = @list[d]
                for i in 0..t.length-1
                    if @prev[t[i]] == nil
                        @prev[t[i]] = d
                        q << t[i]
                    end
                end
            end
            d = q.shift
        end
        if d == to
            trace(to, from)
        end
    end
    def trace(to, from)
        i = to
        while i != from
            print i, " "
            i = @prev[i]
        end
        print from, "\n"
    end
end

g = Graph.new("graph.dat")
g.travx(1, 16)

g2 = Graph.new("graphx.dat")
g2.travx(1, 16)

# 実行結果は以下
# 16 15 14 13 9 5 1
# 16 15 14 13 9 5 1
# 有向グラフの場合、入力順に関わらずグラフの表現は一意になるので探索した時上のように入力順に関わらず同じ経路を出す
