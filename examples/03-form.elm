import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }


init : Model
init =
  Model "" "" ""



-- UPDATE


type Msg
  = Name String
  | Password String
  | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , viewValidation model
    , pwLengthValidation model
    , mixedCaseValidation model
    , digitValidation model
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
  if model.password == model.passwordAgain then
    div [ style "color" "green" ] [ text "OK" ]
  else
    div [ style "color" "red" ] [ text "Passwords do not match!" ]


-- バリデーション：パスワード8文字以上
pwLengthValidation : Model -> Html msg
pwLengthValidation model =
  if String.length model.password > 8 then
    div [ style "color" "green"] [ text "Okay"]
  else
    div [ style "color" "red"] [text "パスワードは8文字以上にしてください"]


-- 大文字と小文字両方含まれてるかチェック
mixedCaseValidation : Model -> Html msg
mixedCaseValidation model =
  if String.toUpper model.password == model.password || String.toLower model.password == model.password then
    div [style "color" "red"] [ text "パスワードは大文字と小文字まぜて"]
  else
    div [style "color" "green"] [ text "オッケー"]


-- 数字はいってるかチェック
digitValidation : Model -> Html msg
digitValidation model =
  if String.any Char.isDigit model.password then
    div [ style "color" "green"] [text "おっけい"]
  else
    div [style "color" "red"] [ text "数字混ぜて"]
