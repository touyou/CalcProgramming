# prac3
load "word.rb"
def search(w)
    word.index(w)
end

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

def search2(w)
    find(word, w)
end

def ifun(a)
    for i in 0..a.length-1
        if ia[a[i]]==nil
            ia[a[i]]=Array.new
        end
        ia[a[i]] << i
    end
    p ia
end

def test(n)
    a=Array.new(n)
    for i in 0..n-1
        same=true
        while same
            a[i]=(n*rand()).to_i
            same=false
            for j in 0..i-1
                same=true if a[j]==a[i]
            end
        end
    end
    return a
end

def perm(n)
    a=Array.new(n)
    a[i]=i for i in 0..n-1
    for i in 0..n-1
        j=((n-i)*rand()).to_i
        a[i+j],a[i] = a[i],a[i+j]
    end
    return a
end
