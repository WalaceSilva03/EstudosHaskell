-- Capitulo 4 - Um pouco mais sobre funções

--Em programação funcional, funções são tratadas como valores comuns, assim como 5 é Int ou "Olá" é uma String . Ou 
--seja, funções podem ser passadas como parâmetro e retornadas por outras funções.

--Além disso, se uma função espera três parâmetros e você passar dois, não há problema algum nisso. Podemos inclusive criar
--funções sem um corpo, como vimos até o presente momento.

-- LAMBDAS ----------------------------
-- Funções podem ser usadas como valores e não necessariamante em um contexto explícito, como fizemos até aqui. Por exemplo,
-- Não é preciso declarar a função em um contexto para usá-la. Em vez disso, é possível usá-la naturalmente como se estivessem declaradas.
-- De uma maneira geral, lambdas têm a seguinte forma:

-- \p1 p2 p3 p4 ... pn -> EXPR(p1, p2, p3 ..., pn)

--Isto pode ser lido como: receba os parâmetros p1, p2, p3, p4, ..., pn, e devolva uma expressão que dependa destes n parÂmetros

--Prelude> (\x -> 2*x) 4
--8

--Ele indica que estamos usando um lambda que recebe um parâmetro x e devolve o dobro dele mesmo.
--Uma função lambda só pode ser usada em contextos lcoais.

--Prelude> (\x xs -> x : reverse xs) 'A' "UOIE"

-- Este recebe um elemtno  e uma lista de elementos xs, devolvendo o primeiro elemento na frenta da lista xs em ordem reversa


-- Funções em Alta Ordem
-- Como dito na introdução do presente capítulo, funções podem ser passadas como parâmetro ou retornar outras funções. Uma função que possua alguma
-- parâmetro oou retornar outras funções. Uma função que possua alguma das características citadas é dita como uma função de alta ordem, ou high-Order Function

ev :: (Int -> Int) -> Int
ev f = 1 + f 5

-- isto é uma função de alta ordem. O tipo de ev :: (Int -> Int) -> Int consiste em uma entrada do tipo Int -> Int e uma saída inteira
-- os parênteses indicam que a entrada tem um tipo de uma função em vez de dois inteiros

--A expressão de ev pode ser em um primeiro momento esquisita, porém é de fácil entendimento. Ela significa: calcule a função f, que foi recebida como argumento, ao valor 5 e depois some 1. Considere as funções auxiliares:

dobro :: Int -> Int
dobro x = 2*x

triplo :: Int -> Int
triplo x = 3*x

-- Tal chamada nos mostra que, primeiramente, a função dobro foi argumento de ev e depois Triplo. Vamos analisar de perto o que aconteceu com a primeira
-- ev dobro = 1 + dobro 5 = 1 + 2*5 = 1 + 10 = 11

-- A função dobro foi plugada em f, assim, ela é chamda como argumento 5, resultando em 10 como retorno. Nesse retorno foi somado 1 ao final, dando 11.
-- Exemplos de funções que retornam outras terão mais sentido nas seções seguintes e serão suprimidos no momento.

-- Note que é possível usar lambdas em vez das funções dobro e triplo, como segue:
-- Prelude> ev (\x -> 2*x)
-- 11
-- Prelude> ev (\x -> 3*x)
--16

-- Escrevendo desta maneira, é permitido uma maior produtividade, pois, não será necessário escrever o corpo das funções e recarregar o módulo novamente.

-- CURRYING -----------------------------------
-- Currying é uma técnica que consistem em transformar a chamada de uma função (Retorno valorado), que recebe múltiplos argumentos, em uma avaliação de uma sequência de funções.
-- Você pode fixar uma quantidade de argumentos e deixar o restante variável

somarTresNum :: Int -> Int -> Int -> Int
somarTresNum x y z = x + y + z

somarCurr :: Int -> Int
somarCurr = somarTresNum 4 5

-- A função somarCurr possui fixo os parâmetros x e y da função somarTresNum, deixando z Livre para variar. Portanto, podemos inspecionar o tipo de somarCurr
-- Prelude> :t somarCurr
-- somarCurr :: Int -> Int

-- Como esperado, o tipo de somarCurr é Int, pois, apenas uma variável foi mantida livre na definição de somarCurr. 
-- O interessante é que podemos agrupar as últimas duas flechas susando parênteses no tipo de somarTresNum. Veja

