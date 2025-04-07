
-- Capitulo 3
-- Declarando novos tipos de dados

-- Uma possibilidade de criar novos tipos no Haskell é utilizando a palavra reservada data

data Dia = Segunda | Terca | Quarta | Quinta | Sexta | Sabado | Domingo
-- Lê se que o novo tipo Dia possuirá value contructors Segunda ou terça ou quarta
-- ou quinta ou sexta ou sabádo ou Domingo fazendo com que o | seja igual a "ou".

--Os values Constructors são valores assumidos pelos tipos (Chamados também de Data Constructors)
--Se usarmos :t no GHCi, é possível enxergar o tipo de cada value Construtor:
--Prelude> :t Segunda
--Segunda :: Dia

-- É possível criar funções com o novo tipo criado
agenda :: Dia -> String
agenda Domingo = "Tv..."
agenda Sabado = "Festa"
agenda _ = "Trabalho"
-- Este exemplo toma como parÂmetro o dia e retorna um String que representa a tarefa
-- Determinada pela agenda


-- Pattern Matching

--Sempre que desejarmos enxergar partes de um tipo em determinado ponto do programa
-- usamos o pattern matching. Esta tecnica permite a inspeção de partes menores de um value constructor
-- contra o padrão determinado pelo programador

-- Vamos analisar, no exemplo a seguir, o tipo (Int, Int), que é uma tupla com um inteiro em cada coordenada
-- Serão listadas algumas combinações válidas deste tipo, na entrada de uma função qualquer f:
f :: (Int, Int) -> Int
f (0,0) = 0
f (0,1) = 1
f (1,0) = 1
f (x,0) = x
f (0,y) = y
f (x,y) = x+y

-- (0, 0) - Valores fixos em ambas as coordenadas;
-- (x, 0) - Valor variável na primeira e fixo na segunda;
-- (0, y) - Valor fixo na primeira e variável na segunda;
-- (x, y) - Valores variáveis em ambas coordenadas (Devem possuir nomes diferentes)

h :: [Int] -> Int
h [] = 0
h (_:[]) = 1
h (_:x:[]) = 2+x
h (x:y:z:[]) = 3+x+y+z
h (x:_:_:w:[]) = 4+x+w
h (x:xs) = x



-- Campos de um Constutor

-- Todo Value Constructor pode possuir campos.

data Pessoa = Fisica String Int | Juridica String
-- O tipo pessoa possui dois valores constructos: Fisica, que possui dois campos
-- E juridica, que possui apenas um.

-- O conceito de chamar uma função com menos argumentos do que o esperado é chamado de currying.

--Vamos criar uma função teste que recebe uma Pessoa como parâmetro, e esta retornará uma tupla contendo duas Strings, informando nome e idade.
-- No caso de Pessoa do tipo Fisica, a função retornará uma mensagem que mostra o nome da primeira coordenada, assim como a idade na segunda.
-- No caso da pessoa Juridica, será mostrado o nome da primeira coordenada e uma mensagem informando que não há o campo idade na segunda.

teste :: Pessoa -> (String, String)
teste (Fisica x y) = ("Nome: " ++ x, "Idade: " ++ show y)
teste (Juridica x) = ("Nome: " ++ x, "Não há idade")


-- RECORD SYNTAX

-- Outra forma de declarar novos tipos é o Record Syntax, o uso do Record Syntax permite extrair os valores contidos no campo da mesma maneira que um getter da programação orientada a objetoos

--O seu uso é simples. Apenas daremos nomes aos campos que os values construtors carregam e só
--data Ponto = Ponto Double Double
--Utilizando a Record Syntax pode ser escrito assim:
data Ponto = Ponto {xval, yval :: Double}
-- A vantagem é a semântica do fato dos campos terem nomes. Outro ponto positivo é que cada nome dado também pode ser usado como função
-- de projeção de valores.

-- para fazer uma função que calcula a distância do ponto à origem, podemos proceder de três formas.
-- 1. Primeira forma

--distOrig :: Ponto -> Double
--distOrig (Ponto x y) = sqrt(x**2 + y**2)

-- 2. Segunda forma

--distOrig :: Ponto -> Double
--distOrig (Ponto {xval=x, yval=y}) = sqrt(x**2 + y**2)

--3. Segunda forma

--distOrig :: Ponto -> Double
--distOrig p = sqrt(xval p**2, yval p**2)


-- As duas primeiras maneiras usam o Pattern matching para enxaixar os parâmetros x e y no padrão que possui o tipo Ponto.
-- Já a última usa o xval e yval, funções de projeção adquiridas no uso do record Syntas


-- EXERCÍCIOS

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
