//
// +------------------+
// | AsciiTable.swift |
// +------------------+
//
import Foundation

/*
 +------------+
 | How to Use |
 +------------+
 ``
 let sample = Ascii.Table.Sample.jsonData

 # 1. init
 let table = Ascii.Table(json: sample)

 # 2. print
 for text in table.texts {
 print(text)
 }

 # 3. Serialize
 let json = table.jsonData
 ``
 */
extension Ascii.Table {
    public enum Sample {
        /// this is a sample
        public static let rawTexts: (columns: [String], rows: [[String]]) = {
            return (
                columns: ["1", "2", "3"],
                rows: [
                    ["4", "5", "6"],
                    ["7", "8", "9"]
                ]
            )
        }()
        /// this is a sample
        public static let jsonData: Data = """
            {
              "columns": [
                {"key": "keyA", "width": 8},
                {"key": "keyB", "width": 10}
              ],
              "rows": [
                {"cells":[
                    {"key": "keyA", "value": "valueA0"},
                    {"key": "keyB", "value": "valueB0"}
                ]},
                {"cells": [
                    {"key": "keyA", "value": "valueA1"},
                    {"key": "keyB", "value": "valueB1"}
                ]}
              ]
            }
            """.data(using: .utf8)!
        /// this is a sample
        public static let rows: [Row] = [
            Row(cells: [
                Cell(key: "XXX",
                     value: "aaa"),
                Cell(key: "YYY",
                     value: "bbb")
            ]),
            Row(cells: [
                Cell(key: "XXX",
                     value: "ccc"),
                Cell(key: "YYY",
                     value: "ddd")
            ])
        ]
    }
}
private protocol AsciiTable {

    /// [
    ///   "+----------+------------+",
    ///   "|     keyA |       keyB |",
    ///   "+----------+------------+",
    ///   "|  valueA0 |    valueB0 |",
    ///   "+----------+------------+",
    ///   "|  valueA1 |    valueB1 |",
    ///   "+----------+------------+"
    /// ]
    /// texts for output
    var texts: [String] { get }

    /// init with Swift Type
    init(columns: [Ascii.Table.Column]?, rows: [Ascii.Table.Row])

    /// init with String Array
    init(columns: [String], rows: [[String]])
}

public enum Ascii {
    public struct Table {
        public struct Column {
            let key: String
            var width: Int?
        }
        public struct Row {
            let cells: [Cell]
        }
        public struct Cell {
            let key: String
            let value: String
        }
        public let columns: [Column]
        public let rows: [Row]
    }
}
extension Ascii.Table: AsciiTable {
    init(columns: [Ascii.Table.Column]? = nil, rows: [Ascii.Table.Row]) {
        self.columns = (columns ?? rows.first?.cells.map { Column(key: $0.key) }) ?? []
        self.rows = rows
    }
    init(columns: [String], rows: [[String]]) {
        self.columns = columns.map {Column(key: $0)}
        self.rows = rows.map { row -> Row in
            return Row(cells: row.enumerated().map {
                        Cell(key: columns[$0.offset], value: $0.element)
            })
        }
    }
    var texts: [String] {
        let borderLines = [String](repeating: self.horizontalBorder,
                                   count: self.rows.count).map { [$0] }
        let rowLines = self.rows.map {self.stringRow(for: $0.cells)}
        let zipped = zip(borderLines, rowLines)
        let alts = [String](zipped.map { $0.0 + $0.1 }.joined())

        return [self.horizontalBorder]
            + [self.stringColumns]
            + alts
            + [self.horizontalBorder]
    }
}
extension Ascii.Table: JSONSerializable {}
extension Ascii.Table.Row: JSONSerializable {}
extension Ascii.Table.Column: JSONSerializable {}
extension Ascii.Table.Cell: JSONSerializable {}
fileprivate extension Ascii.Table.Cell {
    func lineBrokenValue(by count: Int) -> [String] {
        return self.value.split(by: count).map {$0.filled(to: count)}
    }
}
fileprivate extension Ascii.Table {
    func cells(at line: Int) -> [Ascii.Table.Cell]? {
        return self.rows[at: line]?.cells
    }
    var horizontalBorder: String {
        return "+-" + self.columns.map {
            [String](repeating: "-", count: $0.width ?? $0.key.count).joined()
        }.joined(separator: "-+-") + "-+"
    }
    var stringColumns: String {
        return "| " + self.columns.map {
            $0.key.filled(to: $0.width ?? $0.key.count)
        }.joined(separator: " | ") + " |"
    }
    func stringRow(for cells: [Ascii.Table.Cell]) -> [String] {
        let lineBrokens = self.columns.map { c -> [String] in
            return cells.first(where: {$0.key == c.key})!
                .lineBrokenValue(by: c.width ?? c.key.count)
        }
        let cellHeight = lineBrokens.max(by: {return $0.count < $1.count})!.count
        let filledToHeight = lineBrokens.map {
            $0 + [String](repeating: "", count: cellHeight - $0.count)
        }
        return filledToHeight.transpose().map {"| " + $0.joined(separator: " | ") + " |"}
    }
}
