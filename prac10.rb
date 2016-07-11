class Graph
    attr_accessor :adjMatrix, :prev
    def initialize(fname)
        f = open(fname)
        size = f.gets.to_i
        @adjMatrix = Array.new(size+1)
        for i in 0 .. size
            @adjMatrix[i] = Array.new(size+1, 0)
        end
        @prev = Array.new(size+1)
        while (s = f.gets) != nil
            d1, d2 = s.split(/ /)
            connect1(d1.to_i, d2.to_i)
        end
        f.close
    end
    def connect1(x, y)
        @adjMatrix[x][y] = 1
    end
    def connected(x, y)
        return @adjMatrix[x][y] == 1
    end
end

class Graph
    def travx(from, d, to)
        if d == to
            # trace(to, from)
            return
        end
        for i in 0 .. @adjMatrix.length - 1
            if connected(d, i) and @prev[i] == nil
                @prev[i] = d
                travx(from, i, to)
            end
        end
    end
end

class Graph
    def multiply(a, b)
        c = Array.new(a.length)
        for i in 0 .. a.length-1
            c[i] = Array.new(b[0].length)
            for j in 0 .. b[0].length-1
                c[i][j] = 0
                for k in 0 .. a[0].length-1
                    c[i][j] += a[i][k] * b[k][j]
                end
            end
        end
        return c
    end

    def plus(a, b)
        c = Array.new(a.length)
        for i in 0 .. a.length-1
            c[i] = Array.new(b[0].length)
            for j in 0 .. b[0].length-1
                c[i][j] = a[i][j] + b[i][j]
            end
        end
        return c
    end

    def power(n)
        c = @adjMatrix
        b = c.clone
        for l in 2 .. n
            c = multiply(c, @adjMatrix)
            b = plus(b, c)
        end
        return b
    end
end

# 練習２
# power(10)で
# [0, 0, 0, 0, 0, 0, 0]
# [0, 0, 0, 0, 0, 0, 0]
# [0, 0, 0, 0, 0, 0, 0]
# [0, 0, 5, 5, 0, 0, 5]
# [0, 1, 4, 5, 0, 1, 4]
# [0, 1, 4, 5, 0, 0, 5]
# [0, 0, 5, 5, 0, 0, 5]
# より、頂点３と頂点６が循環している

class Graph
    def hits
        a = Array.new(@adjMatrix.length, 0.0)
        h = Array.new(@adjMatrix.length, 0.0)
        # 入次数
        for i in 0 .. a.length-1
            for j in 0 .. a.length-1
                a[i] += @adjMatrix[j][i]
            end
        end
        # hubの計算１
        for i in 0 .. h.length-1
            for j in 0 .. h.length-1
                if connected(i, j)
                    h[i] += a[j]
                end
            end
        end
        # authorityの計算
        for i in 0 .. a.length-1
            a[i] = 0
            for j in 0 .. a.length-1
                if connected(j, i)
                    a[i] += h[j]
                end
            end
        end
        # 正規化
        a_sum = a.reduce(:+)
        h_sum = h.reduce(:+)
        for i in 0 .. a.length-1
            a[i] /= a_sum
            h[i] /= h_sum
        end
        a.each do |y| p y end
        p "----"
        h.each do |y| p y end
    end
end

# 練習３
# 0.0
# 0.058823529411764705
# 0.17647058823529413
# 0.35294117647058826
# 0.4117647058823529
# "----"
# 0.0
# 0.3
# 0.4
# 0.1
# 0.2
# ３、４はauthorityが高く、１、２はhubが高いので確かに確かめられた
