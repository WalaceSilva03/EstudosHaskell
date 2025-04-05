
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
--and' : recebe duas Perguntas como parâmetro e retorna a tabela verdade do and lógico, usando Sim como verdadeiro e Nao como falso.
--or' : idem ao anterior, porém deve ser usado o ou lógico.
--not' : idem aos anteriores, porém usando o not lógico.

data Pergunta = Sim | Nao

-- pergNum : recebe via parâmetro uma Pergunta .Retorna 0 para Nao e 1 para Sim .
pergNum :: Pergunta -> Int
pergNum Sim = 1
pergNum Nao = 0

--listPergs : recebe via parâmetro uma lista de Perguntas , e retorna 0 s e 1 s correspondentes aos constructores contidos na lista.
listPergs :: [Pergunta] -> Int
listPergs [Sim] = 1
listPergs [Nao] = 0

