load "Lines.rb"

# 課題１
def work1
    y = yamanotesen
    s = y.index("品川駅")
    e = y.index("渋谷駅")
    while s != e do
        print y[s], ","
        s = s + 4
        if s >= y.length then
            s = s - y.length
        end
    end
    puts y[e]
end
# 愚直に実装した
# 実行結果-----
# irb(main):007:0> work1
# 品川駅,恵比寿駅,新宿駅,池袋駅,田端駅,上野駅,東京駅,田町駅,目黒駅,代々木駅,目白駅,駒込駅,鶯谷駅,神田駅,浜松町駅,五反田駅,原宿駅,高田馬場駅,巣鴨駅,日暮里駅,秋葉原駅,新橋駅,大崎駅,渋谷駅
# => nil

# 課題２
def work2
    est = denentoshisen
    exp = expressStops
    s = est.index(exp[0])
    ans = []
    for i in 1 .. exp.length - 1 do
        tmp = est.index(exp[i])
        ans << (tmp - s - 1)
        s = tmp
    end
    print ans, "\n"
end
# O(N^2)
# 実行結果-----
# irb(main):013:0> work2
# [1, 3, 2, 3, 0, 0, 3, 1, 4]
# => nil

# 課題３
def work3(first, second)
    s = -1
    t = nil
    for i in 0 .. first.length - 1 do
        t = second.index(first[i])
        if t != nil then
            s = i
            break
        end
    end
    print (first[0..s] + second[t+1..-1]) * ","
end
# O(N^2)
# 実行結果
#
