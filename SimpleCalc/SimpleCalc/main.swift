//
//  main.swift
//  SimpleCalc
//
//  Created by Kiwon Jeong on 2017. 10. 6..
//  Copyright © 2017년 Kiwon Jeong. All rights reserved.
//

import Foundation

var exit = false;
var result:UInt = 0;
print("$ calc - press 'q' to exit")

while (!exit) {
    print("Enter an expression separated by returns:")
    result = 0
    let response = readLine(strippingNewline: true)!
    var systemState = 0
    if (response.contains("count")) {
       systemState = 1
    } else if (response.contains("avg")) {
        systemState = 2
    } else if (response.contains("fact")) {
        systemState = 3
    }
    
    
    if (response == "q") {
        exit = !exit
    } else if (systemState != 0) {
        let trimmedValue = response.split(separator: " ")
        
        // check if there is any invalid value
        var factCounter = 0
        for index in trimmedValue {
            factCounter += 1
            if (index != "count" && index != "avg" && index != "fact") {
                if (UInt.init(index) == nil) {
                    systemState = 0
                }
            } else if(index == "fact" && factCounter > 2 || factCounter <= 1) {
                systemState = 0
            }
        }
        
        // change the result value based on the desired multi-operand
        switch systemState {
        case 1:
            for _ in trimmedValue {
                result += 1
            }
            result -= 1
        case 2:
            var counter:UInt = 0
            for index in trimmedValue {
                if(UInt.init(index) != nil) {
                    result += UInt.init(index)!
                    counter += 1
                }
            }
            result /= counter
        case 3:
            var factNum:UInt = 0
            result = 1
            for index in trimmedValue {
                if(UInt.init(index) != nil) {
                    factNum = UInt.init(index)!
                }
            }
            for index in 1...factNum {
                result *= index
            }
        default:
            print("Enter an appropriate value")
        }
        if (systemState != 0) {
            print(result)
        }
    } else if (UInt.init(response) != nil) {
        let response2 = readLine(strippingNewline: true)!
        // check if the operation is correct
        if (response2 == "q") {
            exit = !exit
            systemState = -1
        } else if (response2 != "+" && response2 != "-" && response2 != "*" && response2 != "/" && response2 != "%") {
            systemState = -1
        } else {
            let response3 = readLine(strippingNewline: true)!
            if (UInt.init(response3) != nil) {
                let num = UInt.init(response)!
                let num2 = UInt.init(response3)!
                switch response2 {
                case "+":
                    result = num + num2
                case "-":
                    result = num - num2
                case "*":
                    result = num * num2
                case "/":
                    result = num / num2
                case "%":
                    result = num - ((num/num2) * num2)
                default:
                    print("Enter an appropriate value")
                }
            } else if (response3 == "q") {
                exit = !exit
                systemState = -1
            } else {
                systemState = -1
            }
        }
        if (systemState != -1) {
            print("Result: \(result)")
        }
    } else {
        print("Enter an appropriate value")
    }
}

