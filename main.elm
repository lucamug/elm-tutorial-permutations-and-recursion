module Main exposing (..)

{-
   To run this test:

   $ elm-live --output=main.js test.elm --open
-}

import Html exposing (..)
import Html.Attributes exposing (..)


generateCombinations1 : List (List a) -> List (List a)
generateCombinations1 list =
    case Debug.log "head is" (List.head list) of
        Nothing ->
            -- We reached the end
            []

        Just head ->
            -- Still stuff to process
            []


generateCombinations2 : List (List a) -> List (List a)
generateCombinations2 list =
    case Debug.log "head is" (List.head list) of
        Nothing ->
            []

        Just head ->
            let
                tail =
                    case Debug.log "tail is" (List.tail list) of
                        Just data ->
                            data

                        Nothing ->
                            []
            in
                []


generateCombinations3 : List (List a) -> List (List a)
generateCombinations3 list =
    case Debug.log "head is" (List.head list) of
        Nothing ->
            []

        Just head ->
            let
                tail =
                    case Debug.log "tail is" (List.tail list) of
                        Just data ->
                            data

                        Nothing ->
                            []
            in
                generateCombinations3 tail


generateCombinations4 : List String -> List a -> List (List String)
generateCombinations4 acc list =
    let
        _ =
            Debug.log "acc is" acc
    in
        case Debug.log "head is" (List.head list) of
            Nothing ->
                [ acc ]

            Just head ->
                let
                    tail =
                        case Debug.log "tail is" (List.tail list) of
                            Just data ->
                                data

                            Nothing ->
                                []
                in
                    generateCombinations4 ("test" :: acc) tail


generateCombinations5 : List a -> List (List a) -> List (List a)
generateCombinations5 acc list =
    let
        _ =
            Debug.log "acc is" acc
    in
        case Debug.log "head is" (List.head list) of
            Nothing ->
                [ acc ]

            Just head ->
                let
                    tail =
                        case Debug.log "tail is" (List.tail list) of
                            Just data ->
                                data

                            Nothing ->
                                []
                in
                    List.concat
                        (List.map
                            (\item ->
                                generateCombinations5
                                    (item :: acc)
                                    (tail)
                            )
                            head
                        )


generateCombinations : List a -> List (List a) -> List (List a)
generateCombinations acc list =
    case List.head list of
        Nothing ->
            [ List.reverse acc ]

        Just head ->
            let
                tail =
                    case List.tail list of
                        Just data ->
                            data

                        Nothing ->
                            []
            in
                List.concat
                    (List.map
                        (\item ->
                            generateCombinations
                                (item :: acc)
                                (tail)
                        )
                        head
                    )


main : Html msg
main =
    div []
        ([ node "style" [] [ text css ]
         , h1 [] [ text "Tutorial - Permutation and Recursion in Elm" ]
         , p []
            [ text "Article: "
            , a [ href "https://medium.com/@l.mugnaini/tutorial-permutations-and-recursions-in-elm-ad15e2288567" ] [ text "https://medium.com/@l.mugnaini/tutorial-permutations-and-recursions-in-elm-ad15e2288567" ]
            ]
         , h2 [] [ text (Debug.log "FUNCTION" "generateCombinations1") ]
         , p [] [ text (toString (generateCombinations1 [ [ "a", "b" ], [ "1", "2" ] ])) ]
         , h2 [] [ text (Debug.log "FUNCTION" "generateCombinations2") ]
         , p [] [ text (toString (generateCombinations2 [ [ "a", "b" ], [ "1", "2" ] ])) ]
         , h2 [] [ text (Debug.log "FUNCTION" "generateCombinations3") ]
         , p [] [ text (toString (generateCombinations3 [ [ "a", "b" ], [ "1", "2" ] ])) ]
         , h2 [] [ text (Debug.log "FUNCTION" "generateCombinations4") ]
         , p [] [ text (toString (generateCombinations4 [] [ [ "a", "b" ], [ "1", "2" ] ])) ]
         , h2 [] [ text (Debug.log "FUNCTION" "generateCombinations5") ]
         , p [] [ text (toString (generateCombinations5 [] [ [ "a", "b" ], [ "1", "2" ] ])) ]
         ]
            ++ subView [ [ "a", "b" ], [ "1", "2" ] ]
            ++ subView [ [ "a", "b" ], [ "1", "2" ], [ "x", "y" ] ]
            ++ subView [ [ "a" ], [], [ "1" ] ]
            ++ subView [ [ 1, 2 ], [ 3, 4 ] ]
            ++ subView [ [] ]
            ++ subView []
        )


subView : List (List a) -> List (Html msg)
subView input =
    [ h2 [] [ text (Debug.log "FUNCTION" "generateCombinations") ]
    , p []
        [ input
            |> toString
            |> (++) "Input: "
            |> text
        ]
    , p []
        [ input
            |> generateCombinations []
            |> toString
            |> (++) "Output: "
            |> text
        ]
    ]


css : String
css =
    """
body {
    color: #555;
    margin: 10px;
    font-family: sans-serif;
    background-color: #eee;
}
h2 {
    color: green;
}
"""
