# lifx-dsl
Simple language to prototype LIFX light bulb colour schemes

```swift
import Foundation

let poweron = Light.Bulb(💡.Power(on: true))
let poweroff = Light.Bulb(💡.Power(on: false))
let wait = Light.Bulb(💡.Wait(duration: 5))
let blue = Light.Bulb(💡.Color(name: .Blue, brightness: 1.0))
let pulse = Light.Bulb(💡.Pulse(color: .Red, period: 0.5, cycles: 10))

let pulseScheme = Light.Scheme([blue, pulse, wait, blue])
let scheme = Light.Scheme([poweron, wait, pulseScheme, poweroff])

let lifx = Lifx(token: "You LIFX token")
lifx.play(scheme)
```
