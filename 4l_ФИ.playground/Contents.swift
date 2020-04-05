import UIKit

  // задание достаточно сложное для меня, нужно больше знаний ООП, сделал по аналогии с разбором

class Car {
    

    enum EngineStatus: CustomStringConvertible {
        case on, off
        
        var description: String {
            switch self {
            case .on:
                return "Двигатель работает"
            case .off:
                return "Двигатель не работает"
            }
        }
    }

    enum WindowsStatus: CustomStringConvertible {
           case opened, closed

           var description: String {
               switch self {
               case .opened:
                   return "Окна открыты"
               case .closed:
                   return "Окна закрыты"
               }
           }
       }

    enum TrunckBodyType: CustomStringConvertible {
        case box, tank, refrigerator

        var description: String {
            switch self {
            case .box:
                return "Стандартный кузов"
            case .tank:
                return "Цистерна"
            case .refrigerator:
                return "Холодильная камера"
                }
            }
        }

    
    enum Action {
        case switchEngine(EngineStatus)
        case switchWindows(WindowsStatus)
        case loadCargo(Double)
        case attachTruckBody(TrunckBodyType)
        case replaceTyre
    }
    
        var brand: String
        var productionYear: Int
        var engine: EngineStatus = .off
        var windows: WindowsStatus = .closed
        

        init(brand: String, productionYear: Int) {
            self.brand = brand
            self.productionYear = productionYear
            
        }

    func perform(action: Action){
    }
    
}


class TrunkCar: Car, CustomStringConvertible {
    
    static var typeEmoji = "🚚"
    let maxCargoSpace: Double
    var currentCargoSpace: Double = 0
    var body: TrunckBodyType?
    
    var description: String {
        let bodyDescription = body?.description ?? "Отцеплен"
        
        return "\(TrunkCar.typeEmoji) \(brand) \nГод выпускаЖ \(productionYear)\nКузова: \(bodyDescription) \(currentCargoSpace)/\(maxCargoSpace)\(engine)|\(windows)\n"
    }
    
    init(brand: String, productionYear:Int, maxCargoSpace:Double, body:TrunckBodyType?){
        self.body = body
        self.maxCargoSpace = maxCargoSpace
        super.init(brand: brand, productionYear: productionYear)
    }
    
    override func perform(action: Action) {
        switch action {
        case .switchEngine(let status):
            engine = status
        case .switchWindows(let status):
            windows = status
        case .loadCargo(let load):
            guard body != nil else {
                return
        }
            let expectedLoad = load + currentCargoSpace
            switch expectedLoad {
            case _ where expectedLoad > maxCargoSpace:
                currentCargoSpace = maxCargoSpace
            case _ where expectedLoad < 0:
                currentCargoSpace = 0
            default:
                currentCargoSpace += load
            }
        case .attachTruckBody(let newBody):
            self.body = newBody
            currentCargoSpace = 0
        default:
            break
        }
    }
}

class SportCar: Car, CustomStringConvertible {
    
    static var typeEmoji = "🏎"
    var acceleration: Double = 0.0
    var maxSpeed: Int = 0
    
    var description: String {
          
        return "\(SportCar.typeEmoji) \(brand) \nГод выпускаЖ \(productionYear)\nРазгон 0-100 км/ч: \(acceleration)с\n Максимальная скорость: \(maxSpeed)км/ч\nСостояние: \(engine)|\(windows)\n"
    }
     
    init(brand: String, productionYear:Int, acceleration:Double, maxSpeed: Int){
           self.acceleration = acceleration
           self.maxSpeed = maxSpeed
           super.init(brand: brand, productionYear: productionYear)

    }
    override func perform(action: Action) {
        switch action {
        case .switchEngine(let status):
            engine = status
        case .switchWindows(let status):
            windows = status
        case .replaceTyre:
            print("Произведлена замена шин")
        default:
            break
        }
    }
}

var volvo = TrunkCar(brand: "Volvo", productionYear: 1999, maxCargoSpace: 5000, body: .tank)
volvo.perform(action: .switchEngine(.on))
volvo.perform(action: .loadCargo(500))
volvo.perform(action: .switchWindows(.opened))

print(volvo)

var honda = SportCar(brand: "Honda", productionYear: 2000, acceleration: 6.0, maxSpeed: 250)


print(honda)
honda.perform(action: .replaceTyre)
