module Main exposing (Model, init, main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- Model


type alias Model =
    { inputData : String
    }


type Msg
    = GotData String


init : Model
init =
    { inputData = "" }


update : Msg -> Model -> Model
update msg model =
    case msg of
        GotData data ->
            { model | inputData = data }


view : Model -> Html Msg
view model =
    case String.toInt model.inputData of
        Just integer ->
            let
                newVal =
                    integer * 42
            in
            viewHelper (String.fromInt newVal)

        Nothing ->
            viewHelper model.inputData


viewHelper : String -> Html Msg
viewHelper a =
    div []
        [ input
            [ placeholder "Talk2Me"
            , onInput GotData
            ]
            []
        , div
            [ style "color" "Blue"
            , style "font-size" "40px"
            ]
            [ text a ]
        ]
