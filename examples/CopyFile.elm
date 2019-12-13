module CopyFile exposing (main)

import Example
import Script exposing (Script)
import Script.Directory as Directory
import Script.File as File


script : Script.Init -> Script Int ()
script { workingDirectory } =
    let
        sourceFile =
            workingDirectory |> Directory.file "reversed.txt"

        destinationFile =
            workingDirectory |> Directory.file "reversed-copied.txt"
    in
    File.copy sourceFile destinationFile
        |> Script.onError (Example.handleError .message)


main : Script.Program
main =
    Example.program script
