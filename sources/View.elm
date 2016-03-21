module View (view) where

import Signal           exposing (Address)
import Html             exposing (Html, fromElement)
import Graphics.Collage exposing (Form, defaultLine, outlined, group, collage, filled, move)
import Graphics.Element exposing (Element, container, image, middle, layers)
import VirtualDom       exposing (toElement)
import List             exposing (map)

import Model            exposing (Model)
import Size             exposing (Size)
import Position         exposing (Position)
import Kind             exposing (kindShape)
import Country          exposing (countryColor)
import Unit             exposing (Unit)
import Actions          exposing (Action)

(@) : Position -> Size -> (Float, Float)
(@) position size =
  (
    position.x * size.width - size.width / 2.0,
    position.y * size.height - size.height / 2.0
  )

mapElement : Model -> Element
mapElement model =
  image (round model.size.width) (round model.size.height) "resources/map.png"

unitForm : Unit -> Form
unitForm unit =
  let
    shape = kindShape unit.kind
  in
    group
      [
        outlined {defaultLine | width = 2} shape,
        filled (countryColor unit.country) shape
      ]

unitsElement : Model -> Element
unitsElement model =
  collage (round model.size.width) (round model.size.height) <|
    map (\ unit -> move (unit.position @ model.size) <| unitForm unit) model.units

unitElement : Model -> Element
unitElement model =
  collage (round model.size.width) (round model.size.height) <|
    case model.unit of
      Just unit ->
        [
          move (model.position @ model.size) <| unitForm unit
        ]
      Nothing ->
        []

view : Address Action -> Model -> Html
view address model =
  fromElement <| container (round model.size.width) (round model.size.height) middle <| layers
    [
      mapElement model,
      unitsElement model,
      unitElement model
    ]
