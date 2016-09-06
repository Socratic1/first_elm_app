module Main exposing (..)

import Html exposing (Html)
import Html.App
import Randomize
import Counter
import Fetch


-- MODEL


type alias AppModel = 
    { randomizeModel : Randomize.Model
    , counterModel   : Counter.Model
    , fetchModel     : Fetch.Model
    }

initialModel : AppModel
initialModel =
    { randomizeModel = Randomize.initialModel
    , counterModel   = Counter.initialModel  
    , fetchModel     = Fetch.initialModel
    }

init : ( AppModel, Cmd Msg )
init = 
    ( initialModel, Cmd.none )


-- MESSAGES


type Msg
    = RandomizeMsg Randomize.Msg
    | CounterMsg Counter.Msg
    | FetchMsg Fetch.Msg


-- VIEW


view : AppModel -> Html Msg
view model =  
    Html.div []
        [ Html.App.map RandomizeMsg (Randomize.view model.randomizeModel)
        , Html.App.map CounterMsg (Counter.view model.counterModel)
        , Html.App.map FetchMsg (Fetch.view model.fetchModel)
        ]


-- UPDATE 


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update msg model =
    case msg of
        RandomizeMsg subMsg ->
            let 
                ( updatedRandomizeModel, randomizeCmd ) = 
                    Randomize.update subMsg model.randomizeModel
            in 
                ( { model | randomizeModel = updatedRandomizeModel }, Cmd.map RandomizeMsg randomizeCmd )

        CounterMsg subMsg ->
            let 
                ( updatedCounterModel, counterCmd) =
                    Counter.update subMsg model.counterModel
            in 
                ( { model | counterModel = updatedCounterModel }, Cmd.map CounterMsg counterCmd )

        FetchMsg subMsg ->
            let 
                ( updatedFetchModel, fetchCmd ) =
                    Fetch.update subMsg model.fetchModel
            in 
                ( { model | fetchModel = updatedFetchModel }, Cmd.map FetchMsg fetchCmd )


-- SUBSCRIPTIONS

subscriptions : AppModel -> Sub Msg
subscriptions model = 
    Sub.none


-- MAIN


main : Program Never
main = 
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }