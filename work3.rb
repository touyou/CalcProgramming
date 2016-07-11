load "pg10.rb"
@pg10s = pg10.sort
# 課題１
def find(t, s)
    i = 0; j = t.length-1
    while i<=j
        k=(i+j)/2
        if t[k]==s
            return k
        elsif t[k] < s
            i = k+1
        else
            j = k-1
        end
    end
    return nil
end
def work1(w)
    oldTime = Time.now
    ans = @pg10s.index(w)
    print "linear search: ",Time.now-oldTime," (answer: ",ans,")","\n"
    oldTime = Time.now
    ans = find(@pg10s, w)
    print "binary search: ",Time.now-oldTime," (answer: ",ans,")","\n"
end
# 結果
# work1("of")
# linear search: 0.019763 (answer: 439663)
# binary search: 1.7e-05 (answer: 446059)
# 考察: 実行速度に関してはオーダー通りの結果になった。答えが違うのは"of"がpg10の中に複数個あるためだと考えられる
# work1("James")
# linear search: 0.002888 (answer: 54037)
# binary search: 8.0e-06 (answer: 54061)
# work1("EBook")
# linear search: 0.001506 (answer: 26043)
# binary search: 1.7e-05 (answer: 26043)
# 考察: binaryは検索語に対してあまり実行時間が変わらないのに対してlinearは検索語の配列内の位置に左右されてることがわかった

# 課題２
# SystemStackError: stack level too deep
def mergesortuniq(a)
    n = a.length()
    if n == 1
        return a
    else
        a1 = mergesortuniq(a[0..n/2-1])
        a2 = mergesortuniq(a[n/2..n-1])
        merge(a1, a2)
    end
end
def merge(a, b)
    return b if a.length==0
    return a if b.length==0
    if a[0] < b[0]
        [a[0]] + merge(a[1..-1], b)
    elsif a[0] > b[0]
        [b[0]] + merge(a, b[1..-1])
    else
        [a[0]] + merge(a[1..-1], b[1..-1])
    end
end
def unique(a)
    ret = [a[0]]
    bef = a[0]
    for i in 1..a.length-1
        if bef != a[i]
            bef = a[i]
            ret << bef
        end
    end
    return ret
end
def work2
    oldTime = Time.now
    # res = mergesortuniq(pg10)
    res = unique(@pg10s)
    print "Time: ",Time.now-oldTime,"\n"
    p res == @pg10s.uniq
end
# 結果
# Time: 0.101257
# true

# 課題３
# 2分探索しながら求める
# def work3func(array, x, eps)
#     array.sort!
#     l = 0; r = array.length-1
#     while r>l
#         k=(l+r)/2
#         if array[k] <= x
#             l = k
#         else
#             r = k-1
#         end
#     end
#     print "nearest: ", l, " (",array[l],")","\n"
#     i = l-1; reta = [l]
#     reta << i while i >= 0 and array[i] >= x-eps and array[i] <= x+eps
#     i = l+1
#     reta << i while i < array.length and array[i] >= x-eps and array[i] <= x+eps
#     print "near: ", reta.sort, "\n"
# end
# def work3
#     n = 1000; a = Array.new; rd = Random.new(1000)
#     for i in 0..n-1
#         a[i] = rd.rand()
#     end
#     work3func(a, 0.4, 0.005)
# end
# 結果

# 課題４
# def work4(head)
#     words = []
#     f = open("/usr/share/dict/words")
#     while line = f.gets
#         words << line.chomp
#     end
#     f.close
#     words.sort!
#     oldTime = Time.now
#     res = nil
#     l = 0; r = words.length - 1
#     while l<r
#         c = (l+r)/2
#         if words[c][0..head.length-1]==head
#             r = c
#         elsif words[c] > head
#             r = c - 1
#         else
#             l = c + 1
#         end
#     end
#     if l == r
#         while l < words.length and words[c][0..head.length-1]==head
#             print words[l], " "
#             l += 1
#         end
#         puts ""
#     else
#         p "not found"
#     end
#     print "TIME: ", Time.now-oldTime, "\n"
# end
