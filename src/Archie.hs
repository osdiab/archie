-- TODO remove these somehow
{-# LANGUAGE GeneralizedNewtypeDeriving, TypeSynonymInstances, FlexibleInstances #-}

module Archie (Reference, ReferenceVal(..), JSValue, JSVal) where

import Clay.Property
import Clay.Selector
import qualified Data.Text as Text

newtype ReferenceVal = ReferenceVal Selector
  deriving (Show)
newtype Reference = Reference ReferenceVal
  deriving (Show, Val)

newtype JSValue = JSValue { unJSValue :: String }
  deriving (Show)

class JSVal a where
  valueJS :: a -> JSValue

instance Val ReferenceVal where
  value _ = value $ Literal $ Text.pack "inherit"

-- TODO replace the dummy "attr()" with a type for JS conversion
instance JSVal Reference where
  valueJS a = JSValue { unJSValue = show a ++ ".attr()" }
