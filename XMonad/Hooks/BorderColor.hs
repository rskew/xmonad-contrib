-----------------------------------------------------------------------------
-- |
-- Module       : XMonad.Hooks.BorderColor
-- Copyright    : (c) Rowan Skewes <rowan.skewes@gmail.com>
-- License      : BSD
--
-- Maintainer   :  none
-- Stability    :  unstable
-- Portability  :  unportable
--
-- This module provides an event handler that updates a window's border color
-- on focus changes.
-- Unlike the noble path taken in https://github.com/dschoepe/qubes-xmonad
-- where the core border color behaviour is updated for Qubes OS, this module
-- is a rough hack at implementing the functionality as an extension.
-- This required attaching the border color updates to an event that
-- seems to correlate with focus changes, but is not fully understood.
-- This event has X11 atom code 352, which is not even documented
-- in the xorg-server source:
-- - https://github.com/freedesktop/xorg-xserver/search?q=391&unscoped_q=352

module XMonad.Hooks.BorderColor where

import           Data.Monoid
import           GHC.Word                            (Word64)
import           XMonad
import qualified XMonad.StackSet                     as W

magicNumberEventAtom :: Word64
magicNumberEventAtom = 352

borderColorEventHook :: Query String -> Event -> X All
borderColorEventHook getWindowColor event =
  if ev_atom event /= magicNumberEventAtom
  then return mempty
  else
    let
      w = ev_window event
      d = ev_event_display event
    in do
      c <- runQuery getWindowColor w
      withWindowSet $ \s ->
        if W.peek s == Just w
        then do
          ~(Just pc) <- io $ initColor d c
          io $ setWindowBorder d w pc
        else do
          -- TODO increase opacity or darkness for unfocused windows
          ~(Just pc) <- io $ initColor d c
          io $ setWindowBorder d w pc
      return mempty
