//
//
//

import UIKit

struct QRCode {
    
    /// 補正しなくて良い場合はL
    enum Level: String {
        case L7
        case M15
        case Q25
        case H30
        
        var value: String {
            switch self {
            case .L7:
                return "L"
            case .M15:
                return "M"
            case .Q25:
                return "Q"
            case .H30:
                return "H"
            }
        }
    }
    
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func uiImage(level: Level) -> UIImage {
        let filter = CIFilter(
            name: "CIQRCodeGenerator",
            parameters: [
                "inputMessage": data,
                "inputCorrectionLevel": level.value
            ]
        )!
        let colorFilter = CIFilter(
            name: "CIFalseColor",
            parameters: [
                "inputImage": filter.outputImage!,
                "inputColor1": CIColor(red: 1, green: 1, blue: 1),
                "inputColor0": CIColor(red: 1, green: 0, blue: 0)
            ]
        )!
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let ciImage = colorFilter.outputImage!.transformed(by: transform)
        let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent)!
        return UIImage(cgImage: cgImage)
    }
}
