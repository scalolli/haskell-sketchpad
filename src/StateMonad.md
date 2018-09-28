#### When should we use State Monad?

Ideally used in games when we need to run a function which updates the state. 

For e.g: 

[Rolling Die](https://en.wikibooks.org/wiki/Haskell/Understanding_monads/State#Example:_Rolling_Dice)

`rollTwice = liftA2 (,) rollDie rollDie` 

[Another Tutorial](https://wiki.haskell.org/State_Monad#Complete_and_Concrete_Example_2)

Basically we use it when a function updates the state and we need to call the same function multiple times.

    getNext ::   MyStateMonad  Int
    
    inc3Sugared::MyStateMonad Int
    inc3Sugared = do x <- getNext        
                    y <- getNext
                    z <- getNext
                    return z


 