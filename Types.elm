module Types exposing (..)


type alias Model =
    { nextActions : List NextAction
    , projects : List Project
    , newNextActionName : String
    , projectIdForNewNextAction : Maybe Int
    , newProjectName : String
    }


type Msg
    = AddNextAction
    | AddProject
    | SetAsDone Int
    | Edit Int
    | SetNewNextActionName String
    | SetProjectIdForNewNextAction String
    | SetNewProjectName String


type alias NextAction =
    { id : Int, name : String, done : Bool, projectId : Maybe Int }


type alias Project =
    { id : Int, name : String, done : Bool }
