# CachedSounds

A small utility that allows you to preload and cache AVAudioPlayer instances just by calling a static function with a name of a sound file that is included in the app bundle. This allows you to play sounds without delay after the first time they play or preload them so there's no delay at all.

CachedSounds Usage:
```swift
struct ContentView: View {
    let soundName = "beep.wav"
    
    var body: some View {
        Button {
            //This will play the sound with or without preloading it. If you haven't preloaded it, it will be cached after the first play
            CachedSounds.playSound(soundFile: soundName)
        } label: {
            Text("Beep!")
        }
        .onAppear {
            //In the event you'd like to have zero lag when first playing the sound, preload the sound
            CachedSounds.preloadSound(soundFile: soundName)
        }
    }
}
```
