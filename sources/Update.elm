module Update (update) where

import Effects  exposing (Effects, none)
import List     exposing (map, filter, head)

import Model    exposing (Model)
import Size     exposing (Size, size)
import Position exposing (Position, position, distance)
import Kind     exposing (charKind)
import Country  exposing (charCountry)
import Unit     exposing (Unit, unit)
import Actions  exposing (Action(..))

(#) : (Int, Int) -> Size -> Position
(#) (x, y) size =
  {
    x = toFloat x / size.width,
    y = 1.0 - toFloat y / size.height
  }

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    ResizeWindow (width, height) ->
      (
        {
          model |
          size = size (width, height)
        },
        none
      )
    MoveMouse (x, y) ->
      (
        {
          model |
          position = (x, y) # model.size
        },
        none
      )
    TriggerMouse ->
      (
        case model.unit of
          Just unit ->
            {
              model |
              units = model.units ++ [{unit | position = model.position}],
              unit = Nothing
            }
          Nothing ->
            case head <| filter (snd >> (>) 0.025) <| map (\ unit -> (unit, distance model.position unit.position)) model.units of
              Just (unit, _) ->
                {
                  model |
                  units = filter (.id >> (/=) unit.id) model.units,
                  unit = Just unit
                }
              Nothing ->
                model,
        none
      )
    TriggerKeyboard char ->
      (
        case model.unit of
          Just unit ->
            case char of
              ' ' ->
                {
                  model |
                  unit = Nothing
                }
              _ ->
                case charCountry char of
                  Just country ->
                    {
                      model |
                      unit = Just {unit | country = country}
                    }
                  Nothing ->
                    case charKind char of
                      Just kind ->
                        {
                          model |
                          unit = Just {unit | kind = kind}
                        }
                      Nothing ->
                        model
          Nothing ->
            case char of
              ' ' ->
                {
                  model |
                  unit = Just <| unit model.nextId,
                  nextId = model.nextId + 1
                }
              _ ->
                model,
        none
      )
