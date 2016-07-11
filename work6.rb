class Bintree
    attr_accessor :data, :key, :count
    def initialize(key, data)
        @key = key
        @data = data
        @count = 0
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
            @count += 1
            if @left == nil
                @left = Bintree.new(e, d)
            else
                @left.insert(e, d)
            end
        else
            if e > @key
                @count += 1
                if @right == nil
                    @right = Bintree.new(e, d)
                else
                    @right.insert(e, d)
                end
            end
        end
    end
end

# 課題１
class Bintree
    def search_maxkey(e)
        if e < @key
            if @left == nil
                return nil
            else
                return @left.search_maxkey(e)
            end
        elsif e > @key
            if @right == nil
                return @key
            elsif @right.key <= e
                return @right.search_maxkey(e)
            else
                return @key
            end
        else
            return self.key
        end
    end
end

def work1
    s1 = Bintree.new(3, "")
    s1.insert(5,""); s1.insert(8,"")
    s2 = Bintree.new(5, "")
    s2.insert(3,""); s2.insert(8,"")
    s3 = Bintree.new(8, "")
    s3.insert(5,""); s3.insert(3,"")

    p "result---"
    print "3,5,8: 9=",s1.search_maxkey(9)," 8=",s1.search_maxkey(8),
            " 7=",s1.search_maxkey(7)," 6=",s1.search_maxkey(6)," 5=",s1.search_maxkey(5),
            " 4=",s1.search_maxkey(4)," 3=",s1.search_maxkey(3)," 2=",s1.search_maxkey(2),
            " 1=",s1.search_maxkey(1),"\n"

    print "5,3,8: 9=",s2.search_maxkey(9)," 8=",s2.search_maxkey(8),
            " 7=",s2.search_maxkey(7)," 6=",s2.search_maxkey(6)," 5=",s2.search_maxkey(5),
            " 4=",s2.search_maxkey(4)," 3=",s2.search_maxkey(3)," 2=",s2.search_maxkey(2),
            " 1=",s2.search_maxkey(1),"\n"

    print "8,5,3: 9=",s3.search_maxkey(9)," 8=",s3.search_maxkey(8),
            " 7=",s3.search_maxkey(7)," 6=",s3.search_maxkey(6)," 5=",s3.search_maxkey(5),
            " 4=",s3.search_maxkey(4)," 3=",s3.search_maxkey(3)," 2=",s3.search_maxkey(2),
            " 1=",s3.search_maxkey(1),"\n"
end

# "result---"
# 3,5,8: 9=8 8=8 7=5 6=5 5=5 4=3 3=3 2= 1=
# 5,3,8: 9=8 8=8 7=5 6=5 5=5 4=3 3=3 2= 1=
# 8,5,3: 9=8 8=8 7=5 6=5 5=5 4=3 3=3 2= 1=

# 課題２
# 3.この時YとXの親はYとXの中間値になるはずだがこれは直前の値の定義に反する。よってありえない。
# 4.YをinsertしたのちにXをinsertすればすべてこの関係になる
# 1.Yの左の子はXよりも小さく、Yよりも小さければよい。しかしBintreeは根から下にのびるように挿入されるのでこのような挿入方法は存在しない
# 2.Xを入力したのち、Yよりも小さい値を挿入してから任意のタイミングでYを挿入すればこのようになる

# 課題３
class Bintree
    def search_maxkey2(e)
        if e <= @key
            if @left == nil
                return nil
            else
                return @left.search_maxkey2(e)
            end
        elsif e > @key
            if @right == nil
                return @key
            elsif @right.key < e
                return @right.search_maxkey2(e)
            else
                return @key
            end
        end
    end
end

def work3
    s1 = Bintree.new(3, "")
    s1.insert(5,""); s1.insert(8,"")
    s2 = Bintree.new(5, "")
    s2.insert(3,""); s2.insert(8,"")
    s3 = Bintree.new(8, "")
    s3.insert(5,""); s3.insert(3,"")

    p "result---"
    print "3,5,8: 9=",s1.search_maxkey2(9)," 8=",s1.search_maxkey2(8),
            " 7=",s1.search_maxkey2(7)," 6=",s1.search_maxkey2(6)," 5=",s1.search_maxkey2(5),
            " 4=",s1.search_maxkey2(4)," 3=",s1.search_maxkey2(3)," 2=",s1.search_maxkey2(2),
            " 1=",s1.search_maxkey2(1),"\n"

    print "5,3,8: 9=",s2.search_maxkey2(9)," 8=",s2.search_maxkey2(8),
            " 7=",s2.search_maxkey2(7)," 6=",s2.search_maxkey2(6)," 5=",s2.search_maxkey2(5),
            " 4=",s2.search_maxkey2(4)," 3=",s2.search_maxkey2(3)," 2=",s2.search_maxkey2(2),
            " 1=",s2.search_maxkey2(1),"\n"

    print "8,5,3: 9=",s3.search_maxkey2(9)," 8=",s3.search_maxkey2(8),
            " 7=",s3.search_maxkey2(7)," 6=",s3.search_maxkey2(6)," 5=",s3.search_maxkey2(5),
            " 4=",s3.search_maxkey2(4)," 3=",s3.search_maxkey2(3)," 2=",s3.search_maxkey2(2),
            " 1=",s3.search_maxkey2(1),"\n"
