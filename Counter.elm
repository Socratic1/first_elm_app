module Counter exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


-- MODEL 


type alias Model = 
    Int

initialModel : Model 
initialModel = 
    0


-- MESSAGES


type Msg 
    = Incriment
    | Decriment


-- VIEW


view: Model -> Html Msg
view model =
    div []
        [ button [ onClick Decriment ] [ text "-" ]
        , text (toString model) 
        , button [ onClick Incriment ] [ text "+" ]
        ]


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Incriment ->
            ( model + 1, Cmd.none )
        Decriment -> 
            ( model - 1, Cmd.none )