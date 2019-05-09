module Main exposing (Model, init, main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- Model


type alias Model =
    { inputData : String
    , storedData : String
    }


type Msg
    = GotData String
    | StoreData


init : Model
init =
    { inputData = "", storedData = "" }



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        GotData data ->
            { model | inputData = data }

        StoreData ->
            { model | storedData = model.inputData }



-- View


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
            let
                suf =
                    if String.length model.inputData > 0 then
                        "!!!"

                    else
                        ""
            in
            viewHelper (String.reverse model.inputData ++ suf)


viewHelper : String -> Html Msg
viewHelper a =
    div []
        [ input
            [ placeholder "Talk2Me"
            , onInput GotData
            ]
            []
        , span []
            [ div
                [ style "color" "Blue"
                , style "font-size" "40px"
                ]
                [ text a ]
            , button [ onClick StoreData ] [ text "Store Value" ]
            ]
        ]
