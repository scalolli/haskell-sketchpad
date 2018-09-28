module HackingStateMonad where

import Control.Monad.State
import Control.Applicative (liftA2)
import System.Random

data Die =
         DieOne
      |  DieTwo
      |  DieThree
      |  DieFour
      |  DieFive
      |  DieSix
      deriving (Eq, Show)

intToDie :: Int -> Die
intToDie n =
      case n of
        1 -> DieOne
        2 -> DieTwo
        3 -> DieThree
        4 -> DieFour
        5 -> DieFive
        6 -> DieSix
        x -> error $ "Cannot map " ++ show x ++ " to Die"

clumsyRollDice :: (Int, Int)
clumsyRollDice = (n, m)
        where
            (n, g) = randomR (1, 6) (mkStdGen 0)
            (m, _) = randomR (1, 6) g


rollDie :: State StdGen Die
rollDie = intToDie <$> state (randomR (1, 6))

rollTwice :: State StdGen (Die, Die)
rollTwice = liftA2 (,) rollDie rollDie

data Canvas  = ActiveCanvas | EmptyCanvas deriving (Eq, Show)
data ReplState = Continue | Stop deriving (Eq, Show)

runCommand :: Canvas -> (ReplState, Canvas)
runCommand = undefined

runRepl :: State Canvas (IO ReplState)
runRepl = do
    replState <- state $ (\c -> (getCommand, c))
    return replState

getCommand :: IO ReplState
getCommand = do
    line <- getLine
    return $
        if (line == "basu")
         then Continue
         else Stop








