module Actions (Action(..)) where

type Action =
  ResizeWindow (Int, Int) |
  MoveMouse (Int, Int) |
  TriggerMouse |
  TriggerKeyboard Char
