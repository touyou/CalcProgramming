load "Lines.rb"

# practice 1
isesaki = isesakisen
print isesaki.index("業平橋駅") + 1, "\n"

# practice 2
inohead = inokashira
inohead[inohead.index("東大前駅")..inohead.index("駒場駅")] = "駒場東大前駅"
print inohead, "\n"

# practice 3
ty = touyoko
ft = fukutoshin
print ft.reverse+ty[1..-1], "\n"


