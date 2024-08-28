#print ("Hola mundo!\nSoy Julián!\n"*2)

#print (round((2**(1/2)),2))

def multiplo_de (x:int , y:int) -> bool:
    if (x % y) == 0:
        return True
    else:
        return False

def es_par (x:int) -> bool:
    if multiplo_de (x,2) == True:
        return True
    else:
        return False

def cant_pizzas (com:int, por:int) -> int:
    res = (com * por / 8) 
    if res % 1 == 0 or res <= 1:
        return res
    else:
        return round(res + 1)

print (cant_pizzas (7,1))
