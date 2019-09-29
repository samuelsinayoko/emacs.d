"""
Proposal for new keyboard layout optimized for LaTeX input in emacs

Changing numbers and symbol keys only relative to QWERTY. 

Mac keyboard (UK) 
-----------------
1! 2@ 3# 4$ 5% 6^ 7& 8* 9( 0) -_ =+
[{ ]} ;: '\" \|
`~ ,< .> /?

Latex keyboard
--------------
1* 2@ ~3 -4 _5 ^6 =7 +8 %9 0# /< &>
(} ') 
\: $; |!
[] `, {. \"?
"""

old = "1!2@3#4$5%6^7&8*9(0)-_=+[{]};:'\"\|`~,<.>/?"
new = "1*2@~3-4_5^6=7+8%90#/<&>(}')\:$;|![]`,{.\"?"

for (o, n) in zip(old, new):
    if n in ['\\', '(', ')', ';', '?', '"']:
        n = '\\' + n
    if o in ['\\', '"']:
        o = '\\' + o
    print '("%s" ?%s)' % (o, n)
    
