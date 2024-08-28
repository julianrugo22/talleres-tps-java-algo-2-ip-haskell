import Language.Haskell.TH (prim)
longitud :: [t0] -> Integer
longitud [] = 0
longitud (x:xs) = longitud (xs) + 1

ultimo :: [t0] -> t0
ultimo (x:xs) | longitud (x:xs) == 1 = x
              | otherwise = ultimo (xs)

principio :: [t0] -> [t0]
principio (x:xs) | longitud (x:xs) == 2 = [x]
                 | otherwise = x : principio(xs)

reverso :: [t0] -> [t0]
reverso (x:xs) | longitud(xs) == 0 = [x]
               | otherwise = reverso (xs) ++ [x]

pertenece :: (Eq t0) => t0 -> [t0] -> Bool
pertenece y (x:xs) | y == x = True
                   | longitud (xs) == 0 = False
                   | y /= x = pertenece y xs

todosIguales :: (Eq t0) => [t0] -> Bool
todosIguales [] = True
todosIguales [_] = True
todosIguales (x:y:xs) | (longitud(x:y:xs) == 2) && (x==y) = True
                      | (longitud (x:y:xs) == 3) && (x == y) && (x == ultimo (xs)) = True
                      | x == y = todosIguales (y:xs)
                      | x /= y = False
                      | otherwise = False

todosDistintos :: (Eq t0) => [t0] -> Bool
todosDistintos [] = True
todosDistintos [_] = True
todosDistintos (x:y:xs) | (longitud (x:y:xs) == 2) && ( x /= y ) = True
                        | x == y = False
                        | (x /= y) = (todosDistintos(x:xs)) && (todosDistintos (y:xs))
                        | otherwise = True
                        
hayRepetidos :: (Eq t0) => [t0] -> Bool
hayRepetidos [] = False
hayRepetidos [_] = False
hayRepetidos (xs) = not (todosDistintos(xs))

quitarPrimero :: (Eq t0) => t0 -> [t0] -> [t0]
quitarPrimero y (x:xs) | (pertenece y (x:xs)) == False = (x:xs)
                       | y == x = xs
                       | otherwise = x : (quitarPrimero y (xs))

quitar :: (Eq t0) => t0 -> [t0] -> [t0]
quitar _ [] = []
quitar y (x:xs) | (pertenece y (x:xs)) == False = (x:xs)
                | (longitud (x:xs) == 1) && (y /= x) = (x:xs)
                | (longitud (x:xs) == 1) && (y == x) = (xs)
                | y == x = quitar y (xs)               
                | otherwise = x : (quitar y (xs))

eliminarRepetidos :: (Eq t0) => [t0] -> [t0]
eliminarRepetidos [] = []
eliminarRepetidos (x:xs) | hayRepetidos (x:xs) == False = (x:xs)
                         | pertenece x xs == False = x : (eliminarRepetidos (xs))
                         | pertenece x xs == True = eliminarRepetidos(xs)
        
mismosElementos :: (Eq t0) => [t0] -> [t0] -> Bool
mismosElementos [] [] = True
mismosElementos _ [] = False
mismosElementos [] _ = False
mismosElementos (x:xs) (ys) | (pertenece x ys) == False = False
                            | longitud (xs) == 0 = True
                            | otherwise = mismosElementos xs ys

sacarUltimo :: [t0] -> [t0]
sacarUltimo (x:xs) | longitud (x:xs) == 1 = []
                   | otherwise = x : (sacarUltimo (xs))

capicuaLista :: (Eq t0) => [t0] -> Bool
capicuaLista [] = True
capicuaLista [_] = True
capicuaLista (x:xs) | (longitud(x:xs)) == 1 = True
                    | (longitud(x:xs) == 2) && (x == ultimo(xs)) = True
                    | x /= ultimo(xs) = False 
                    | otherwise = capicuaLista (sacarUltimo(xs))

sumatoriaLista :: [Integer] -> Integer
sumatoriaLista [] = 0
sumatoriaLista (x:xs) | longitud(x:xs) == 0 = 0 
                      | otherwise = x + sumatoriaLista(xs)

productoriaLista :: [Integer] -> Integer
productoriaLista [] = 1
productoriaLista (x:xs) | longitud(x:xs) == 0 = 1
                        | otherwise = x * productoriaLista(xs)

maximo :: [Integer] -> Integer
maximo (x:y:xs) | ((longitud (x:y:xs)) == 2) && (x>=y) = x 
                | ((longitud (x:y:xs)) == 2) && (x<y) = y
                | x < y = maximo (y:xs) 
                | x >= y = maximo (x:xs)

sumarN :: Integer -> [Integer] -> [Integer]
sumarN n [] = [n]
sumarN n (x:xs) | longitud (x:xs) == 1 = [x+n]
                | otherwise = (x+n) : (sumarN n (xs))

sumarElPrimero :: [Integer] -> [Integer]
sumarElPrimero (x:xs) = sumarN x (x:xs)

sumarElUltimo:: [Integer] -> [Integer]
sumarElUltimo (x:xs) = sumarN (ultimo (x:xs)) (x:xs)

