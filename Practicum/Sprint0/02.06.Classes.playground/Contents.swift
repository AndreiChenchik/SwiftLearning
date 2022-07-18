import UIKit

var greeting = "Hello, playground"

class Track {
    var name: String
    var durationSec: Int
    var listenCount: Int
    
    init(name: String, durationSec: Int, listenCount: Int) {
        self.name = name
        self.durationSec = durationSec
        self.listenCount = listenCount
    }
    
    func printInfo() {
        print("\(name), \(durationSec / 60):\(durationSec % 60), played \(listenCount) times")
    }
}


class Band {
    var name: String
    var yearFounded: Int
    var lastRelease: Track
    
    init(name: String, yearFounded: Int, lastRelease: Track) {
        self.name = name
        self.yearFounded = yearFounded
        self.lastRelease = lastRelease
    }
    
    func printInfo() {
        print("Musician: \(name), born in \(yearFounded)")
        print("Latest release: ", terminator: "")
        lastRelease.printInfo()
    }
}

let latestTrack = Track(name: "Big Brown Eyes", durationSec: 225, listenCount: 100000)
let band = Band(name: "Benny Sings", yearFounded: 1977, lastRelease: latestTrack)

band.printInfo()
