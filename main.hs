import Data.List (nub)
--Capítulo 2 - Primeiros Exemplos
--Programação funcional - Tipos de Dados e Funções

maiorQue :: Int -> Int -> Bool
maiorQue x y = x>y
--Aqui é feita uma função que recebe dois Inteiros e retorna um boolean


-- Programação Funcional - Compreensão de Listas

dobroLista :: [Int] -> [Int]
dobroLista xs = [2*x | x<-xs]
-- Aqui é feita uma função que recebe um Inteiro e retorna outro Inteiro
-- O usuário deve enviar X's números para ser devolvida uma lista de números dobrados

lista :: [Int]
lista = [2*x+1 | x<-[0..10], x/=5]
-- Lista é declarada como uma lista de inteiros
-- É colocada uma regra multiplicando x e somando +1, x itera até 10, com a exeção de 5


-- Programação Funcional - Tuplas
-- Diferentemente das listas, tuplas carregam diversos tipos dentro de si

--Exemplo de tupla
foo :: Char -> Int -> (Int, String)
foo x y = (y+9, x: [x])
-- No exemplo é retornado  recebemos um caractere e um Inteiro.
-- Retornando um Int e uma cadeia de caracteres (String)
-- A função então retorna y+9 e cria uma lista de caracteres com o mesmo caractere inserido na chamada da função

-- Exercícios
ex1 :: [Int]
ex1 = [11^x | x<-[0..6]]

ex2 :: [Int]
ex2 = [x+1 | x<-[0..38]]

--c) ["AaBB", "AbBB", "AcBB", "AdBB", "AeBB", "AfBB","AgBB"]
ex3 :: [String]
ex3 = ["A" ++ [x] ++ "BB" | x <- ['a'..'g']]

--d) [5,8,11,17,20,26,29,32,38,41]
ex4 :: [Int]
ex4 = [x + 3 | x <- [2..39], x/=11, x/=20, x/=32, mod x 3 ==2]

--e) [1.0,0.5,0.25,0.125,0.0625,0.03125]
ex5 :: [Double]
ex5 = [1 / 2^x | x <- [0..5]]

--f) [1,10,19,28,37,46,55,64]
ex6 :: [Int]
ex6 = [ 1 + x*9 | x <- [1..7]]

--g) [2,4,8,10,12,16,18,22,24,28,30]
ex7 :: [Int]
ex7 = [x + 2 | x <- [0..28], x/=4, x/=12, x/=18, x/=24, even x]

--h) ['@','A','C','D','E','G','J','L'] -- PRECISA TERMINAR
ex8 :: String
ex8 = [x | x <- ['@'..'L'], x/='B', x/='F', x/='H', x/='I', x/='K']

-- 2.2) Crie uma função que verifique se o tamanho de uma
-- String é par ou não. Use Bool como retorno.
ex9 :: String -> Bool
ex9 x = even (length x)

--2.3) Escreva uma função que receba um vetor de Strings e
--retorne uma lista com todos os elementos em ordem reversa.
ex10 :: [String] -> [String]
ex10 xs = [reverse x | x <- xs]

--2.4) Escreva uma função que receba um vetor de Strings e
--retorne uma lista com o tamanho de cada String. As palavras de
--tamanho par devem ser excluídas da resposta.
ex11 :: [String] -> [Int]
ex11 xs = [length x | x <- xs, odd (length x)]

--2.5) Escreva a função head como composição de duas outras.

--2.6) Faça uma função que receba uma String e retorne True
-- se esta for um palíndromo; caso contrário, False
ex13 :: String -> Bool
ex13 x = x == reverse x 

--2.7 Faça uma função que receba um inteiro e retorne uma
--tupla, contendo: o dobro deste número na primeira coordenada, o
--triplo na segunda, o quádruplo na terceira e o quíntuplo na quarta.