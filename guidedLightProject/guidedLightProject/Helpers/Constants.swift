//
//  Constants.swift
//  guidedLightProject
//
//  Created by Margels on 11/10/22.
//

import Foundation
import UIKit

class Constants {
    
    // accessible colours
    static var trafficLightViewBackgroundColour = UIColor(named: "TrafficLightColour")
    static var offLightsBackgroundColour = UIColor(named: "OffLightsBackgroundColour")
    static var poleBackgroundColour = UIColor(named: "PoleColour")
    static var shadowColour = UIColor(named: "ShadowColour")

    // traffic light colours
    static var currentDescriptor = defaultDescription
    static var currentColour: UIColor?
    static var currentShadow: UIColor?
    
    static var trafficLightColour: trafficLights? = .red {
        didSet {
            switch trafficLightColour {
            case .red:
                currentColour = .red
                currentShadow = .red
            case .yellow:
                currentColour = .yellow
                currentShadow = .yellow
            case .green:
                currentColour = .green
                currentShadow = .green
            default:
                currentColour = offLightsBackgroundColour
                currentShadow = .clear
                currentDescriptor = defaultDescription
                trafficLightColour = .red
            }
        }
    }
    
    // descriptions
    static var defaultDescription = Descriptor(title:       "Traffic lights made fun!",
                                               description: "Traffic lights are the most common way to direct traffic. Lights go from green at the bottom, to yellow in the middle, then red at the top. Wonder what they mean? Press each button in sequence to find out!\n\n Press the green light at the bottom to start.")

    static var descriptors: [Descriptor] = [
        Descriptor(title:       "Red light",
                   description: "Stop the car! When the light is red, it means that you must stop driving at the traffic light. Stop moving at all costs, otherwise... well, watch Squid Game to know what happens if you don't."),
        Descriptor(title:       "Amber light",
                   description: "Yellow means that the light will turn red in a few seconds; when safe, you should slow down and stop your car at the traffic lights. However, if you don't have enough way to slow down, avoid abruptly breaking: choose life and keep driving."),
        Descriptor(title:       "Green light",
                   description: "You may keep driving! When the light is green, you can do your thing and not worry about a thing. Well, as long as you're within the speed limits... otherwise, those cameras at the traffic lights might still flash you. Watch out!")
    ]
    
    
    // error message
    static var errorMessages: [Descriptor] = [
        
        Descriptor(title:       "Red comes after yellow!",
                   description: "If the lights were to go from green to red, there would be a bunch of accidents caused by drivers trying to break the car. Pick the yellow light to let your drivers know they need to safely start slowing down!\n\n Press the green light to restart."),
        Descriptor(title:       "Yellow comes after green!",
                   description: "Red lights are always followed by green lights! Yellow is only supposed to warn drivers that the lights will turn red, so they start slowing down.\n\n Press the green light to restart."),
        Descriptor(title:       "Green comes after red!",
                   description: "Yellow lights warn drivers to slow down or stop at the traffic lights. Imagine how upsetting it would be if you stopped the car in anticipation of a red light, for it to be green again!\n\n Press the green light to restart.")
        
        
        
    ]
    
    
    
    
}
