//: Playground - noun: a place where people can play

import UIKit

// MARK: Strategy pattern - define a behavior

protocol TapBehavior {
    
    func tap()
}

class CatTapBehavior: TapBehavior {
    
    func tap() {
        
        print("Cat is tapping!")
    }
}

class WishListTapBehavior: TapBehavior {
    
    func tap() {
        
        print("This is wish list tap")
    }
}

class SomeViewWithAButton: UIView {
    
    @IBOutlet weak var aButton: UIButton!
    
    var tapBehavior: TapBehavior?
    
    @IBAction func didTapButton(sender: AnyObject) {
        
        tapBehavior?.tap()
    }
}

// MARK: Command pattern - define an action 

protocol Command {
    
    func execute()
    
    func undo()
}

class Light {
    
    func on() {
        
        print("The light is on")
    }
    
    func off() {
        
        print("The light is off")
    }
}

class LightCommand: Command {
    
    let light: Light
    
    init(light: Light) {
        
        self.light = light
    }
    
    func execute() {
        
        light.on()
    }
    
    func undo() {
        
        light.off()
    }
}

let circleLight = Light()

let CircleLightCommand = LightCommand(light: circleLight)

CircleLightCommand.execute()

CircleLightCommand.undo()

class Heating {
    
    func turnUp(degrees: Int) {
        
        print("The heating is set to \(degrees) ◦C")
    }
    
    func turnOff() {
        
        print("The heating is turned off")
    }
}

class HeatingCommand: Command {
    
    let heating : Heating
    
    init(heating: Heating) {
        
        self.heating = heating
    }
    
    func execute() {
        
        heating.turnUp(23)
    }
    
    func undo() {
        
        heating.turnOff()
    }
}

let daikinHeating = Heating()

let daikinHeatingCommand = HeatingCommand(heating: daikinHeating)

daikinHeatingCommand.heating.turnUp(25)

daikinHeatingCommand.execute()

daikinHeatingCommand.undo()

// Closure to execute multiple command.

typealias CommandClosure = () -> Void

var commands = [CommandClosure]()

// Create command for heating

let heatingCommand = { () -> Void in

    let heating = Heating()

    heating.turnUp(23)
}

// Append heatingCommand to commands closure

commands.append(heatingCommand)

// Create command for lighting

let lightCommand = { () -> Void in
    
    let light = Light()
    
    light.on()
}

// Append lightCommand to commands closure

commands.append(lightCommand)

commands[0]() // Execute heatingCommand

commands[1]() // Execute lightCommand

// Adapter Pattern

protocol Legend {
    
    func doSomething() -> (String, String)
}

func doSomethingWithLegend(legend: Legend) {
    
    let (first , second) = legend.doSomething()
}

class Compatible {
    
    let first: String
    
    let second: String
    
    init(first: String, second: String) {
        
        self.first = first
        
        self.second =  second
    }
}

class LegendSwiftAdapter: Legend {
    
    let compatible : Compatible
    
    init(compatible: Compatible) {
        
        self.compatible = compatible
    }
    
    func doSomething() -> (String, String) {
        
        return (compatible.first, compatible.second)
    }
}

class LegendObjcAdapter {
    
    func doSomethingWithTuple(compatible: Compatible) {
        
        let adapter = LegendSwiftAdapter(compatible: compatible)
        
        doSomethingWithLegend(adapter)
    }
}






