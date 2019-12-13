module UsuallyFails exposing (main)

import Example
import Script exposing (Script)
import Time


script : Script.Init -> Script Int ()
script _ =
    Script.getCurrentTime
        |> Script.andThen
            (\time ->
                if (Time.posixToMillis time |> modBy 100) > 87 then
                    Script.printLine "Succeeded"

                else
                    Script.printLine "Failed"
                        |> Script.andThen (\() -> Script.fail 1)
            )


main : Script.Program
main =
    Example.program script
