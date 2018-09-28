{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module HackingMonadError where

import Control.Monad.Except    

data MyEither e a = MyLeft e | MyRight a deriving (Eq, Show)  
data ArithmeticError = DivisionByZero | NotDivisible Int Int deriving (Eq, Show)

safe_divide :: Int -> Int -> MyEither ArithmeticError Int
safe_divide x 0 = MyLeft DivisionByZero
safe_divide x y | x `mod` y /= 0 = MyLeft $ NotDivisible x y
safe_divide x y = MyRight $ x `div` y

instance Functor (MyEither e) where 
    fmap f (MyRight a) = MyRight $ f a
    fmap _ (MyLeft e)  = (MyLeft e)    


instance Applicative (MyEither e) where
    pure = MyRight

    (MyRight f) <*> (MyLeft e) = MyLeft e
    (MyRight f) <*> (MyRight a) = MyRight (f a)    

instance Monad (MyEither e) where 
    return = MyRight

    (MyLeft e) >>= f = MyLeft e
    (MyRight a) >>= f = f a

instance MonadError ArithmeticError (MyEither ArithmeticError) where
    throwError = MyLeft

    catchError (MyLeft e) f = f e
    catchError (MyRight r) f = MyRight r

handleDivisionErrors :: ArithmeticError -> MyEither ArithmeticError Int
handleDivisionErrors (NotDivisible x y) = return $ x `div` y
handleDivisionErrors e = throwError e

divide :: Int -> Int -> MyEither ArithmeticError Int
divide x y = (x `safe_divide` y) `catchError` handleDivisionErrors