end

# "result---"
# 3,5,8: 9=8 8=5 7=5 6=5 5=3 4=3 3= 2= 1=
# 5,3,8: 9=8 8=5 7=5 6=5 5=3 4=3 3= 2= 1=
# 8,5,3: 9=8 8=5 7=5 6=5 5=3 4=3 3= 2= 1=

# 課題４
class Bintree
    def nth(n)
        if @left == nil
            if n == 1
                return self
            else
                if @right == nil
                    return nil
                else
                    return @right.nth(n-1)
                end
            end
        else
            if n-1 == @left.count+1
                return self
            elsif n > @left.count+1
                if @right == nil
                    return nil
                else
                    return @right.nth(n-@left.count-2)
                end
            else
                return @left.nth(n)
            end
        end
    end
end

def work4
    root = Bintree.new(5,"")
    root.insert(3,""); root.insert(9,""); root.insert(7,"")
    print "1st: ",root.nth(1)," key=",root.nth(1).key,"\n"
    print "3rd: ",root.nth(3)," key=",root.nth(3).key,"\n"
end

# 実行結果
# 1st: #<Bintree:0x007fed72102d38> key=3
# 3rd: #<Bintree:0x007fed72102c98> key=7

# 課題５
class Bintree
    def searchRng(s, t, res)
        if @key >= s && @key <= t
            res<<self
        end
        if @left != nil
            res = @left.searchRng(s, t, res)
        end
        if @right != nil
            res = @right.searchRng(s, t, res)
        end
        return res
    end
end

def work5
    root = Bintree.new(5,"")
    root.insert(3,""); root.insert(9,""); root.insert(7,""); root.insert(4,"")
    res = root.searchRng(4,7,Array.new())
    for i in res
        p i.key
    end
end

# 実行結果
# 5
# 4
# 7

# 課題７
# class Avltree
#     attr_accessor :key, :data, :left, :right, :balance
#     def initialize(key, data)
#         @key = key
#         @data = data
#         @left = nil
#         @right = nil
#         @balance = "Even"
#     end
#
#     def search(key)
#         if @key > key
#             if @left == nil
#                 return nil
#             else
#                 return @left.search(key)
#             end
#         end
#         if @key < key
#             if @right == nil
#                 return nil
#             else
#                 return @right.search(key)
#             end
#         end
#         return self
#     end
#
#     def SingleRightRotation
#         tl = @left
#         tl.balance = "Even"
#         @balance = "Even"
#         @left = tl.right
#         tl.right = self
#         return tl
#     end
#
#     def replace(p, b)
#         if p.left == self
#             p.left = b
#         else
#             p.right = b
#         end
#     end
#
#     def DoubleRightRotation
#         tl = @left
#         @left = tl.right.right
#         tl.right.right = self
#         tlr = tl.right
#         tl.right = tlr.left
#         tlr.left = tl
#         case tlr.balance
#         when "Left"
#             tlr.right.balance = "Right"
#             tlr.left.balance = "Even"
#         when "Right"
#             tlr.right.balance = "Even"
#             tlr.left.balance = "Left"
#         when "Even"
#             tlr.right.balance = "Even"
#             tlr.left.balance = "Even"
#         end
#         tlr.balance = "Even"
#         return tlr
#     end
#
#     def insertx(p, key, data)
#         if @key > key
#             if @left == nil
#                 @left = Avltree.new(key, data)
#             else
#                 if not @left.insertx(self, key, data)
#                     return false
#                 end
#             end
#             case @balance
#             when "Right"
#                 @balance = "Even"
#             when "Even"
#                 @balance = "Left"
#                 return true
#             when "Left"
#                 case @left.balance
#                 when "Right"
#                     replace(p, DoubleRightRotation())
#                 when "Even"
#                 when "Left"
#                     replace(p, SingleRightRotation())
#                 end
#             end
#             return false
#         elsif @key < key
#
#         end
#     end
# end
