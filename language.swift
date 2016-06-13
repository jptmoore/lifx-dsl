//
//  language.swift
//  lifx
//
//  Created by John Moore on 12/06/2016.
//  Copyright © 2016 John P. T. Moore. All rights reserved.
//

import Foundation

typealias CommandType = (String, [String: AnyObject])

enum ColorType: String {
    case White = "White"
    case Red = "Red"
    case Orange = "Orange"
    case Yellow = "Yellow"
    case Cyan = "Cyan"
    case Green = "Green"
    case Blue = "Blue"
    case Purple = "Purple"
    case Pink = "Pink"
}

enum 💡 {
    case Color(name: ColorType, brightness: Float)
    case Breathe(color: ColorType, period: Float, cycles: Float)
    case Pulse(color: ColorType, period: Float, cycles: Float)
    case Wait(duration: Double)
    case Power(on: Bool)
    
    var description: CommandType {
        switch self {
        case let .Color(name, brightness):
            return ("Color", ["color": "\(name.rawValue) brightness:\(brightness)"])
        case let .Breathe(color, period, cycles):
            return ("Breathe", ["color": "\(color.rawValue)", "period":"\(period)", "cycles":"\(cycles)"])
        case let .Pulse(color, period, cycles):
            return ("Pulse", ["color": "\(color.rawValue)", "period":"\(period)", "cycles":"\(cycles)"])
        case let .Wait(duration):
            return ("Wait", ["duration": duration])
        case let .Power(on):
            return ("Power", ["on": on])
        }
    }
}

enum Light {
    case Bulb(💡)
    indirect case Scheme([Light])
}