-- somarTresNum :: Int ->Int -> (Int -> Int)

-- Fazneod isso, fica claro que, a partir da função somarTresNum, se passarmos dois argumentos a ela, o retorno será uma função de um parâmetro Int e seu retorno Int, fazendo com que
-- Ela se torne de alta ordem. Sempre que houver parênteses encobrindo flechas e tipos, consideraremos que o parÂmetro ou o retorno é uma função.

-- Em suma, sempre que uma função tiver algum parâmetro suprimido, o retorno será uma função. Esta possuirá como 
-- parâmetro todas as variáveis livres, e sua avaliação levará em conta todos os parâmetros que foram deixados fixos e os que ficaram
-- livres também.

-- EXEMPLOS DE FUNÇÕES DE ALTA ORDEM

-- FUNCAO MAP
-- A função map tem como objetivo aplicar uma função f, recebida via parâmetro, a todos os elementos de uma lista l ,
-- também recebida via parâmetro. O retorno desta função é uma nova lista, na qual seus elementos são as saídas da função f ,
-- tendo como argumento os elementos da lista.

-- Prelude > :t map
-- map :: (a -> b) -> [a] -> [b]

-- O tipo de entrada da lista deve ser o mesmo tipo da entrada da função e o tipo da saída será o mesmo da saída da função. Usando
-- o conceito de currying e funções de alta ordem, podemos enxergar o map como:

-- map :: (a -> b) -> ([a] -> [b])

-- Ao suprimir a lista de tipo [a] , como parâmetro da função map , o retorno obtido é uma função do tipo [a] -> [b] . Ou
-- seja, sua função foi levantada de a -> b para [a] -> [b] , isto é, a função que inicialmente trabalhava com estruturas simples passa
-- agora a trabalhar com listas.

-- Prelude map (+2) [1..5]
-- [3, 4, 5, 6, 7]

-- Neste exemplo, a função map recebe via parâmetro a função (+2) , que é um currying da função (+) , tendo o valor 2 fixo
-- em seu segundo argumento, e distribui essa função a todos os elementos da lista [1,2,3,4,5] . Assim, é efetuado: 1+2 , 2+2 ,
-- 3+2 , 4+2 e 5+2 . Note que o uso do map se assemelha ao list compreeshion visto no primeiro capítulo

-- FUNCAO FOLDL
-- Para a função foldl , devem ser passados uma função f com dois parâmetros e também um valor inicial. Essa função dobra a
-- lista começando da esquerda, isto é, a função f é aplicada ao valor inicial e ao primeiro elemento da lista. O retorno dela mais o
-- segundo elemento devem ser os parâmetros para a nova aplicação de f até acabarem os elementos da lista. Você pode pensar que a
-- função foldl se comporta como um acumulador se comparada ao paradigma imperativo.

-- Prelude > :t foldl
-- foldl :: (b -> a -> b) -> b -> [a] -> b

-- O primeiro parâmetro (de foldl ) deve ser uma função na qual sua primeira entrada seja o mesmo tipo b que o valor inicial
-- (segundo parâmetro de foldl ), e sua segunda entrada com o mesmo tipo a dos elementos contidos na lista do terceiro
-- parâmetro (de foldl ).

-- Prelude> foldl (+) 0 [1..4]
-- Prelude> 10

-- A função soma (+) terá como parâmetro o valor inicial 0 e o primeiro valor da lista 1 . A função soma será aplicada a estes
-- dois parâmetros, resultando em 1. O valor 1 do acúmulo ( 0+1 ) será um novo parâmetro, junto com o valor 2 da lista, e ambos
-- sofrerão a aplicação da soma novamente, resultando em 3 . Esse valor 3 , juntamente com o valor 3 da lista, sofrerá a aplicação de
-- (+) novamente, resultando em 6 . O valor 6 e o elemento 4 da lista sofrerão pela última vez a aplicação de (+) , resultando em 10 .

--(+) 0 1 [2, 3, 4]
--(+) 1 2 [3, 4]
--(+) 3 3 [4]
--(+) 6 4 []
--10

-- Note que em haskell, 0 + 1 é a versão infixa de (+) 0 1, e ambas produzem o mesmo valor, 1
--Prelude> foldl (\xs x -> x:xs) [] ''Fatec''
--''cetaF''

