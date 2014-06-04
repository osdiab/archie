module Archie (
    renderCss,
    renderJs
    ) where

import Archie.Types
import Archie.Css
import Archie.Js

renderCss :: Stylesheet -> String
renderCss stylesheet = css stylesheet

renderJs :: Stylesheet -> String
renderJs stylesheet = js stylesheet
