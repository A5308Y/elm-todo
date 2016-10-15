module ProjectsView exposing (..)

import Types exposing (..)
import Html exposing (..)
import NextActionView exposing (..)


projectView : List NextAction -> Project -> Html Msg
projectView nextActions project =
    div []
        [ text project.name
        , nextActionList (selectedNextActions project.id nextActions)
        ]


projectList : List Project -> List NextAction -> Html Msg
projectList projects nextActions =
    projects
        |> List.map (projectView nextActions)
        |> ul []


selectedNextActions : Int -> List NextAction -> List NextAction
selectedNextActions projectId nextActions =
    nextActions
        |> List.filter (\nextAction -> nextAction.projectId == Just projectId)
