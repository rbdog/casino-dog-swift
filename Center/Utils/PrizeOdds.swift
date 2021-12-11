//
//
//

import Foundation

struct PrizeOdds {
    let table: Table
    
    /* cache */
    let totalOdds: Float
    let motherArray = Array(0...1000)
    
    /* init */
    init(table: Table) {
        self.table = table
        self.totalOdds = table.rows.map({$0.odds}).reduce(0, +)
    }
}

extension PrizeOdds {
    struct Table {
        let rows: [Row]
    }
}

extension PrizeOdds.Table {
    struct Row {
        let prizeID: String
        let odds: Float
        let description: String
    }
}

extension PrizeOdds {
    func randomRowWithOdds() -> Table.Row {
        let borderOdds: Float = Float(self.motherArray.randomElement()!)/Float(1000)
        
        var oddsGauge: Float = 0
        for row in table.rows {
            oddsGauge += Float(row.odds)/Float(totalOdds)
            
            if borderOdds <= oddsGauge {
                return row
            }
        }
        fatalError("need more odds totally")
    }
}

extension PrizeOdds {
    func test(times: Int) {
        /* init */
        // Prize ID : count
        var result: [String:Int] = [:]
        var configOdds: [String:Float] = [:]
        
        for row in self.table.rows {
            result[row.prizeID] = 0
            configOdds[row.prizeID] = row.odds/totalOdds
        }
        // test
        for _ in 1...times {
            let row = self.randomRowWithOdds()
            result[row.prizeID]! += 1
        }
        
        /* formatter */
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 3
        formatter.maximumFractionDigits = 2
        
        print("+----------+")
        print("| テスト結果 |")
        print("+----------+")
        print("試行回数: \(times)回")
        print("Prize  設定確率(%)  出た回数  実際の確率(%)")
        for row in self.table.rows {
            let A = row.description
            let B = configOdds[row.prizeID]!
            let C = result[row.prizeID]!
            let D = Float(result[row.prizeID]!)/Float(times)
            let fB = formatter.string(for: B)!
            let fD = formatter.string(for: D)!
            
            print("\(A)  \(fB)  \(C)  \(fD)")
        }
    }
}
