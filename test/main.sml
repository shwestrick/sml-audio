val x =
  case CommandLine.arguments () of
    [filename] => filename
  | _ => raise Fail "usage: reverb filename"

val snd = WavIO.readSound x
val snd' = Signal.reverb snd
val _ = WavIO.writeSound snd' "out.wav"
