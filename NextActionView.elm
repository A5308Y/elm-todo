module NextActionView exposing (..)

import Types exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


nextAction : NextAction -> Html Msg
nextAction nextAction =
    li [ style (nextActionStyle nextAction) ]
        [ text nextAction.name
        , button [ onClick (SetAsDone nextAction.id) ] [ text "Done" ]
        , button [ onClick (Edit nextAction.id) ] [ text "Edit" ]
        ]


nextActionStyle : NextAction -> List ( String, String )
nextActionStyle nextAction =
    if nextAction.done then
        [ ( "color", "green" ) ]
    else
        [ ( "color", "red" ) ]


nextActionList : List NextAction -> Html Msg
nextActionList nextActions =
    ul [] (List.map nextAction nextActions)
