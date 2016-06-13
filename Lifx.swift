//
//  Lifx.swift
//  lifx
//
//  Created by John Moore on 12/06/2016.
//  Copyright © 2016 John P. T. Moore. All rights reserved.
//

import Foundation

class Lifx {
    
    var token: String
    var selector: String

    init(token: String, selector: String = "all") {
        self.token = token
        self.selector = selector
    }
    
    private func eval(expression: Light) {
        switch expression {
        case let .Bulb(lightbulb):
            parse(lightbulb.description)
        case let .Scheme(array):
            array.forEach { eval($0) }
        }
    }
    
    private func parse(command: CommandType) {
        switch command {
        case ("Color", _):
            color(command.1)
        case ("Breathe", _):
            breathe(command.1)
        case ("Pulse", _):
            pulse(command.1)
        case ("Wait", _):
            wait(command.1)
        case ("Power", _):
            power(command.1)
        default:
            print("default")
        }
    }
    
    private func toJsonData(dict: AnyObject) -> NSData? {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
            return jsonData
        } catch let error as NSError {
            print(error)
        }
        return nil
    }

    private func webQuery(request: NSMutableURLRequest, data: NSData) {
        let session = NSURLSession.sharedSession()
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.HTTPBody = data
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) in
            //print(response)
            guard let _ = data else {
                print("Did not receive data")
                return
            }
            guard error == nil else {
                print(error)
                return
            }
        }
        task.resume()
    }
    
    private func setState(dict: [String: AnyObject]) {
        let endpoint = "https://api.lifx.com/v1/lights/\(selector)/state"
        guard let url = NSURL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        if let jsonData = toJsonData(dict), jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) {
            print(jsonString)
            webQuery(request, data: jsonData)
        }
    }
    
    private func setEffect(endpoint: String, dict: [String: AnyObject]) {
        guard let url = NSURL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        let request = NSMutableURLRequest(URL: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        if let jsonData = toJsonData(dict), jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) {
            print(jsonString)
            webQuery(request, data: jsonData)
        }
    }
    
    private func setBreatheEffect(dict: [String: AnyObject]) {
        let endpoint = "https://api.lifx.com/v1/lights/\(selector)/effects/breathe"
        setEffect(endpoint, dict: dict)
    }
    
    private func setPulseEffect(dict: [String: AnyObject]) {
        let endpoint = "https://api.lifx.com/v1/lights/\(selector)/effects/pulse"
        setEffect(endpoint, dict: dict)
    }
    
    private func power(dict: [String: AnyObject]) {
        if let on: Bool = dict["on"] as? Bool {
            if on {
                setState(["power": "on"])
            } else {
                setState(["power": "off"])
            }
        }
    }
    
    private func wait(dict: [String: AnyObject]) {
        if let duration: Double = dict["duration"] as? Double {
            NSThread.sleepForTimeInterval(duration)
        }
    }
    
    private func color(dict: [String: AnyObject]) {
        if let color: String = dict["color"] as? String {
            setState(["color": color])
        }
    }
    
    private func breathe(dict: [String: AnyObject]) {
        if let color = dict["color"], let period = dict["period"], let cycles = dict["cycles"] {
            setBreatheEffect(["color": color, "period": period, "cycles": cycles])
        }
    }
    
    private func pulse(dict: [String: AnyObject]) {
        if let color = dict["color"], let period = dict["period"], let cycles = dict["cycles"] {
            setPulseEffect(["color": color, "period": period, "cycles": cycles])
        }
    }
    
    // loop to allow web requests to complete
    private func readStdin(scheme: Light) {
        let delim:Character = "\n"
        var input:String    = ""
        print("Available commands: 'repeat', 'quit'.")
        print("> ", terminator:"")
        while true {
            let c = Character(UnicodeScalar(UInt32(fgetc(stdin))))
            if c == delim {
                switch input {
                    case "quit":
                        exit(EXIT_SUCCESS)
                    case "repeat":
                        eval(scheme)
                    default: break
                }
                input = ""
                print("> ", terminator:"")
            } else {
                input.append(c)
            }
        }
    }
    
    func play(scheme: Light) {
        eval(scheme)
        readStdin(scheme)
    }
    
}