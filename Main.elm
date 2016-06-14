import List
import String
import Array
import Char
import Html.App
import Html exposing (Html, input, div, text, p, h1, body, h3, label)
import Html.Events exposing (onInput)
import Html.Attributes exposing (class, id, for)

main =
  Html.App.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model = String

model : Model
model =
  ""

natoSpellingArray = Array.fromList ["Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliet", "Kilo", "Lima", "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whiskey", "X-Ray", "Yankee", "Zulu"]

spanishSpellingArray = Array.fromList ["ei", "bi", "si", "di", "i", "ef", "gi", "eich", "ai", "yei", "kei", "el", "em", "en", "ou", "pi", "quiu", "ar", "es", "ti", "iu", "vi", "dabliu", "ex", "guay", "sed"]
 

-- UPDATE
type Msg = 
    Change String
    
update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newSentence->
        newSentence

-- VIEW
genericSpelling : Array.Array String -> Char -> String
genericSpelling dictionary letter =
    let
        -- TODO to lower
        -- 97: a in ASCII
        keyCode = (Char.toCode letter) - 97
        spelling = Array.get keyCode dictionary
    in
        case spelling of
            Just val -> val
            Nothing -> "N/A"


natoSpelling : Char -> String
natoSpelling letter =
    genericSpelling natoSpellingArray letter

spanishSpelling : Char -> String
spanishSpelling letter =
    genericSpelling spanishSpellingArray letter

renderLetter : Char -> Html msg
renderLetter letter =
    div [class "col s6 m2 l2"] [
        div [class "card center-align"] [
            div [class "chip"] [text (natoSpelling letter)]
            , h3 [] [text (String.fromList [letter])]
            , div [class "chip"] [text (spanishSpelling letter)]
        ]
    ]
    

view : Model -> Html Msg
view model =
  let 
    letterCards = List.map renderLetter ( String.toList model )
  in    
    body [] [
        div [class "row"] [
            div [class "col s12"] [
                div [class "row"] [
                    div [class "center-align"] [h1 [] [text "¿Qué quieres deletrear?"]]
                    , div [class "row"] [
                        input [ onInput Change, id "phrase"] []
                    ]
                ]
            ]
        ]
        , div [class "row"] [
            div [] letterCards
        ]
    ]
