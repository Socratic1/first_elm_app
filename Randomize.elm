module Randomize exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Random


-- MODEL


type alias Model = 
    Int

initialModel : Model
initialModel = 
    1


-- MESSAGES


type Msg 
    = Roll
    | OnResult Int


-- VIEW 


view : Model -> Html Msg
view model = 
    div []
        [ button [ onClick Roll ][ text "Roll" ]
        , text (toString model)
        ]


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of
        Roll ->
            ( model, Random.generate OnResult (Random.int 1 1000) )

        OnResult res ->
            ( res, Cmd.none )