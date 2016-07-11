# postorder         inorder
# ((2 3 +) 4 -)     (2 + 3) - 4
# (2 (3 4 -) +)     2 + (3 - 4)

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
            else
                return "error"
            end
        end
    end
end
