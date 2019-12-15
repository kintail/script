module ReadFile exposing (main)

import Example
import Script exposing (Script)
import Script.File as File exposing (File)


script : Script.Init -> Script Int ()
script { arguments, userPrivileges } =
    case arguments of
        [ path ] ->
            File.read (File.readOnly userPrivileges path)
                |> Script.map String.lines
                |> Script.map (List.filter (not << String.isEmpty))
                |> Script.thenWith (Script.each (\line -> Script.printLine (String.toUpper line)))
                |> Script.onError (Example.handleError .message)

        _ ->
            Script.printLine "Please supply the path of one file to read"
                |> Script.andThen (Script.fail 1)


main : Script.Program
main =
    Example.program script
