module Inputs (inputs) where

import Time     exposing (every, second)
import Window   exposing (dimensions)
import Mouse    exposing (position, clicks)
import Keyboard exposing (presses)
import Char     exposing (fromCode)
import Signal   exposing (map)

import Actions  exposing (Action(..))

inputs : List (Signal Action)
inputs =
  [
    map ResizeWindow dimensions,
    map MoveMouse position,
    map (always TriggerMouse) clicks,
    map (fromCode >> TriggerKeyboard) presses
  ]
