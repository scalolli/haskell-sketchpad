{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_haskell_sketchpad (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/basu/haskell/haskell-sketchpad/.stack-work/install/x86_64-osx/lts-11.5/8.2.2/bin"
libdir     = "/Users/basu/haskell/haskell-sketchpad/.stack-work/install/x86_64-osx/lts-11.5/8.2.2/lib/x86_64-osx-ghc-8.2.2/haskell-sketchpad-0.1.0.0-G5TRy3nU6jn2IWkghlFyGf"
dynlibdir  = "/Users/basu/haskell/haskell-sketchpad/.stack-work/install/x86_64-osx/lts-11.5/8.2.2/lib/x86_64-osx-ghc-8.2.2"
datadir    = "/Users/basu/haskell/haskell-sketchpad/.stack-work/install/x86_64-osx/lts-11.5/8.2.2/share/x86_64-osx-ghc-8.2.2/haskell-sketchpad-0.1.0.0"
libexecdir = "/Users/basu/haskell/haskell-sketchpad/.stack-work/install/x86_64-osx/lts-11.5/8.2.2/libexec/x86_64-osx-ghc-8.2.2/haskell-sketchpad-0.1.0.0"
sysconfdir = "/Users/basu/haskell/haskell-sketchpad/.stack-work/install/x86_64-osx/lts-11.5/8.2.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "haskell_sketchpad_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "haskell_sketchpad_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "haskell_sketchpad_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "haskell_sketchpad_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "haskell_sketchpad_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "haskell_sketchpad_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
