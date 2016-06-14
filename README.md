# lifx-dsl
Simple language to prototype LIFX light bulb colour schemes

```swift
import Foundation

let poweron = Light.Bulb(💡.Power(on: true))
let poweroff = Light.Bulb(💡.Power(on: false))
let pause = Light.Bulb(💡.Wait(duration: 1))
let pulseDuration = Light.Bulb(💡.Wait(duration: 5))
let blue = Light.Bulb(💡.Color(name: .Blue, brightness: 1.0))
let pulseRed = Light.Bulb(💡.Pulse(color: .Red, period: 0.5, cycles: 10))

let pulseScheme = Light.Scheme([blue, pulseRed, pulseDuration])
let scheme = Light.Scheme([blue, poweron, pause, pulseScheme, poweroff])

let lifx = Lifx(token: "Your LIFX token")
lifx.play(scheme)
```
