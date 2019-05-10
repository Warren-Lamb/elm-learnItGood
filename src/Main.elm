port module Main exposing (Model, init, main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Json.Encode as E


main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { inputData : String
    , storedData : String
    }


type Msg
    = GotData String
    | StoreData



-- Ports


port storeVal : E.Value -> Cmd msg



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- Init


init : () -> ( Model, Cmd Msg )
init _ =
    ( { inputData = "", storedData = "" }, Cmd.none )



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotData data ->
            ( { model | inputData = data }, Cmd.none )

        StoreData ->
            ( { model | storedData = model.inputData }, Cmd.none )



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
