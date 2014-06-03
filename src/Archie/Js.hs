module Archie.Js (
  JSRenderable) where

import Archie.Types

class JSRenderable a where
  js :: a -> String
