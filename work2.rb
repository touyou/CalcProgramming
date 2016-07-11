def simplesort(a)
    for i in 0 .. (a.length-1)
        k = i
        for j in i+1 .. (a.length-1)
            if a[j] < a[k]
                k = j
            end
        end
        v = a[i]
        a[i] = a[k]
        a[k] = v
    end
    return a
end

def mergesort(a)
    mergesortSub(a, 0, a.length)
end

def mergesortSub(a, l, r)
    if r > l+1
        m = (l + r) / 2
        mergesortSub(a, l, m)
        mergesortSub(a, m, r)
        merge2(a, l, m, r)
    end
    return a
end

def merge2(a, l, m, n)
    c = Array.new(n-l)
    ia = l
    ib = m
    for i in 0..c.length-1
        if ia >= m
            c[i] = a[ib]
            ib += 1
        elsif ib >= n
            c[i] = a[ia]
            ia += 1
        elsif a[ia] < a[ib]
            c[i] = a[ia]
            ia += 1
        else
            c[i] = a[ib]
            ib += 1
        end
    end
    for i in 0..c.length-1
        a[l+i] = c[i]
    end
end


load "pg10.rb"
# 課題１
def work1(a)
    p Time.now
    simplesort(a.clone)
    p Time.now
    mergesort(a.clone)
    p Time.now
end

# 実行結果(pg10のサイズは792996)
# simplesortは遅すぎるので断念
# pg10ろくにソートできないから断念
# size10000のランダムな配列で
# 2016-04-18 18:41:27 +0900
# 2016-04-18 18:41:30 +0900
# 2016-04-18 18:41:30 +0900
# 3sec(O(n^2))と0sec(O(nlogn))という違いが出た。

# 課題２
def mergesort2(a)
    mergesortSub2(a, 0, a.length)
end
def mergesortSub2(a, l, r)
    if r > l+1
        m = (l + r) / 2
        mergesortSub2(a, l, m)
        mergesortSub2(a, m, r)
        merge3(a, l, m, r)
    end
    return a
end
def merge3(a, l, m, n)
    c = Array.new(n-l)
    ia = l
    ib = m
    for i in 0..c.length-1
        if ia >= m
            c[i] = a[ib]
            ib += 1
        elsif ib >= n
            c[i] = a[ia]
            ia += 1
        elsif a[ia][0] < a[ib][0] or (a[ia][0] == a[ib][0] and a[ia][1] < a[ib][1])
            c[i] = a[ia]
            ia += 1
        else
            c[i] = a[ib]
            ib += 1
        end
    end
    for i in 0..c.length-1
        a[l+i] = c[i]
    end
end
load "loc.rb"
def work2
    loc.sort == mergesort2(loc)
end

# 実行結果 true
# 実装はmergesortの条件部分のみを変えてみた

# 課題３
# def nibu(num, array)
#     l = 0
#     r = array.length-1
#     while r - l > 1
#         m = (l + r) / 2
#         if array[m] <= num
#             l = m
#         else
#             r = m
#         end
#     end
#     return l
# end
# def work3(a)
#     unsort = a.clone
#     sorted = a.sort
#     ans = Array.new(a.length)
#     for i in 0 .. a.length-1
#         ans[i] = nibu(unsort[i], sorted)
#     end
#     p ans
# end
#
# # 方針
# # 単純に追っていくのは面倒だったのでsort済みのものとその前のものを用意して2分探索して行き先を探した
# # O(n log n)
# # 実行結果
# #
