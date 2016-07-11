class Node
    attr_accessor :op, :left, :right
    def initialize(op, left=nil, right=nil)
        @op = op
        @left = left
        @right = right
    end
end

class Node
    def inorder
        if self.left == nil
            return self.op.to_s
        else
            return "(" + self.left.inorder + self.op + self.right.inorder + ")"
        end
    end

    def preorder
        if self.left == nil
            return self.op.to_s
        else
            return self.op + "(" + self.left.preorder + "," + self.right.preorder + ")"
        end
    end

    def postorder
        if self.left == nil
            return self.op.to_s
        else
            return self.left.postorder + " " + self.right.postorder + self.ope
        end
    end

    def value
        if @left == nil
            return @op
        else
            l = @left.value
            r = @right.value
            case @op
            when "+"
                return l + r
            when "-"
                return l - r
            when "*"
                return l * r
            when "/"
                return l / r
            # 課題１
            when "^"
                return l ** r
            else
                return "error"
            end
        end
    end

    # 課題２
    def replaceConstant(c1, c2)
        if @op === c1
            @op = c2
        end
        if @left == nil
            return [@op.to_s, @op]
        else
            l = @left.replaceConstant(c1, c2)
            r = @right.replaceConstant(c1, c2)
            ret = ["("+l[0]+@op+r[0]+")", 0]
            case @op
            when "+"
                ret[1] = l[1] + r[1]
            when "-"
                ret[1] = l[1] - r[1]
            when "*"
                ret[1] = l[1] * r[1]
            when "/"
                ret[1] = l[1] / r[1]
            when "^"
                ret[1] = l[1] ** r[1]
            else
                return "error"
            end
            return ret
        end
    end

    # 課題６
    def same(y)
        if @left == nil
            return @op === y.op
        else
            return @left.same(y.left) && @op === y.op && @right.same(y.right)
        end
    end

    def copy
        if @left == nil
            return Node.new(self.op)
        else
            return Node.new(self.op, self.left.copy, self.right.copy)
        end
    end
# テスト
# irb(main):046:0> load "work4.rb"
# => true
# irb(main):047:0> x = Node.new("+", Node.new("+", Node.new(9), Node.new(2)), Node.new(3))
# => #<Node:0x007fed1b023a40 @op="+", @left=#<Node:0x007fed1b023a90 @op="+", @left=#<Node:0x007fed1b023ae0 @op=9, @left=nil, @right=nil>, @right=#<Node:0x007fed1b023ab8 @op=2, @left=nil, @right=nil>>, @right=#<Node:0x007fed1b023a68 @op=3, @left=nil, @right=nil>>
# irb(main):048:0> y = x.copy
# => #<Node:0x007fed1b80c108 @op="+", @left=#<Node:0x007fed1b80c158 @op="+", @left=#<Node:0x007fed1b80c1a8 @op=9, @left=nil, @right=nil>, @right=#<Node:0x007fed1b80c180 @op=2, @left=nil, @right=nil>>, @right=#<Node:0x007fed1b80c130 @op=3, @left=nil, @right=nil>>
# irb(main):049:0> x.same(y)
# => true
# irb(main):050:0> x.replaceConstant(9, 2)
# => ["((2+2)+3)", 7]
# irb(main):051:0> [y.inorder, y.value]
# => ["((9+2)+3)", 14]

    # 課題７
    def replaceNode(t1, t2, t3)
        if @left == nil
            if @op.same(t2)
                @op = t3.copy
            end
        else
            if @left.same(t2)
                @left = t3.copy
            end
            # if @op.same(t2)
            #     @op = t3.copy
            # end
            if @right.same(t2)
                @right = t3.copy
            end
        end
    end
end

# 課題３
@ope = ["+", "-", "*", "/"]
@eps = 10**(-100)
def work3
    for o1 in @ope do
        for o2 in @ope do
            for o3 in @ope do
                node = Node.new(o1,
                            Node.new(o2,
                                Node.new(1.0),
                                Node.new(o3,
                                    Node.new(1.0),
                                    Node.new(9.0)
                                )
                            ),
                            Node.new(9.0)
                        )
                if node.value >= 10-@eps and node.value <= 10+@eps
                    print node.inorder
                end
            end
        end
    end
end

# 課題５
def find(t1, t2)
    if t1.left == nil
        if t1.ope == t2
            p "find"
        end
    else
        if t1.left == t2
            p "find"
        else
            find(t1.left, t2)
        end
        if t1.right == t2
            p "find"
        else
            find(t1.right, t2)
        end
    end
end

def work5
    t2 = Node.new("+", 2, 3)
    t1 = Node.new("*", t2, t2)
    find(t1, t2)
end

# 結果
# irb(main):010:0> work5
# "find"
# "find"
# => "find"
