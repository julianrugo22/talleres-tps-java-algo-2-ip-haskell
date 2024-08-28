import GHC.Integer.GMP.Internals (sqrInteger)
import Text.XHtml (base)

f 1 = 8
f 4 = 131
f 16 = 16

g 8 = 16
g 16 = 4
g 131 = 1

h x = f(g(x))

k x = g(f(x))




absoluto :: Float -> Float 
absoluto n| n>=0 = n 
          | n<0 = (-n)

maximoabsoluto :: Float -> Float -> Float
maximoabsoluto m n| (absoluto n)> (absoluto m) = n
                  | otherwise = m

maximo :: Int -> Int -> Int -> Int
maximo x y z| (x >= y) && (x >= z) = x
            | (y >= x) && (y >= z) = y
            | otherwise = z

algunoEs0 :: Float -> Float -> Bool
algunoEs0 0 _ = True
algunoEs0 _ 0 = True
algunoEs0 _ _ = False

ambosSon0 :: Float -> Float -> Bool
ambosSon0 0 0 = True
ambosSon0 _ _ = False

mismoIntervalo :: Float -> Float -> Bool
mismoIntervalo x y| (x<=3) && (y<=3) = True
                  | (x>3) && (x<=7) && (y>3) && (y<=7) = True
                  | (x>7) && (y>7) = True
                  | otherwise = False

sumaDistintos :: Float -> Float -> Float -> Float
sumaDistintos x y z| (x/=y) && (x/=z) && (z/=y) = x + y + z
                   | (x==y) && (z==y) = z
                   | (x==y) && (y/=z) = x + z
                   | (y==z) && (x/=y) = x + y
                   | otherwise = y + z

esMultiploDe :: Int -> Int -> Bool
esMultiploDe x y| (mod x y) == 0 = True
                | otherwise = False

digitoUnidades :: Int -> Int
digitoUnidades x = mod x (10)

digitoDecenas :: Int -> Int
digitoDecenas x = mod x (100)

estanRelacionados :: Int -> Int -> Bool
estanRelacionados a b | mod a b == 0 = True
                      | otherwise = False

prodInterno :: (Int,Int) -> (Int,Int) -> Int
prodInterno (a,b) (c,d) = a * c + b * d

todoMenor :: (Int,Int) -> (Int,Int) -> Bool
todoMenor (a,b) (c,d) | a < c && b < d = True
                      | otherwise = False

norma2 :: (Float,Float) -> Float
norma2 (a,b) = (( a ** 2 ) + ( b ** 2 )) ** (0.5)

distanciaPuntos :: (Float,Float) -> (Float,Float) -> Float
distanciaPuntos (a,b) (c,d) = norma2 ((a-c),(b-d))

sumaTerna :: (Int,Int,Int) -> Int
sumaTerna (a,b,c) = a + b + c

sumaTernaMultiplos :: (Int,Int,Int) -> Int -> Int
sumaTernaMultiplos (a,b,c) d | (esMultiploDe a d == True) && (esMultiploDe b d == True) && (esMultiploDe c d == True)= a + b + c
                             | (esMultiploDe a d == True) && (esMultiploDe b d == True) = a + b
                             | (esMultiploDe a d == True) && (esMultiploDe c d == True) = a + c 
                             | (esMultiploDe b d == True) && (esMultiploDe c d == True) = b + c 
                             | (esMultiploDe a d == True) = a 
                             | (esMultiploDe b d == True) = b 
                             | (esMultiploDe c d == True) = c
                             | otherwise = 0

esPar :: Int -> Bool
esPar n | mod n 2 == 0 = True

posPrimerPar :: (Int,Int,Int) -> Int
posPrimerPar (a,b,c) | esPar a == True = 1 
                     | esPar b  == True = 2
                     | esPar c  == True = 3
                     | otherwise = 4

crearPar :: t0 -> t1 -> (t0,t1)
crearPar a b = (a,b)

invertirPar :: (t0,t1) -> (t1,t0)
invertirPar (a,b) = (b,a)


men1 :: Int -> Int
men1 n | n <= 7 = n * n
       | n > 7  = 2*n - 1

men2 :: Int -> Int
men2 n | (esPar n == True) = div n 2 
       | otherwise = 3*n + 1 

todosMenores :: (Int,Int,Int) -> Bool
todosMenores (a,b,c) | ((men1 a)>(men2 a)) && ((men1 b)>(men2 b)) && ((men1 c)>(men2 c)) = True
                     | otherwise = False
bisiesto :: Int -> Bool
bisiesto n | (mod n 4 /= 0) || ((mod n 100 == 0) && (mod n 400 /= 0)) = False
           | otherwise = True

distanciaManhattan :: (Float,Float,Float) -> (Float,Float,Float) -> Float
distanciaManhattan (x1,y1,z1) (x2,y2,z2) = absoluto (x1-x2) + absoluto (y1-y2) + absoluto (z1-z2)

sumaUltimosDosDigitos :: Int -> Int
sumaUltimosDosDigitos n = (mod n 10) + (mod (div n 10) 10)

comparar :: Int -> Int -> Int
comparar a b | sumaUltimosDosDigitos a < sumaUltimosDosDigitos b = 1 
             | sumaUltimosDosDigitos a > sumaUltimosDosDigitos b = -1 
             | sumaUltimosDosDigitos a == sumaUltimosDosDigitos b = 0