-- Observe que (\xs x-> x : xs ) é um lambda, que nada mais é do que uma função sem corpo. Esta função recebe uma lista
-- xs e um valor x , e retorna o elemento x inserido à frente da lista xs .

--FUNCAO FILTER
-- O filter é uma função que recebe uma outra função f de retorno booleano e uma lista de elementos. Ele retorna uma outra
-- lista contendo os elementos que foram argumentos de f e que tiveram True como retorno.

-- filter(>0) [-4..4]
-- [1,2,3,4]

--Neste exemplo, é filtrado todos os elementos maiores que zero. A função recebida (>0) se equivale ao lambda \x-> x > 0 , que
--recebe um valor x . Este retorna True caso seja maior que zero, e False caso contrário. Os elementos [1,2,3,4] são todos que
--satisfazem a condição da função (>0) e, no caso, são retornados pela função filter.

--Prelude> filter
--filter :: (a -> Bool) -> [a] -> [a]

--O tipo da função filter nos diz que a função do primeiro parâmetro precisa retornar uma expressão booleana. A entrada da
--função do primeiro parâmetro deve ter um tipo a , que deve ser o mesmo tipo dos elementos do segundo parâmetro, de tipo [a].

--Funcao.
-- A composição de funções, introduzida no segundo capítulo, é uma noção muito importante em programação funcional e merece
-- toda atenção aqui nesta seção. A composição de funções é algo cotidiano na vida do programador. É o simples ato de chamar duas
-- funções, ou mais, sendo que o retorno de uma é o argumento da outra.

-- Para acompanhar os exemplos a seguir, vamos considerar as funções:
--traseira :: String -> String
--traseira [] = []
--traseira (x:xs) = xs

-- contar :: String -> Int
-- contar length

--primeira função retorna uma lista vazia, caso o argumento seja vazio, e o fim da lista xs , caso o argumento tenha pelo menos
--um elemento (ignorando assim o primeiro elemento e devolvendo o resto). A função contar é apenas uma renomeação da função
--length , que conta elementos de uma lista de qualquer tipo. Nesse caso, deixamos a entrada como String por questões
--didáticas.

--Na expressão contar(traseira "Haskell") , a função traseira será executada em um primeiro momento e terá como
--retorno "askell" . Após este passo, obtemos a chamada contar "askell" - note que o retorno de traseira é o argumento de
--contar - que produzirá o retorno 6 .

--O exemplo parece simples, porém, na programação funcional, tem um motivo teórico muito bem fundamentado. Antes de
--continuar, note que contar(traseira "Haskell") se equivaleria a contar(traseira("Haskell")) , que é um estilo 
--corriqueiro nas linguagens de programação imperativa.

-- A função pode ser melhorada utilizando a função infixa . (ponto)

--Prelude> (contar. traseira) "Haskell"
--6

-- Esta função é de alta ordem, por conta do seu tipo

-- Prelude> :t (.)
-- (.) :: (b -> c) -> (a -> b) -> (a -> c)

--Ela diz o seguinte: essa função recebe duas outras de tipos (b -> c) e (a -> b) , retornando uma outra de tipo (a -> c) .
--Note que a , b e c são qualquer tipo da linguagem ( Int , Double , [Int] , String , (Int, String) etc.).

--Retomando a frase "o retorno de uma função deve ser o argumento da outra", é possível ver que o tipo incumbido de
--realizar esta façanha é o b , pois é a saída do segundo parâmetro de tipo (a -> b) e a entrada do primeiro parâmetro de tipo (b
-- -> c) . Portanto, o tipo da função composta (retorno de . ) se dá pela entrada da primeira função a e pela saída da segunda c .

--Vamos analisar agora o exemplo da expressão (contar . traseira) "Haskell" :

--Prelude> :t traseira
-- tail' :: String -> String
--Prelude :t contar
-- contar :: String -> Int

-- FUNCAO $

--A função infixa $ recebe uma função e um valor, e aplica a função neste valor. Veja um exemplo:
--Prelude> contar $ "Ola"
--3

-- Aparentemente, não há diferença alguma com uma chamada de função simples:
-- Prelude> contar "Ola"
--3

-- Porém, a diferença está quando usamos os parênteses para dar prioridade nas operações. Quando calculamos o tamanho de uma
-- lista usando a concatenação, devemos, por exemplo, usar parênteses:

-- Prelude> contar ("ola" ++ "Alo")
-- 6

-- Fazemos isso para indicar que a concatenação será efetuada e seu retorno entrará na função contar 

