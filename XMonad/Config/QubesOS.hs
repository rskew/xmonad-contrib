{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

-----------------------------------------------------------------------------
-- |
-- Module       : XMonad.Config.QubesOS
-- Copyright    : (c) Rowan Skewes <rowan.skewes@gmail.com>
-- License      : BSD
--
-- Maintainer   :  none
-- Stability    :  unstable
-- Portability  :  unportable
--
-- This module provides a config suitable for use with Qubes OS.
-- Features implemented:
-- - border color reflects VM type

module XMonad.Config.QubesOS (
    -- * Usage
    -- $usage
    qubesOSConfig,
    ) where

import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.BorderColor

import qualified Data.Map as M

-- $usage
-- To use this module, start with the following @~\/.xmonad\/xmonad.hs@:
--
-- > import XMonad
-- > import XMonad.Config.QubesOS
-- >
-- > main = xmonad qubesOSConfig
--
-- For examples of how to further customize @qubesOSConfig@ see "XMonad.Config.Desktop".

qubesOSConfig = def
    { handleEventHook = borderColorEventHook qubesOSWindowColor
    }

qubesOSWindowColor :: Query String
qubesOSWindowColor = stringProperty "_QUBES_LABEL_COLOR"
