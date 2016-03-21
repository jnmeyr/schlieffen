module App (main) where

import Effects               exposing (none)
import Html                  exposing (Html)
import StartApp              exposing (App, start)
import Maybe                 exposing (withDefault)
import Signal                exposing (map)
import Json.Encode as Encode exposing (encode)
import Json.Decode as Decode exposing (decodeString)

import Model                 exposing (Model, model, modelEncoder, modelDecoder)
import Update                exposing (update)
import View                  exposing (view)
import Inputs                exposing (inputs)

toModel : Maybe String -> Maybe Model
toModel string =
  case string of
    Just string ->
      case decodeString modelDecoder string of
        Ok model ->
          Just model
        Err _ ->
          Nothing
    Nothing ->
      Nothing

fromModel : Model -> String
fromModel model =
  encode 0 <|
    modelEncoder model

app : App Model
app =
  start
    {
      init = (withDefault model <| toModel getStorage, none),
      update = update,
      view = view,
      inputs = inputs
    }

main : Signal Html
main =
  app.html

port getStorage : Maybe String

port setStorage : Signal String
port setStorage = map fromModel app.model
