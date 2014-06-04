module Archie.Js (
  JSRenderable,
  js
  ) where

import Archie.Types

class JSRenderable a where
  js :: a -> String
