def ultima_aparicion(s: list[int], e: int) -> int:
    for i in range(len(s)):
        if s[i] == e:
            res = i + 1
    return res

print (ultima_aparicion([1,2,3,4,1,7],1))

def pertenece (x:int,s:list[int]) -> bool:
    for i in range (len(s)):
        if x == s[i]:
            return True
    return False

print (pertenece(1,[0,2,3,4,1,7]))

def elementos_exclusivos (s:list[int], t:list[int]) -> list[int]:
    res = []
    for i in range (len(s)):
        if pertenece(s[i],t) == False:
            res.append(s[i])
    return res+t

print (elementos_exclusivos([-1, 4, 0, 4, 3, 0, 100, 0, -1, -1],[0, 100, 5, 0, 100, -1, 5]))