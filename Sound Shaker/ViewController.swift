//
//  ViewController.swift
//  Sound Shaker
//
//  Created by Francisco de la Pena on 2/24/15.
//  Copyright (c) 2015 ___QuixoteLabs___. All rights reserved.
//

import UIKit
import AVFoundation

var mySongs: [NSString] = [NSString]()

var selectedSong: NSString = NSString()

var myPlayer: AVAudioPlayer = AVAudioPlayer()

var baseDir = NSBundle.mainBundle().bundleURL

class ViewController: UIViewController, AVAudioPlayerDelegate {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadFiles()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func motionEnded(motion: UIEventSubtype,
        withEvent event: UIEvent) {
            
            if(motion == UIEventSubtype.MotionShake) {
                
                selectSong()
                
                createPlayer(selectedSong)
                
                myPlayer.play()
            }
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createPlayer (song: NSString) {
        
        var error: NSError? = nil
        
        var urlString = "\(baseDir)\(selectedSong)"
        
        var url: NSURL = NSURL(string: urlString)!
        
        println(url)
        
        myPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        myPlayer.delegate = self
        
    }
    
    func selectSong() {
        
        var rand = arc4random_uniform(UInt32(mySongs.count))
        
        selectedSong = mySongs[Int(rand)]
        
        println(mySongs[Int(rand)])
        
    }

    func loadFiles() {
        
        var fileManager: NSFileManager = NSFileManager()
        
        var dirEnumerator: NSDirectoryEnumerator = fileManager.enumeratorAtPath(NSBundle.mainBundle().bundlePath)!
        
        while let file: NSString = dirEnumerator.nextObject() as? NSString {
        
            if (file.pathExtension == "mp3") {
        
                mySongs.append(file)//.stringByDeletingPathExtension)
        
            }
        
        }
        
        println(mySongs)
   
    }
    

    

}

