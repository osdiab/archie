-- TODO remove these somehow
{-# LANGUAGE GeneralizedNewtypeDeriving, TypeSynonymInstances, FlexibleInstances #-}

module Archie (archie) where

import Clay
import qualified Data.Text as Text

newtype Reference = Reference Selector
  deriving (Show, Val)

newtype JSValue = JSValue { unJSValue :: String }
  deriving (Show)

class JSVal a where
  valueJS :: a -> JSValue

instance Val Selector where
  value _ = value $ Literal $ Text.pack "inherit"

-- TODO replace the dummy "attr()" with a type for JS conversion
instance JSVal Reference where
  valueJS a = JSValue { unJSValue = show a ++ ".attr()" }

archie :: IO ()
archie = return ()

