import Foundation

struct CalculatorLogic {
    private var intermediateCalculation: (operand1: Double, operation: String)?

    mutating func perform(operation: String, value: Double) -> Double? {
        switch operation {
        case "+/-":
            return value * -1
        case "AC":
            return 0
        case "%":
            return value / 100
        case "=":
            return performBinaryOperation(operand2: value)
        default:
            intermediateCalculation = (operand1: value, operation: operation)
            return nil
        }
    }

    func performBinaryOperation(operand2: Double) -> Double? {
        if let (operand1, operation) = intermediateCalculation {
            switch operation {
            case "+":
                return operand1 + operand2
            case "-":
                return operand1 - operand2
            case "×":
                return operand1 * operand2
            case "÷":
                return operand1 / operand2
            default:
                fatalError("Unknown operation")
            }
        }
        return nil
    }
}
