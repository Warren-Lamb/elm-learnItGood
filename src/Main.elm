port module Main exposing (Model, init, main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Json.Decode as D
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
    , valFromJs : Int
    }


type Msg
    = GotData String
    | StoreData
    | GotValFromJs E.Value



--    | GetStore E.Value
-- Ports


port storeVal : E.Value -> Cmd msg


port portIntoElm : (E.Value -> msg) -> Sub msg



--port getStore : (E.Value -> Msg) -> Sub msg
-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    portIntoElm GotValFromJs



-- Init


init : () -> ( Model, Cmd Msg )
init _ =
    ( { inputData = "", storedData = "", valFromJs = 0 }, Cmd.none )



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotData data ->
            ( { model | inputData = data }, Cmd.none )

        StoreData ->
            ( { model | storedData = model.inputData }, Cmd.none )

        GotValFromJs encodedVal ->
            case D.decodeValue D.int encodedVal of
                Err err ->
                    ( model, Cmd.none )

                Ok decoded ->
                    ( { model | valFromJs = decoded }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    case String.toInt model.inputData of
        Just integer ->
            let
                newVal =
                    integer * 42
            in
            viewHelper (String.fromInt newVal) model.valFromJs

        Nothing ->
            let
                suf =
                    if String.length model.inputData > 0 then
                        "!!!"

                    else
                        ""
            in
            viewHelper (String.reverse model.inputData ++ suf) model.valFromJs


viewHelper : String -> Int -> Html Msg
viewHelper a b =
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
        , button [ onClick StoreData ] [ text "Store Value" ]
        , button [] [ text "Get Value Store" ]
        , div [] [ text (String.fromInt b) ]
        ]
