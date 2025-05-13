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