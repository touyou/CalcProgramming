class Bintree
    attr_accessor :data
    def initialize(key, data)
        @key = key
        @data = data
        @left = nil
        @right = nil
    end

    def search(e)
        if e < @key
            if @left == nil
                return nil
            else
                return @left.search(e)
            end
        else
            if e > @key
                if @right == nil
                    return nil
                else
                    return @right.search(e)
                end
            else
                return self
            end
        end
    end
end

class Bintree
    def insert(e, d)
        if e < @key
            if @left == nil
                @left = Bintree.new(e, d)
            else
                @left.insert(e, d)
            end
        else
            if e > @key
                if @right == nil
                    @right = Bintree.new(e, d)
                else
                    @right.insert(e, d)
                end
            end
        end
    end
end

def test
    root = Bintree.new(0, "dummy")
    while true
        print "key="
        line = gets
        if line == nil
            break
        else
            a = line.to_i
            if a > 0
                print "data="
                line = gets
                if line != nil
                    root.insert(a, line.chomp)
                else
                    print "data must be a word\n"
                end
            else
                if a < 0
                    n = root.search(-a)
                    if n != nil
                        print "data=",n.data,"\n"
                    else
                        print "data for key=",-a," not found\n"
                    end
                else
                    break
                end
            end
        end
    end
end

class Avltree
    attr_accessor :key, :data, :left, :right, :balance
    def initialize(key, data)
        @key = key
        @data = data
        @left = nil
        @right = nil
        @balance = "Even"
    end

    def search(key)
        if @key > key
            if @left == nil
                return nil
            else
                return @left.search(key)
            end
        end
        if @key < key
            if @right == nil
                return nil
            else
                return @right.search(key)
            end
        end
        return self
    end

    def SingleRightRotation
        tl = @left
        tl.balance = "Even"
        @balance = "Even"
        @left = tl.right
        tl.right = self
        return tl
    end

    def replace(p, b)
        if p.left == self
            p.left = b
        else
            p.right = b
        end
    end

    def DoubleRightRotation
        tl = @left
        @left = tl.right.right
        tl.right.right = self
        tlr = tl.right
        tl.right = tlr.left
        tlr.left = tl
        case tlr.balance
        when "Left"
            tlr.right.balance = "Right"
            tlr.left.balance = "Even"
        when "Right"
            tlr.right.balance = "Even"
            tlr.left.balance = "Left"
        when "Even"
            tlr.right.balance = "Even"
            tlr.left.balance = "Even"
        end
        tlr.balance = "Even"
        return tlr
    end

    def insertx(p, key, data)
        if @key > key
            if @left == nil
                @left = Avltree.new(key, data)
            else
                if not @left.insertx(self, key, data)
                    return false
                end
            end
            case @balance
            when "Right"
                @balance = "Even"
            when "Even"
                @balance = "Left"
                return true
            when "Left"
                case @left.balance
                when "Right"
                    replace(p, DoubleRightRotation())
                when "Even"
                when "Left"
                    replace(p, SingleRightRotation())
                end
            end
            return false
        end
    end
end