-- A função $ é uma maneira fácil de se livrar da poluição causada pelo uso excessivo de parênteses - como é habitual em
-- muitas linguagens -, deixando o código mais claro
-- Prelude> contar $ "ola" ++ "Alo"
-- 6

--Como $ possui uma precedência à direita maior que ++ ,primeiro será calculado "Ola" ++ "Alo" , e depois contar
--"OlaAlo" , retornando 6 . Inspecionando o tipo de $ , podemos ver:

--Prelude> :t ($)
-- ($) :: (a -> b) -> a -> b

--Ela recebe uma função que recebe uma função de tipo a e retorno b , e um valor de tipo a devolvendo um valor de tipo b .
--Em nosso exemplo, o primeiro argumento de $ é a função contar . Desta forma, a é uma String e b um Int , pois o
--tipo de contar é String -> Int . Já o segundo argumento é a String "OlaAlo" , tendo 6 como retorno e este do tipo Int .

--  SINTAXE EM FUNÇÕES

--Os guards são uma maneira de testar várias condições em uma função, de maneira similar a um if encadeado. Por exemplo, se
--quisermos calcular o IMC de uma pessoa e, a partir deste valor, mostrar uma mensagem na tela indicando se ela está acima do
--peso ou não, é possível usando guards. Podemos escrever as condições de uma maneira limpa.

imc p a
 | p/ (a*a) <= 18.5 = "Abaixo do peso"
 | p/ (a*a) <= 25.0 = "Peso Ideal"
 | p/ (a*a) <= 30 = "Acima do peso"
 | otherwise = "Obesidade"

--Um possível tipo da função anterior é Double -> Double -> Double . Os parâmetros p e a representam peso e altura. A
--expressão p/(a*a) representa o cálculo do IMC. A partir deste cálculo, as condições são verificadas em ordem até que alguma seja
--True e o retorno da função (mensagem) será executada. Caso a condição seja False , a próxima condição será
--verificada até chegar ao otherwise , que sempre será True . A cláusula where pode ajudar a facilitar a escrita da função de IMC.

imc2 p a
 | valorImc <= 18.5 = "Abaixo do peso"
 | valorImc <= 25.0 = "Peso Ideal"
 | valorImc <= 30 = "Acima do peso"
 | otherwise = "Obesidade"
 where
    valorImc = p/(a*a)

--O uso do where ajuda a não escrever a expressão p/(a*a) em toda condição. Note que, para cada padrão do pattern
--matching, é possível ter guards próprios.

-- Recursao


-- Exercicios

-- 4.1) Faça uma função que retorne a média de um [Double], usando foldl.
ex41 :: [Double] -> Double
ex41 xs = foldl (\count x -> count + x) 0 xs / (foldl (\ count _ -> count + 1.0) 0 xs)
-- Primeiro o programa recebe como parâmetro uma lista de Double e retorna uma número Double, a média.
-- Após isso, é utilizando um foldl para iterar no cálculo lambda
-- Foldl (\count x -> count + x) 0 xs = É utilizado um foldl que inicia em 0 e vai somando ao acumulador count para cada elemento x que vai para a lista de xs

--4.2) Faça uma função que receba uma [String] e retorne todos os elementos palíndromos. Ver exercício 3.7
ex42 :: [String] -> [String]
ex42 xs = [x | x <- xs, x == reverse x]

--4.3) Implemente uma função que filtre os números pares e outra que filtre os ímpares de uma lista recebida via parâmetro.
ex43Pares :: [Int] -> [Int]
ex43Pares xs = filter (\x -> mod x 2 == 0) xs

ex43Impares :: [Int] -> [Int]
ex43Impares xs = filter (\x -> mod x 2 == 1) xs

--4.4) Filtre os números primos de uma lista recebida por parâmetro.
ex44 :: [Int] -> [Int]
ex44 xs = filter (\x -> length (filter (\y -> mod x y == 0) [1..x])==2) xs

--4.5) Implemente uma função que receba uma lista de inteiros e retorne o dobro de todos, eliminando os múltiplos de 4.
ex45 :: [Int] -> [Int]
ex45 xs = map (*2) (filter (\x -> mod x 4 /= 0) xs)

-- 4.6) Faça uma função func que receba uma função f de tipo (String -> String) , e uma String s que retorna o reverso
-- de s concatenado com aplicação da função f em s .