pares :: [Integer] -> [Integer]
pares (x:xs) | (longitud (x:xs) == 1) && (mod x 2 == 0) = [x]
             | (longitud (x:xs) == 1) && (mod x 2 /= 0) = []
             | mod x 2 == 0 = x : (pares(xs))
             | otherwise = pares (xs)

multiplosN :: Integer -> [Integer] -> [Integer]
multiplosN n (x:xs) | (longitud (x:xs) == 1) && (mod x n == 0) = [x]
                    | (longitud (x:xs) == 1) && (mod x n /= 0) = []
                    | mod x n == 0 = x : (multiplosN n (xs))
                    | otherwise = multiplosN n (xs)

ordenar :: [Integer] -> [Integer]
ordenar (x:y:xs) | (longitud (x:y:xs) == 2) && (x < y) = [x,y] 
                 | (longitud (x:y:xs) == 2) && (x >= y) = [y,x] 
                 |  otherwise = ordenar(quitarPrimero (maximo (x:y:xs)) (x:y:xs)) ++ [maximo(x:y:xs)]

sacarBlancosRepetidos :: [Char] -> [Char]
sacarBlancosRepetidos (x:y:xs) | (longitud (x:y:xs) == 2) && ((x == ' ' ) && ( x == y )) = [x]
                               | (longitud (x:y:xs) == 2) = [x,y]
                               | (x == ' ' ) && ( x == y ) = sacarBlancosRepetidos(x:xs)
                               | otherwise = (x) : sacarBlancosRepetidos(y:xs)

tieneBlancosRepetidos :: [Char] -> Bool
tieneBlancosRepetidos (xs) | longitud (xs) /= longitud (sacarBlancosRepetidos(xs)) = True
                           | longitud (xs) == longitud (sacarBlancosRepetidos(xs)) = False

contarPalabras :: [Char] -> Integer
contarPalabras [] = 0
contarPalabras [' '] = 0
contarPalabras [_] = 1
contarPalabras (x:y:xs) | longitud (sacarBlancosRepetidos(x:y:xs)) == 2 = 1
                        | (x /= ' ') && (y == ' ') = contarPalabras(y:xs) + 1
                        | otherwise = contarPalabras (y:xs)

sacarPalabra :: [Char] -> [Char] -> [Char]
sacarPalabra [] (ys) = ys
sacarPalabra (x:xs) (y:ys) | y == ' ' = sacarPalabra (x:xs) ys
                           | primerPalabra (x:xs) == primerPalabra (y:ys) = sacarPalabra (xs) (ys)
                           | primerPalabra (x:xs) /= primerPalabra (y:ys) = (y:ys) 
                           | otherwise = []

primerPalabra :: [Char] -> [Char]
primerPalabra [] = []
primerPalabra [' '] = []
primerPalabra [' ',' '] = []
primerPalabra [x] = [x]
primerPalabra [x,' '] = [x]
primerPalabra [' ',x] = [x]
primerPalabra [x,y] = [x,y]
primerPalabra [' ',' '] = []
primerPalabra (x:y:z:xs) | tieneBlancosRepetidos (x:y:z:xs) == True = primerPalabra (sacarBlancosRepetidos(x:y:z:xs))
                       | ( x == ' ' ) && ( y /= ' ' ) && ( z == ' ' ) = [y]
                       | ( x == ' ' ) && ( y /= ' ' ) && ( z /= ' ' ) = [y] ++ primerPalabra(z:xs)
                       | ( x /= ' ' ) && ( y /= ' ' ) && ( z /= ' ' ) = [x,y] ++ primerPalabra(z:xs)
                       | ( x /= ' ' ) && ( y /= ' ' ) && ( z == ' ' ) = [x,y]
                       | ( x /= ' ' ) && ( y == ' ' ) && ( z == ' ' ) = [x]
                       | ( x /= ' ' ) && ( y == ' ' ) && ( z /= ' ' ) = [x]
                       | otherwise = []

palabras :: [Char] -> [[Char]]
palabras [] = []
palabras " " = []
palabras [x] = [[x]]
palabras xs | tieneBlancosRepetidos (xs) == True = palabras(sacarBlancosRepetidos(xs))
            | otherwise = primerPalabra (xs) : palabras(sacarPalabra(primerPalabra (xs)) (xs))

contarLetras :: [Char] -> Integer
contarLetras [] = 0
contarLetras (x:xs) | longitud (x:xs) == 1 = 1
                    | otherwise = contarLetras(xs) + 1


minimoDivisorAux :: Int -> Int -> Int
minimoDivisorAux n m | n == 1 = 1
                     | mod n m == 0 = m
                     | otherwise = minimoDivisorAux n (m+1)

minimoDivisor :: Int -> Int
minimoDivisor = minimoDivisorAux n 2

esPrimo :: Int -> Bool
esPrimo n | minimoDivisor n == n = True
          | otherwise = False

descomponerEnPrimos :: [Int] -> [[Int]]
descomponerEnPrimos (x:xs) |
                           | 
                           | esPrimo x == True = [x] : descomponerEnPrimos (xs)
                           | productoria 


