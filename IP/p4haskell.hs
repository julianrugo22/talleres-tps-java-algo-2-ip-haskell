import Text.Printf (formatInteger)
esPar :: Integer -> Bool
esPar n | mod n 2 == 0 = True
        | otherwise = False

fibonacci :: Integer -> Integer
fibonacci n | n == 0 = 0
            | n == 1 = 1
            | otherwise = fibonacci (n-1) + fibonacci (n-2)

parteEntera :: Float -> Float
parteEntera n | abs(n) < 1 = 0
              | (n >= 1) && (n < 2) = 1
              | (n <= -1) && (n > -2) = -1
              | n > 0 = parteEntera (n-1) + 1
              | n < 0 =  (parteEntera (n+1)) -1

esDivisible :: Float -> Float -> Bool
esDivisible n m | parteEntera (n/m) == n/m = True
                | otherwise = False

sumaImpares :: Integer -> Integer
sumaImpares n | n == 1 = 1
              | mod n 2 /= 0 = n + sumaImpares(n-2)
              | mod n 2 == 0 = (n-1) + sumaImpares(n-3)

medioFact :: Integer -> Integer
medioFact n | n == 2 = 2
            | n == 1 = 1
            | n > 1 = medioFact (n-2) * n
            | n == 0 = 0

digitosIguales :: Integer -> Bool
digitosIguales n | n < 10 = True
                 | ((mod n 10) == (mod (div n 10) 10 )) && ( digitosIguales (div n 10)) = True
                 | otherwise = False

iesimoDigito :: Integer -> Integer -> Integer
iesimoDigito n i = mod (div n (10^i)) 10

cantDigitos :: Integer -> Integer
cantDigitos n | div n 10 == 0 = 1
              | otherwise = cantDigitos(div n 10) + 1

sacarPrimero :: Integer -> Integer
sacarPrimero n = div n 10

sacarUltimo :: Integer -> Integer
sacarUltimo n = mod n (10^((cantDigitos n) - 1))

acortar :: Integer -> Integer
acortar n = sacarPrimero(sacarUltimo(n))

capicua :: Integer -> Bool
capicua n | n < 10 = True
          | (div n (10^((cantDigitos n) - 1)) == mod n 10) && capicua(acortar(n)) = True
          | otherwise = False

f1 :: Integer -> Integer
f1 n | n == 0 = 1
     | otherwise = ( 2 ^ n ) + f1 ( n - 1 )     


f2 :: Float -> Integer -> Float
f2 m n | ( n == 1 ) = m
       | otherwise = ( m ^ n ) + f2 ( m ) ( n - 1 )

f3 :: Float -> Integer -> Float
f3 m n | ( n == 1 ) = m
       | otherwise = ( m ^ (2*n) ) + f3 ( m ) ( 2*n - 1 )


factorial :: Integer -> Integer
factorial n | n == 0 = 1
            | otherwise = n * factorial (n-1)

eAprox :: Integer -> Float
eAprox n | n == 0 = 1
         | otherwise = ( 1 / fromInteger(factorial n )) + eAprox (n-1)

e :: Float
e = eAprox 10

raiz2AproxAux :: Integer -> Float
raiz2AproxAux n | n == 1 = 2
             | otherwise = 1/(raiz2AproxAux (n-1)) + 2

raiz2Aprox :: Integer -> Float
raiz2Aprox n = raiz2AproxAux (n) - 1

sumatoria :: Integer -> Integer -> Integer
sumatoria m n | n == 1 = m
              | m == 1 = 1
              | otherwise = ( m ^ n ) - sumatoria m (n - 1)

sumatoriaDoble :: Integer -> Integer -> Integer
sumatoriaDoble m n | m == 1 = 1
                   | n == 1 = m
                   | otherwise = sumatoriaDoble (m - 1) n + sumatoria m n 

sumaPotenciasAux :: Integer -> Integer -> Integer -> Integer
sumaPotenciasAux q m n | q == 1 = 1
                       | m + n == m = q ^ m
                       | otherwise = q ^ (m + n) + sumaPotenciasAux q m (n-1)

sumaPotencias :: Integer -> Integer -> Integer -> Integer
sumaPotencias q n m | q == 1 = 1
                    | m + n == n = q ^ (n)
                    | otherwise = sumaPotencias q (m-1) n + sumaPotenciasAux q m n

sumaRacionalesAux :: Integer -> Integer -> Float
sumaRacionalesAux n m | m == 1 = fromInteger(n)
                      | otherwise = fromInteger(n) / fromInteger(m) + sumaRacionalesAux n (m-1)
 
sumaRacionales :: Integer -> Integer -> Float
sumaRacionales n m | n == 1 = 1 / fromInteger(m)
                   | otherwise = sumaRacionales (n-1) m + sumaRacionalesAux n m

menorDivisorAux:: Integer -> Integer -> Integer
menorDivisorAux n m | mod n m == 0 = m
                    | otherwise = menorDivisorAux n (m+1)

menorDivisor :: Integer -> Integer
menorDivisor n = menorDivisorAux n 2

esPrimo :: Integer -> Bool
esPrimo n | menorDivisor n == n = True
          | otherwise = False

sonCoprimos :: Integer -> Integer -> Bool
sonCoprimos m n | m == n = True
                | (mod n (menorDivisorAux m 2) == 0) || (mod n (menorDivisorAux m (( menorDivisor m )+ 1)) == 0) = True
                | otherwise = False

buscarPrimo :: Integer -> Integer 
buscarPrimo n | esPrimo n == True = n
              | otherwise = buscarPrimo ( n + 1 )

nEsimoPrimo :: Integer -> Integer
nEsimoPrimo n | n == 1 = 2
              | otherwise = buscarPrimo (nEsimoPrimo(n-1) + 1) 

buscarFibonacci :: Integer -> Integer -> Bool
buscarFibonacci n m | n == fibonacci m = True
                    | n < fibonacci m = False
                    | otherwise = buscarFibonacci n (m+1)

esFibonacci :: Integer -> Bool 
esFibonacci n = buscarFibonacci n 1

primerDigito :: Integer -> Integer
primerDigito n = n - (div n 10) * 10

ultimoDigito :: Integer -> Integer
ultimoDigito n = div n (10 ^ (cantDigitos(n)- 1))

sacarPenultimo :: Integer -> Integer
sacarPenultimo n = sacarUltimo(sacarUltimo(n)) + ultimoDigito (n) * ( 10 ^ (cantDigitos(n)- 2))

sacarImpares :: Integer -> Integer
sacarImpares n | div n 10 == 0 = n 
               | esPar(primerDigito n) == False = sacarImpares(sacarPrimero n)
               | esPar ( ultimoDigito n ) == False = sacarImpares (sacarUltimo n)
               | esPar ( ultimoDigito n ) == True = sacarImpares (sacarUltimo n) + ((ultimoDigito n)* (10 ^ ((cantDigitos n)) ))
               



               

            
