A Standard ML library for audio manipulation and I/O. Designed to work well
with the [smlpkg](https://github.com/diku-dk/smlpkg) package manager.

## Library sources

There are two source files:
  - `lib/github.com/shwestrick/sml-audio/sml-audio.mlb`
  - `lib/github.com/shwestrick/sml-audio/sml-audio.mpl.mlb`

The `.mlb` is for use with normal SML (e.g. [MLton](http://mlton.org/))
and the `.mpl.mlb` is for use with [MPL](https://github.com/mpllang/mpl).

## Interface

```sml
structure WavIO:
sig
  type sound = {sr: int, data: real ArraySlice.slice}
  (* A sound is a sequence of samples at the given
   * sample rate, sr (measured in Hz).
   * Each sample is in range [-1.0, +1.0].
   *)

  val readSound: string -> sound
  (* Read the contents of a .wav file. Currently supports 8-bit and
   * 16-bit PCM. If there are multiple channels, these are mixed
   * into a single channel.
   *)

  val writeSound: sound -> string -> unit
  (* Write a sound as a .wav file *)
end
```

```sml
structure Signal:
sig
  type sound = WavIO.sound

  val compress: real -> sound -> sound
  (* Essentially mu-law compression. Normalizes to [-1,+1] and compresses
   * the dynamic range slightly. The first parameter should be >= 1; use
   * larger values for higher compression.
   *)

  val delay: real -> real -> sound -> sound
  (* A tape-delay effect, or equivalently an IIR comb filter.
   * [delay ds a s] produces equally spaced echoes of the input sound
   * at intervals [ds] seconds wide. Each echo is attenuated by [a],
   * which should be in the range [0,1]
   *)

  val allPass: real -> real -> sound -> sound
  (* An IIR all-pass filter. The parameters are again: a delay (in seconds)
   * and an attenuation parameter (in the range [0,1]).
   *)

  val reverb: sound -> sound
  (* Applies a digital reverb effect to the input sound. Currently not
   * configurable, although this would be an easy change. Works best
   * at a sample rate of 44.1 kHz.
   *)
end
```


