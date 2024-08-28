tuplasIguales :: (String,String) -> (String,String) -> Bool
tuplasIguales (a,b) (c,d) | (a == c) && (b == d) = True
                          | (a == d) && (b == c) = True
                          | otherwise = False


tuplasDiferentes :: [(String,String)] -> Bool
tuplasDiferentes (x:y:xs) | (length (x:y:xs) == 2) && ((tuplasIguales x y) == False) = True
                          | ((tuplasIguales x y) == False) = tuplasDiferentes (x:xs) && tuplasDiferentes (y:xs)
                          | otherwise = False

mismosElementos :: (String,String) -> Bool
mismosElementos (a,b) | a == b = True
                      | otherwise = False

mismosElementosLista :: [(String,String)] -> Bool
mismosElementosLista (x:xs) | ((mismosElementos x) == False) && (length (x:xs) == 1) = True
                            | (mismosElementos x) == False = mismosElementosLista (xs)
                            | otherwise = False

relacionesValidas :: [(String,String)] -> Bool
relacionesValidas (x:xs) | (tuplasDiferentes (x:xs) == True) && (mismosElementosLista (x:xs) == True)= True
                         | otherwise = False

personasLista :: [(String,String)] -> [String]
personasLista ((x,y):[]) = [x,y]
personasLista ((x,y):xs) = [x,y] ++ personasLista (xs)

todosDistintos :: (Eq t0) => [t0] -> Bool
todosDistintos [] = True
todosDistintos [_] = True
todosDistintos (x:y:xs) | (length (x:y:xs) == 2) && ( x /= y ) = True
                        | x == y = False
                        | (x /= y) = (todosDistintos(x:xs)) && (todosDistintos (y:xs))
                        | otherwise = True
                        
eliminarRepetidos :: (Eq t0) => [t0] -> [t0]
eliminarRepetidos [] = []
eliminarRepetidos (x:xs) | hayRepetidos (x:xs) == False = (x:xs)
                         | elem x xs == False = x : (eliminarRepetidos (xs))
                         | elem x xs == True = eliminarRepetidos(xs)

personas :: [(String,String)] -> [String]
personas (xs) = eliminarRepetidos(personasLista(xs))

amigosDe :: String -> [(String,String)] -> [String]
amigosDe (z) ((x,y):xs) | (length ((x,y):xs) == 1) && (z == x) = [y]
                        | (length ((x,y):xs) == 1) && (z == y) = [x]
                        | (length ((x,y):xs) == 1) = []
                        | (z == x) = [y] ++ amigosDe z (xs)
                        | (z == y) = [x] ++ amigosDe z (xs)
                        | otherwise = amigosDe z (xs)

cantAmigos :: String -> [(String,String)] -> Int
cantAmigos (z) (xs) = length(amigosDe (z) (xs)) 


masPopularAux :: [String] -> [(String,String)] -> String
masPopularAux (x:y:ys) (xs) | (length (x:y:ys) == 2) && (cantAmigos (x) (xs) >= cantAmigos (y) (xs)) = x
                            | (length (x:y:ys) == 2) && (cantAmigos (x) (xs) < cantAmigos (y) (xs)) = y
                            | cantAmigos (x) (xs) >= cantAmigos (y) (xs) = masPopularAux (x:ys) (xs)
                            | cantAmigos (x) (xs) < cantAmigos (y) (xs) = masPopularAux (y:ys) (xs)

masPopular :: [(String,String)] -> String
masPopular (xs) = masPopularAux (personas(xs)) (xs) 


productoria :: [Int] -> Int
productoria [] = 0
productoria [x] = x 
productoria (x:y:xs) | length ( x:y:xs ) == 2 = (x * y)
                     | otherwise = x * productoria (y:xs)

sumarN :: Int -> [Int] -> [Int]
sumarN n [] = [n]
sumarN n [x] = [x+n]
sumarN n (x:xs) = (n+x) : (sumarN n xs)  

sumarPrimero :: [Int] -> [Int]
sumarPrimero [] = []
sumarPrimero [x] = [x+x]
sumarPrimero (x:xs) = sumarN (x) (x:xs)

sumarUltimo :: [Int] -> [Int]
sumarUltimo [] = []
sumarUltimo [x] = [x+x]
sumarUltimo (x:xs) = sumarN (ultimo(x:xs)) (x:xs)


ultimo :: [t0] -> t0
ultimo [x] = x
ultimo (x:xs) = ultimo xs 

multiplodeN :: Int -> [Int] -> [Int]
multiplodeN n [] = []
multiplodeN n (x:xs) | ( length (x:xs) == 1 ) && ( (mod x n) == 0) = [x]
                     | ( length (x:xs) == 1 ) && ( (mod x n) /= 0) = []
                     | mod x n == 0 = [x] ++ multiplodeN n (xs)
                     | otherwise = multiplodeN n (xs)

pares :: [Int] -> [Int]
pares (xs) = multiplodeN 2 (xs)

quitarPrimer :: (Eq t0) => t0 -> [t0] -> [t0]
quitarPrimer _ [] = []
quitarPrimer n (x:xs) | (length (x:xs) == 1) && (n == x) = []
                      | (length (x:xs) == 1) && (x /= n) = [x]
                      | n == x = (xs)
                      | otherwise = x : quitarPrimer n (xs)

pertenece :: (Eq t0) => t0 -> [t0] -> Bool
pertenece n (x:xs) | (length (x:xs) == 1) && (n /= x) = False
                   | (length (x:xs) == 1) && (n == x) = True
                   | (n == x) = True
                   | otherwise = pertenece n (xs)

hayRepetidos :: (Eq t0) => [t0] -> Bool
hayRepetidos [] = False
hayRepetidos [_] = False
hayRepetidos (x:y:xs) | (length (x:y:xs) == 2 ) && ( x == y ) = True
                      | (length (x:y:xs) == 2 ) && ( x /= y ) = False
                      | (x==y) = True
                      | otherwise = (hayRepetidos (x:xs)) || (hayRepetidos (y:xs))

quitarRepetidos :: (Eq t0) => [t0] -> [t0]
quitarRepetidos [] = []
quitarRepetidos (x:xs) | length (x:xs) == 1 = [x]
                       | pertenece x (xs) == False = [x] ++ quitarRepetidos (xs)
                       | otherwise = quitarRepetidos (x:(quitarPrimer x (xs)))

maximo :: [Int] -> Int
maximo [x] = x
maximo (x:y:xs) | (length (x:y:xs) == 2) && (x>=y) = x
                | (length (x:y:xs) == 2) && (y>x) = y
                | x >= y = maximo (x:xs)
                | otherwise = maximo (y:xs)

ordenar :: [Int] -> [Int]
ordenar [] = []
ordenar [x] = [x]
ordenar (xs) = (maximo xs) : (ordenar(quitarPrimer (maximo xs) xs))

reverso :: [t0] -> [t0]
reverso [] = []
reverso (x:xs) | length (x:xs) == 1 = [x]
               | otherwise = reverso (xs) ++ [x]


