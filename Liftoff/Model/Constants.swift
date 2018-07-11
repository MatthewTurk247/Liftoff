//
//  Constants.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import UIKit

class Fact {
    var factbook = ["The largest star in the universe is being consumed by a black hole!", "Since there is no medium for sound to travel, space will always be eerily silent!", "Venus rotates slower than it orbits the sun, making a day outlast a year.", "If two metals touch in space, they will bond through cold welding and be stuck together.", "NASA classifies stars by temperature and one from the coldest class is 20ºC.", "Neutron stars implode so hard that all of their atoms melt together leaving only neutrons.", "There's no wind on the moon, so the astronauts' footprints will be there hundreds of thousands of years or longer.", "The sun's mass is 99% of the mass in the Solar System.", "The planet 55 Cancri-e is mostly made of diamond and theoretically worth $26.9 nonillion.", "More energy from the sun hits Earth every hour than the planet uses in a year.", "According to the Drake equation, there could be up to 140,000 intelligent civilizations in our galaxy alone.", "Since gravity doesn't compress your spine in space, astronauts get taller when they leave the planet!", "If you held your breath unprotected in space, the loss of pressure would cause your lungs to expand and explode!", "We've found over 1,500 exoplanets in the past 20 years.", "Theoretically, all the other planets in the Solar System could fit between Earth and the moon.", "If we ever found the end or repeat of an irrational number, the universe could be a computer simulation", "The reason why we only see one side of the moon is because of tidal locking.", "Saturn's rings are made from billions of particles ranging from grains of sand to mountain-size chunks of ice.", "In two billion years, the Milky Way and the nearst galaxy Andromeda will collide creating Milkdromeda...", "We have discovered 5% of the universe.", "Uranus has an east and west pole.", "It takes the Solar System 230 million years to rotate around the Milky Way.", "Surface temperatures on Venus can rise past 800°F. In the past, the planet has metled entire space probes.", "The universe's age is 31,536,000 times greater than the age of human existence.", "NASA is currently working on the development of a warp drive that could get astronauts to our neighboring star Alpha Centauri in 2 weeks.", "Mars has the biggest volcano in the Solar System."]
}

enum Config {
    // fileprivate - https://launchlibrary.net/1.4/launch
    //static let baseURL = "https://launchlibrary.net/1.4/launch"
    static let baseURL = "https://launchlibrary.net/1.4/launch"
    static let domain = "com.LaunchLibrary"
}

enum Color {
    static let exodusFruit = UIColor(red: 108/255, green: 92/255, blue: 231/255, alpha: 1)
    static let secondaryColor = UIColor.lightGray
    
    // A visual way to define colors within code files is to use #colorLiteral
    // This syntax will present you with colour picker component right on the code line
    //    static let tertiaryColor = #colorLiteral(r: g: b: a: )
    static let tertiaryColor = #colorLiteral(red: 0.22, green: 0.58, blue: 0.29, alpha: 1.0)
}

struct SegueID {
    static let settings = "settings"
    static let launchDetail = "launchDetail"
}

