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

