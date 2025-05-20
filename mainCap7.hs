import Control.Monad
--7.1) Faça uma instância de Functor para o tipo Coisa, definido no início do capítulo 5.
--A	função g deve "ir para dentro" em todas	as coordenadas de Coisa. No caso de ZeroCoisa, o fmap deve retornar ZeroCoisa.

data Coisa a = UmaCoisa a | DuasCoisas a a | ZeroCoisas deriving (Show, Eq)

instance Functor Coisa where
    fmap g (UmaCoisa a) = UmaCoisa (g a)
    fmap g (DuasCoisas a b) = DuasCoisas (g a) (g b)
    fmap _ ZeroCoisas = ZeroCoisas

-- 7.2)	Aproveitando o exercício anterior, faça uma instância de Applicative Functor para o tipo Coisa.

instance Applicative Coisa where
    pure = UmaCoisa
    (UmaCoisa a) <*> (UmaCoisa b) = UmaCoisa (a b)
    (UmaCoisa a) <*> (DuasCoisas x y) = DuasCoisas (a x) (a y)
    (DuasCoisas x y) <*> (UmaCoisa a) = DuasCoisas (x a) (y a)
    (DuasCoisas a b) <*> (DuasCoisas x y) = DuasCoisas (a x) (b y)
    _ <*> ZeroCoisas = ZeroCoisas
    ZeroCoisas <*> _ = ZeroCoisas

-- 7.3)	Crie	a	função		mult234	 ::	 Double	 ->	 Coisa	 Double	
-- que	multiplica	por	2	a	primeira	coordenada,	por	3	a	segunda,	e	por
-- 4	 a	 terceira.	 Use	 a	instância	 de	 	Applicative		feita	 no	 exercício anterior.

mult234 :: Double -> Coisa Double
mult234 x = DuasCoisas (2*) (3*) <*> UmaCoisa x

--7.4)	 Escreva	 uma	 instância	 para	 	Functor		 e	 	Applicative	
-- para	o	tipo		Arvore	,	visto	no	capítulo	5.

data Arvore a = Nulo | Leaf a | Branch a (Arvore a) (Arvore a) deriving Show

instance Functor Arvore where
    fmap _ Nulo = Nulo
    fmap g (Leaf a) = Leaf (g a)
    fmap g (Branch a b c) = Branch (g a) (fmap g b) (fmap g c)

instance Applicative Arvore where
    pure = Leaf
    _ <*> Nulo = Nulo
    Nulo <*> _ = Nulo
    Leaf a <*> Leaf b = Leaf (a b)
    Leaf a <*> Branch x y z = Branch (a x) (fmap a y) (fmap a z)
    Branch x y z <*> Leaf a  = Branch (x a) (y <*> Leaf a) (z <*> Leaf a)
    Branch x y z <*> Branch a b c = Branch (x a) (y <*> b) (z <*> c)

-- 7.5)	 Escreva	 uma	 instância	 de	 	Functor		 para	 o	 tipo	 	data Fantasma	a	=	Fantasma.

data Fantasma a = Fantasma

instance Functor Fantasma where
    fmap _ Fantasma = Fantasma


-- 8.1> Faça umm tipo Caixa com type parameter a e três construtores chamados Um, Dois e Tres possuindo um, dois e três campos de tipo a, respectivamente
-- Faça uma instâcnia de Functor para o tipo Caixa. A função deve ser apliada em todas as coordenadas dos valores (Um, Dois ou Tres)
-- Crie uma instâcnia de Monad para o tipo Caixa. Seu return deve ser o value constructor Um..
-- Um: o único campo entra na função (análogo ao maybe)
-- Dois: o segundo campo entra
-- Tres: o terceiro campo entra

data Caixa a = Um a | Dois a a | Tres a a a deriving (Show, Eq)

instance Functor Caixa where
    fmap g (Um a) = Um (g a)
    fmap g (Dois a b) = Dois (g a) (g b)
    fmap g (Tres a b c) = Tres (g a) (g b) (g c)

instance Monad Caixa where
    return = Um
    Um a >>= f = f a
    Dois _ b >>= f = f b
    Tres _ _ c >>= f = f c

instance Applicative Caixa where
    pure = return
    (<*>) = ap

-- 8.2) Crie uma função mult234:: DOuble -> Caixa Double que receba uma paâmetro xe devolva o dobro de x na primeira coordenada
-- o triplo na segunda e o quádrupo na terceira usando o operaddor >>=

mult234' :: Double -> Caixa Double
mult234' x = Um x >>= \v -> (Tres (2*v) (3*v) (4*v))

--8.3)
--Tres	1	2	3	>>=	mult234	>>=	mult234	 
-- RESPOSTA: 24 36 48

-- Dois 2 4 >>= mult234
--RESPOSTA: 8 12 16

--kind: Coisa
--RESPOSTA: * -> *

--Dois 2 3 >>= \_ -> Dois 7 7
--RESPOSTA: Dois 7 7

--8.4)	 Faça	 um	 exemplo,	 usando	 a	 notação		do	,	 de	 um	 trecho
--qualquer	de	código	usando	sua		Monad	Caixa	.

mult234'' :: Double -> Caixa Double
mult234'' x = do
    v <- Um x
    Tres (v*2) (v*3) (v*4)


-- Exercícios 9.5
-- 9.1	Faça	um	programa	que	faça	o	usuário	digitar	um	número, e	mostre	na	saída	padrão	se	ele	é	par	ou	ímpar.

main :: IO()
main = do
    putStrLn "Digite um número para sabermos se ele é par ou impar"
    x <- readLn
    if even x then do
        print "Par"
    else
        print "Impar"

-- 9.2)	 Faça	 um	 programa	 que	 mostre	 uma	 palavra	 em	 ordem reversa	a	partir	de	uma	digitada	pelo	usuário.

mainEx2 :: IO()
mainEx2 = do
    putStrLn "Digite uma palavra para a revertermos"
    y <- getLine
    print $ reverse y

-- 9.3)	Baseando-se	no	exemplo	5,	faça	um	jogo	de	Pedra,	Papel	e Tesoura.

data Resultado = Vencedor | Perdedor | Empate deriving (Show)

data Jogada = Pedra | Papel | Tesoura deriving (Show, Eq, Enum)

mainEx3 :: IO()
mainEx3 = do
    let acertou True = Vencedor
        acertou False = Perdedor
        acertou _     = Empate
    JogadaCPU <- return [CPUescolha x | x<- [Pedra .. Tesoura]]
    EscolhaCPU <- randomRIO (1, length JogadaCPU)
    Jogada <- return $ JogadaCPU !! EscolhaCPU
    putStrLn "Digite uma jogada de Pedra, Papel ou Tesoura"
    EscolhaPlayer <- readLn
    putStrLn $ "Sua escolha foi " ++ Show (EscolhaPlayer)
    putStrLn $ acertou $ Jogada == EscolhaPlayer