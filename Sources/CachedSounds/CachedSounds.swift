//
//  CachedSounds.swift
//
//  Created by Kristian Kiraly on 8/10/23.
//

import AVFoundation

public class CachedSounds {
    private static var audioPlayers:[URL : AVAudioPlayer?] = [:]
    
    public static func playSound(soundfile: String) {
        DispatchQueue.main.async {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                    //print("AVAudioSession is Active")
                } catch _ as NSError {
                    //print(error.localizedDescription)
                }
            } catch _ as NSError {
                //print(error.localizedDescription)
            }
            if let path = Bundle.main.path(forResource: soundfile, ofType: nil){
                DispatchQueue.main.async {
                    do {
                        let url = URL(fileURLWithPath: path)
                        var somePlayer:AVAudioPlayer?
                        if let player = audioPlayers[url] {
                            somePlayer = player
                        } else {
                            somePlayer = try AVAudioPlayer(contentsOf: url)
                            audioPlayers[url] = somePlayer
                        }
                        somePlayer?.prepareToPlay()
                        somePlayer?.play()
                    } catch {
                        print("Error")
                    }
                }
            }
        }
    }
    
    public static func preloadSound(soundfile:String) {
        guard let path = Bundle.main.path(forResource: soundfile, ofType: nil) else { return }
        DispatchQueue.global().async {
            do {
                let url = URL(fileURLWithPath: path)
                if audioPlayers[url] == nil {
                    audioPlayers[url] = try AVAudioPlayer(contentsOf: url)
                }
            } catch {
                print("Error")
            }
        }
    }
}
