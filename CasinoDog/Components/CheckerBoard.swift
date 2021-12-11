//
//
//

import SwiftUI

struct Checkerboard: Shape {
    let rows: Int
    let columns: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // figure out how big each row/column needs to be
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)

        // loop over all rows and columns, making alternating squares colored
        for row in 0 ..< rows {
            for column in 0 ..< columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}

struct CheckerboardView: View {
    let backColor: Color
    let frontColor: Color
    init(color1: Color, color2: Color) {
        self.backColor = color1
        self.frontColor = color2
    }
    
    var body: some View {
        ZStack {
            backColor
            Checkerboard(rows: 10, columns: 10)
                .fill(frontColor)
                .aspectRatio(1, contentMode: .fill)
        }
    }
}
