# 本棚のファイル木（仮）
# 基本的にツリー構造であるがそれぞれの頂点が重みを持つ
# 重みの計算は 葉が1、他がそれぞれの子の重みの合計
# また登録順に各頂点はidが割り振られ、それによってUnionFind木が生成されている
# 【出来ること】
# 各ジャンルにある本の冊数の計算：各ジャンルの頂点の重みがそのまま反映される
# 各本のジャンルの検索：idで検索するように(Hashでidと名前の対応を持っておく)すればUnionFind木によって根がすぐにわかる
# など
# 【使い方】
# 画像はMindmap形式でつくっているがそれを入力する時と同じように
# 親が本棚ならば：bookTree.addBook("Hoge")
# 親がジャンルHogeなら：bookTree.addBook("hogeChild", "Hoge")
# というように一個ずつ追加していく
# あるいはaddFromFileを使う場合データの形式は
#      親ジャンルの数
#      親ジャンルの名前
#      ...
#      親ジャンルの名前 子ジャンルの名前
#      ...
#      子ジャンルの名前 本の名前
#      ...
# のようにする。ただし親として指定した名前が存在しない場合本が追加されないのでかならず深さの低いところから入力するようにしなければならない。
# MARK: BookTree
class BookTree
    # uTree: UnionFind木, hMap: 名前からid
    # wArray: 重みのArray, adjArray: 有向グラフで必ず子から親に向いている
    # nameMap: idから名前
    attr_accessor: uTree, hMap, wArray, adjArray
    def initialize()
        @uTree = UnionFind.new
        @hMap = Hash.new
        @nameMap = Hash.new
        @id = 0
        @wArray = Array.new
        @adjArray = Array.new
    end

    def addBook(name, parent=nil)
        new_array = Array.new
        if parent == nil
            @uTree.checkSize(@id+1)
            @hMap[name] = @id
            @nameMap[@id] = name
            @wArray << 1
            @adjArray << new_array
        else
            pid = @hMap[parent]
            if pid == nil
                return "no parent error: can't find such name"
            end
            @uTree.checkSize(@id+1)
            @uTree.union(@id, pid)
            @hMap[name] = @id
            @nameMap[@id] = name
            @wArray << 1
            new_array << pid
            @adjArray << new_array
            reloadWeight(@id)
        end
        @id += 1
    end

    def reloadWeight(id)
        for pid in @adjArray[id]
            @wArray[pid] += 1
            reloadWeight(pid)
        end
    end

    # ファイルから読み込みたい時
    def addFromFile(file)
        f = open(file)
        size = f.gets.to_i
        for i in 0 .. size-1
            addBook(f.gets.to_s)
        end
        while (s = f.gets) != nil
            pname, name = s.split(/ /)
            if @hMap[pname] != nil
                addBook(name, pname)
            end
        end
        f.close
    end

    # そのジャンルを何冊持っているか？
    def howMany(name)
        return wArray[hMap[name]]
    end

    # どのジャンルに属するか
    def whatKind(name)
        return nameMap[@uTree.findSet(hMap[name])]
    end

    # 本のSet（ジャンル抜きで各本のリストを名前で）
    def toSet()
        allList = uTree.toSet()
        result = Array.new
        for diffList in allList
            new_array = Array.new
            for book in diffList
                if wArray[book] == 1
                    new_array << nameMap[book]
                end
            end
            result << new_array
        end
        return result
    end
end

# MARK: UnionFind
class UnionFind
    def initialize()
        @parent = Array.new
    end

    def checkSize(i)
        size = @parent.length
        for j in size .. i
            @parent[j] = j
        end
    end

    def findSet(i)
        checkSize(i)
        if i != @parent[i]
            @parent[i] = findSet(@parent[i])
        end
        return @parent[i]
    end

    def sameComponent(i, j)
        return findSet(i) == findSet(j)
    end

    def union(i, j)
        ip = findSet(i)
        jp = findSet(j)
        if ip != jp
            @parent[ip] = jp
        end
    end
end

class UnionFind
    def toSet()
        setOfSets = Array.new
        for i in 0 .. @parent.length-1
            p = findSet(i)
            if setOfSets[p] = Array.new
                setOfSets[p] = Array.new
            end
            setOfSets[p] << i
        end
        result = Array.new
        for i in 0 .. setOfSets.length - 1
            if setOfSets[i] != nil
                result << setOfSets[i]
            end
        end
        return result
    end
end
