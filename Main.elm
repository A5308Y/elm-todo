module Main exposing (..)

import Html.App as Html
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import NextActionView exposing (..)
import ProjectsView exposing (..)
import Types exposing (..)
import String


main : Program Never
main =
    Html.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }


initModel : Model
initModel =
    { nextActions = []
    , newNextActionName = ""
    , projectIdForNewNextAction = Nothing
    , newProjectName = ""
    , projects = []
    }


update : Msg -> Model -> Model
update msg model =
    let
        newNextActionId =
            List.length model.nextActions

        newProjectId =
            List.length model.projects

        newNextAction =
            NextAction newNextActionId model.newNextActionName False model.projectIdForNewNextAction

        newProject =
            Project newProjectId model.newProjectName False
    in
        case msg of
            AddNextAction ->
                { model | nextActions = newNextAction :: model.nextActions, newNextActionName = "" }

            AddProject ->
                { model
                    | projects = newProject :: model.projects
                    , newProjectName = ""
                    , projectIdForNewNextAction = Just newProjectId
                }

            SetAsDone selectedNextActionId ->
                { model | nextActions = List.map (setDone selectedNextActionId) model.nextActions }

            Edit selectedNextActionId ->
                { model
                    | nextActions = List.map (edit selectedNextActionId model.newNextActionName) model.nextActions
                    , newNextActionName = ""
                }

            SetNewNextActionName givenName ->
                { model | newNextActionName = givenName }

            SetProjectIdForNewNextAction projectId ->
                { model | projectIdForNewNextAction = Just (Result.withDefault 0 (String.toInt projectId)) }

            SetNewProjectName givenName ->
                { model | newProjectName = givenName }


setDone : Int -> NextAction -> NextAction
setDone selectedNextActionId nextAction =
    if nextAction.id == selectedNextActionId then
        { nextAction | done = True }
    else
        nextAction


edit : Int -> String -> NextAction -> NextAction
edit selectedNextActionId newName nextAction =
    if nextAction.id == selectedNextActionId then
        { nextAction | name = newName }
    else
        nextAction


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "My first own app" ]
        , nextActionList model.nextActions
        , Html.form [ onSubmit AddNextAction ]
            [ input [ onInput SetNewNextActionName, value model.newNextActionName ] []
            , select
                [ onInput SetProjectIdForNewNextAction ]
                (List.map (\project -> option [ value (toString project.id) ] [ text project.name ]) model.projects)
            , button [ type' "submit" ] [ text "Add NextAction" ]
            ]
        , Html.form [ onSubmit AddProject ]
            [ input [ onInput SetNewProjectName, value model.newProjectName ] []
            , button [ type' "submit" ] [ text "Add Project" ]
            ]
        , projectList model.projects model.nextActions
        , div [] [ text (toString model) ]
        ]
