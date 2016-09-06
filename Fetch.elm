module Fetch exposing (..)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Http
import Task exposing (Task)
import Json.Decode as Decode


-- MODEL 


type alias Model = 
    String

initialModel : Model
initialModel = 
    ""


-- MESSAGES 


type Msg
    = Fetch
    | FetchSuccess String
    | FetchError Http.Error


-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Fetch ] [ text "Fetch" ]
        , text model
        ]

decode : Decode.Decoder String
decode =
    Decode.at [ "rotation_period" ] Decode.string

url : String
url =
    "http://swapi.co/api/planets/1/?format=json"

fetchTask : Task Http.Error String
fetchTask =
    Http.get decode url

fetchCmd : Cmd Msg
fetchCmd =
    Task.perform FetchError FetchSuccess fetchTask


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fetch ->
            ( model, fetchCmd )

        FetchSuccess name ->
            ( name, Cmd.none )

        FetchError error ->
            ( toString error, Cmd.none )