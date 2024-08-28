mismaTupla :: (String,String) -> (String,String) -> Bool
mismaTupla (a,b) (c,d) | (a == c) && (b == d) = True
                       | (a == d) && (b == c) = True
                       | otherwise = False

tuplasIguales :: [(String,String)] -> Bool
tuplasIguales (x:y:xs) | (length (x:y:xs) == 2) && (mismaTupla x y == True) = True
                       | (length (x:y:xs) == 2) && (mismaTupla x y == False) = False
                       | (x == y) = True
                       | otherwise = tuplasIguales (x:xs) || tuplasIguales (y:xs)

mismosElementos :: [(String,String)] -> Bool
mismosElementos ((a,b) : xs) | (length ((a,b):xs) == 1) && (a == b) = True
                             | (length ((a,b):xs) == 1) && (a /= b) = False
                             | a == b = True
                             | otherwise = mismosElementos (xs)

relacionesValidas :: [(String,String)] -> Bool
relacionesValidas xs | (mismosElementos xs == False) && (tuplasIguales xs == False) = True
                     | otherwise = False

personasLista ::  [(String,String)] -> [String]
personasLista ((a,b):xs) | length ((a,b):xs) == 1 = [a,b]
                         | otherwise = [a,b] ++ personasLista (xs)

quitarPrimero :: (Eq t0) => [t0]