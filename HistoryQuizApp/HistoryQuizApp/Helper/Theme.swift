
import Foundation
import UIKit

enum Color {
    case SeperatorColor
    case ThemeColor
    case Black
    case Placeholder
    case White
    case SearchBarBG
    case btnOrnage
    case lightGray
    case textGray
    case DarkGray
    case textDrakGray
    case Blue
    case Green
    case darkGreen
    case LightBlue
    
    
    case custom(hexString: String, alpha: Double)
    
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
}

extension Color {
    var value: UIColor {
        var instanceColor = UIColor.clear
        switch self {
        case .LightBlue:
            instanceColor = UIColor(hexString: "#3774EA") // 204 204 204
        case .SeperatorColor:
            instanceColor = UIColor(hexString: "#CCCCCC") // 204 204 204
        case .ThemeColor:
            instanceColor = UIColor(hexString: "#FF0000") // 204 204 204
        case .Green:
            instanceColor = UIColor(hexString: "#06c98e") // 204 204 204
        case .darkGreen:
            instanceColor = UIColor(hexString: "#2C7F0A") // 204 204 204
        case .Placeholder:
            instanceColor = UIColor(hexString: "#BBBBBB") // 204 204 204
            
        case .DarkGray:
            instanceColor = UIColor(hexString: "#3a3a3a") // 204 204 204
        
        case .Blue:
            instanceColor = UIColor(hexString: "#05478A") // 204 204 204
        case .Black:
            instanceColor = UIColor(hexString: "#000")
            
        case .White:
            instanceColor = UIColor.white
            
        case .btnOrnage:
            instanceColor = UIColor(hexString: "#F68A4A") // 246 138 74
            
        case .SearchBarBG:
            instanceColor = UIColor(hexString: "#DCDCDC") // 220 220 220 
            
        case .lightGray:
            instanceColor = UIColor(hexString: "#AFAFAF") // 241 241 241
            
        case .textGray:
            instanceColor = UIColor(hexString: "#686868") // 104 104 104
            
        case .textDrakGray:
            instanceColor = UIColor(hexString: "#A8A8A8") // 168 168 168

        case .custom(let hexValue, let opacity):
            instanceColor = UIColor(hexString: hexValue).withAlphaComponent(CGFloat(opacity))
        }
        return instanceColor
    }
}
extension UILabel{
    func settextTheameColor()  {
        self.textColor = Color.Black.value
    }
}
extension UITextField{
    func settextBlackColor()  {
        self.textColor = Color.Black.value
    }
}

extension UIButton {
    func setTheameBackColorWhiteText() {
        self.backgroundColor = Color.ThemeColor.value
        self.setTitleColor(Color.White.value, for: .normal)
    }
}
extension UIColor {
    /**
     Creates an UIColor from HEX String in "#363636" format
     
     - parameter hexString: HEX String in "#363636" format
     
     - returns: UIColor from HexString
     */
    convenience init(hexString: String) {
        
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner          = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}



// Font

struct Font {
    
    enum FontType {
        case custom(FontName)
    }
    enum FontSize {
        case standard(StandardSize)
        var value: CGFloat {
            switch self {
            case .standard(let size):
                return size.fontSize()
            }
        }
    }
    enum FontName: String {
        case Quicksand_Light    = "Quicksand-Light"
        case Quicksand_Medium    = "Quicksand-Medium"
        case Quicksand_Regular   = "Quicksand-Regular"
        case OpenSans_Light_Italic = "OpenSansLight-Italic"
    }

    enum StandardSize : Int{
        case Extra2Small = 0
        case ExtraSmall = 1
        case Small = 2
        case RegularSmall = 3
        case Regular = 4
        case RegularLarge = 5
        case Large = 6
        case ExtraLarge = 7
        case Extra2Large = 8

        
        func fontSize()->CGFloat{
            switch self{
            case .Extra2Small:
                return getSizeForDeviceType(13.0, ipadFSize: 18.0, iphoneFSize: 10.0,iphone4SFSize: 9.0)
            case .ExtraSmall:
                return getSizeForDeviceType(14.0, ipadFSize: 19.0, iphoneFSize: 11.0,iphone4SFSize: 10.0)
            case .Small:
                return getSizeForDeviceType(16.0, ipadFSize: 21.0, iphoneFSize: 12.0,iphone4SFSize: 12.0);
            case .RegularSmall:
                return getSizeForDeviceType(17.0, ipadFSize: 22.0, iphoneFSize: 14.0,iphone4SFSize: 13.0);
            case .Regular:
                return getSizeForDeviceType(18.0, ipadFSize: 23.0, iphoneFSize: 14.0,iphone4SFSize: 14.0);
            case .RegularLarge:
                return getSizeForDeviceType(20.0, ipadFSize: 25.0, iphoneFSize: 18.0,iphone4SFSize: 16.0);
            case .Large:
                return getSizeForDeviceType(23.0, ipadFSize: 28.0, iphoneFSize: 20.0,iphone4SFSize: 19.0);
            case .ExtraLarge:
                return getSizeForDeviceType(28.0, ipadFSize: 33.0, iphoneFSize: 25.0,iphone4SFSize: 23.0);
            case .Extra2Large:
                return getSizeForDeviceType(57.0, ipadFSize: 63.0, iphoneFSize: 55.0,iphone4SFSize: 54.0);
                
            }
        }
        
    }
        var type: FontType
        var size: FontSize
        init(_ type: FontType, size: FontSize) {
            self.type = type
            self.size = size
        }

}
// How to use:
//Font(.custom(.GillSans_Regular), size: .standard(.Regular)).instance

func getSizeForDeviceType(_ sixPlusFSize : CGFloat, ipadFSize : CGFloat, iphoneFSize : CGFloat,iphone4SFSize : CGFloat)->CGFloat
{
    return DeviceType.IS_IPHONE_6_PLUS ? sixPlusFSize : (DeviceType.IS_IPAD ? ipadFSize : (DeviceType.IS_IPHONE_4_OR_LESS ? iphone4SFSize : iphoneFSize))
    
}

extension Font {
    var instance: UIFont {
        var instanceFont: UIFont!
        switch type {

        case .custom(let fontName):
            guard let font =  UIFont(name: fontName.rawValue, size: CGFloat(size.value)) else {
                fatalError("\(fontName.rawValue) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        }
        return instanceFont
    }
}




