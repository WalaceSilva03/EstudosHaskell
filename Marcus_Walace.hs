-- Exercícios Capitulo 2
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
ex8 :: [Char]
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
ex12 :: [Char] -> Char
ex12 = last . reverse

--2.6) Faça uma função que receba uma String e retorne True
-- se esta for um palíndromo; caso contrário, False
ex13 :: String -> Bool
ex13 x = x == reverse x 

--2.7 Faça uma função que receba um inteiro e retorne uma
--tupla, contendo: o dobro deste número na primeira coordenada, o
--triplo na segunda, o quádruplo na terceira e o quíntuplo na quarta.
ex14 :: Int -> (Int, Int, Int, Int)
ex14 x = (x*2, x*3, x*4, x*5)


------------------------------------------------------------------------------------------------------------
-- EXERCÍCIOS - Capitulo 3

-- 3.1) Crie o tipo Pergunta com os values constructors Sim ou Nao . Faça as funções seguintes, determinando seus tipos explicitamente.

data Pergunta = Sim | Nao deriving Show

-- pergNum: recebe via parâmetro uma Pergunta .Retorna 0 para Nao e 1 para Sim .
pergNum :: Pergunta -> Int
pergNum Sim = 1
pergNum Nao = 0

--listPergs: recebe via parâmetro uma lista de Perguntas , e retorna 0 s e 1 s correspondentes aos constructores contidos na lista.
listPergs :: [Pergunta] -> [Int]
listPergs ps = [pergNum p | p <- ps]

--and': recebe duas Perguntas como parâmetro e retorna a tabela verdade do and lógico, usando Sim como verdadeiro e Nao como falso.
and' :: Pergunta -> Pergunta -> Pergunta
and' Sim Sim = Sim
and' Sim  _  = Nao
and'  _  Sim = Nao
and'  _   _  = Nao

--or' : idem ao anterior, porém deve ser usado o ou lógico.
or' :: Pergunta -> Pergunta -> Pergunta
or' Sim Sim = Sim
or' Sim  _  = Sim
or'  _  Sim = Sim
or'  _   _  = Nao

--not' : idem aos anteriores, porém usando o not lógico.
not' :: Pergunta -> Pergunta
not' Sim = Nao
not' Nao = Sim


--3.2) Faça o tipo Temperatura que pode ter valores Celsius ,Farenheit ou Kelvin . Implemente as funções:
data Temperatura = Celcius | Farenheit | Kelvin deriving Show
--converterCelsius : recebe um valor double e uma temperatura, e faz a conversão para Celsius.
converterCelsius :: Double -> Temperatura -> Double
converterCelsius x Farenheit = (x - 32) * 5/9
converterCelsius x Kelvin = x - 273.15
--converterKelvin : recebe um valor double e uma temperatura, e faz a conversão para Kelvin.
converterKelvin :: Double -> Temperatura -> Double
converterKelvin x Farenheit = x * 1.8 - 459.67
converterKelvin x Celcius = x + 273.15
--converterFarenheit : recebe um valor double e uma temperatura, e faz a conversão para Farenheit.
converterFarenheit :: Double -> Temperatura -> Double
converterFarenheit x Kelvin = (x - 32)/1.8 + 273.15 
converterFarenheit x Celcius = (x - 32) * 5/9

--3.3) Implemente uma função que simule o vencedor de uma partida de pedra, papel e tesoura usando tipos criados. Casos de
--empate devem ser considerados em seu tipo.
data Jogada = Pedra | Papel | Tesoura
data Resultado = Jogador1 | Jogador2 | Empate deriving Show
jokenpo :: Jogada -> Jogada -> Resultado
jokenpo Pedra Pedra = Empate
jokenpo Tesoura Tesoura = Empate
jokenpo Papel Papel = Empate
jokenpo Pedra Papel = Jogador2
jokenpo Pedra Tesoura = Jogador1
jokenpo Papel Pedra = Jogador1
jokenpo Tesoura Pedra = Jogador2
jokenpo Tesoura Papel = Jogador1
jokenpo Papel Tesoura = Jogador2

--3.4) Faça uma função que retorne uma string, com todas as vogais maiúsculas e minúsculas eliminadas de uma string passada
--por parâmetro usando list compreenshion.
noVogais :: String -> String
noVogais str = [x | x<-str, x/='A', x/='E', x/='I', x/='O', x/='U', x/='a', x/='e', x/='i', x/='o', x/='u']

-- 3.5) Sabe-se que as unidades imperiais de comprimento podem ser Inch , Yard ou Foot (há outras ignoradas aqui). Sabe-se
-- que 1in=0.0254m , 1yd=0.9144m , 1ft=0.3048m. Faça a função converterMetros que recebe a unidade imperial e o valor
-- correspondente nesta unidade. Esta função deve retornar o valor em metros.
data UnidadeImperial = Inch | Yard | Foot deriving Show
valor :: UnidadeImperial -> Double
valor Inch = 0.0254
valor Yard = 0.9144
valor Foot = 0.3048
converterMetros :: UnidadeImperial -> Double -> Double
converterMetros u x = x * valor u

-- Implemente também a função converterImperial , que recebe um valor em metros e a unidade de conversão. Esta função
-- deve retornar o valor convertido para a unidade desejada.
converterImperial :: UnidadeImperial -> Double -> Double
converterImperial u x = x/valor u 