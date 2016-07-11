class Graph
    def initialize(fname)
        f = open(fname)
        size = f.gets.to_i
        @list = Array.new(size+1)
        while (s = f.gets) != nil
            d1, d2 = s.split(/ /)
            connect1(d1.to_i, d2.to_i)
        end
        f.close
    end
end
