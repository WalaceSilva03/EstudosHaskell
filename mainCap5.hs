{-# LANGUAGE UndecidableInstances #-}
{-# OPTIONS_GHC -Wno-noncanonical-monoid-instances #-}
import qualified Control.Monad.RWS as Data

--5.1) Crie o tipo TipoProduto que possui os values constructors Escritorio , Informatica , Livro , Filme e Total. 
--O tipo Produto possui um value constructor - de mesmo nome - e os campos valor ( Double ), tp ( TipoProduto )
--e um value constructor Nada , que representa a ausência de um Produto .

--Deseja-se calcular o valor total de uma compra, de modo a não ter nenhuma conversão para inteiro e de forma combinável. Crie
--uma instância de monoide para Produto , de modo que o retorno sempre tenha Total no campo tp e a soma dos dois produtos
--em valor . Explique como seria o exercício sem o uso de monoides. Qual(is) seria(m) a(s) diferença(s)?

data TipoProduto = Escritorio | Informatica | Livro | Filme | Total deriving (Show, Eq)
data Produto = Produto { valor :: Double, tp :: TipoProduto} | Nada deriving (Show, Eq)

instance Monoid Produto where
    mempty = Nada

instance Semigroup Produto where
    (<>) Nada p = p
    (<>) p Nada = p
    (<>) (Produto v1 _) (Produto v2 _) = Produto (v1 + v2) Total


-- 5.2) Crie uma função totalGeral que recebe uma lista de produtos e retorna o preço total deles usando o monoide anterior.

totalGeral :: [Produto] -> Produto
totalGeral = mconcat

--5.3) A função min no Haskell retorna o menor entre dois números, por exemplo, min 4 5 = 4 .
--Crie um tipo Min com um campo inteiro, que seja instância de Ord , Eq e Show (deriving).
--Crie uma instância de Monoid para Min ( maxBound representa o maior inteiro existente no Haskell).
--Quanto vale a expressão Min (-32) <> Min (-34) <> Min (-33) ?
--Explique sua escolha para o mempty

newtype Min = Min Int deriving (Show, Eq, Ord)

instance Semigroup Min where
    Min x <> Min y = Min (min x y)

instance Monoid Min where
    mempty = Min maxBound


