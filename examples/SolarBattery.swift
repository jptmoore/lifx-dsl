//
//  SolarBattery.swift
//  lifx
//
//  Created by John Moore on 01/07/2016.
//  Copyright © 2016 John P. T. Moore. All rights reserved.
//

class SolarBattery {
    
    var token: String
    var selector: String
    
    init(token: String, selector: String = "all") {
        
        self.token = token
        self.selector = selector
        
        let poweron = Light.Bulb(💡.Power(on: true))
        let poweroff = Light.Bulb(💡.Power(on: false))
        let wait1 = Light.Bulb(💡.Wait(duration: 3))
        let wait2 = Light.Bulb(💡.Wait(duration: 7))
        let wait3 = Light.Bulb(💡.Wait(duration: 10))
        
        let red1 = Light.Bulb(💡.Color(name: .Red, brightness: 0.02))
        let red2 = Light.Bulb(💡.Color(name: .Red, brightness: 0.04))
        let red3 = Light.Bulb(💡.Color(name: .Red, brightness: 0.06))
        let red4 = Light.Bulb(💡.Color(name: .Red, brightness: 0.08))
        let red5 = Light.Bulb(💡.Color(name: .Red, brightness: 0.10))
        
        let orange1 = Light.Bulb(💡.Color(name: .Orange, brightness: 0.10))
        let orange2 = Light.Bulb(💡.Color(name: .Orange, brightness: 0.12))
        let orange3 = Light.Bulb(💡.Color(name: .Orange, brightness: 0.14))
        let orange4 = Light.Bulb(💡.Color(name: .Orange, brightness: 0.16))
        let orange5 = Light.Bulb(💡.Color(name: .Orange, brightness: 0.18))
        
        let yellow1 = Light.Bulb(💡.Color(name: .Yellow, brightness: 0.18))
        let yellow2 = Light.Bulb(💡.Color(name: .Yellow, brightness: 0.20))
        let yellow3 = Light.Bulb(💡.Color(name: .Yellow, brightness: 0.22))
        let yellow4 = Light.Bulb(💡.Color(name: .Yellow, brightness: 0.24))
        let yellow5 = Light.Bulb(💡.Color(name: .Yellow, brightness: 0.26))
        
        let white1 = Light.Bulb(💡.Color(name: .White, brightness: 0.26))
        let white2 = Light.Bulb(💡.Color(name: .White, brightness: 0.28))
        let white3 = Light.Bulb(💡.Color(name: .White, brightness: 0.30))
        let white4 = Light.Bulb(💡.Color(name: .White, brightness: 0.32))
        let white5 = Light.Bulb(💡.Color(name: .White, brightness: 0.34))
        let white6 = Light.Bulb(💡.Color(name: .White, brightness: 0.36))
        let white7 = Light.Bulb(💡.Color(name: .White, brightness: 0.38))
        let white8 = Light.Bulb(💡.Color(name: .White, brightness: 0.40))
        let white9 = Light.Bulb(💡.Color(name: .White, brightness: 0.42))
        let white10 = Light.Bulb(💡.Color(name: .White, brightness: 0.44))
        
        let start = Light.Scheme([red1, wait1, poweron])
        let end = Light.Scheme([wait1, poweroff])
        
        let reds1 = Light.Scheme([wait1, red1, wait1, red2, wait1, red3, wait1, red4, wait1, red5])
        let reds2 = Light.Scheme([wait1, red5, wait1, red4, wait1, red3, wait1, red2, wait1, red1])
        
        let oranges1 = Light.Scheme([wait1, orange1, wait1, orange2, wait1, orange3, wait1, orange4, wait1, orange5])
        let oranges2 = Light.Scheme([wait1, orange5, wait1, orange4, wait1, orange3, wait1, orange2, wait1, orange1])
        
        
        let yellows1 = Light.Scheme([wait1, yellow1, wait1, yellow2, wait1, yellow3, wait1, yellow4, wait1, yellow5])
        let yellows2 = Light.Scheme([wait1, yellow5, wait1, yellow4, wait1, yellow3, wait1, yellow2, wait1, yellow1])
        
        let whites1 = Light.Scheme([wait1, white1, wait1, white2, wait1, white3, wait1, white4, wait1, white5, wait1, white6, wait1, white7, wait1, white8, wait1, white9, wait1, white10])
        let whites2 = Light.Scheme([wait1, white10, wait1, white9, wait1, white8, wait1, white7, wait1, white6, wait1, white5, wait1, white4, wait1, white3, wait1, white2, wait1, white1])
        
        let breathe1 = Light.Bulb(💡.Breathe(color: .White, period: 3, cycles: 100))
        
        let forward = Light.Scheme([reds1, wait1, breathe1, wait2, oranges1, wait1, yellows1, wait1, whites1, wait3])
        let backward = Light.Scheme([whites2, wait1, yellows2, wait1, oranges2, wait1, breathe1, wait2, reds2, wait3])
        
        let lifx = Lifx(token: token)
        lifx.play(Light.Scheme([start, forward, backward, end]))
    }
}


