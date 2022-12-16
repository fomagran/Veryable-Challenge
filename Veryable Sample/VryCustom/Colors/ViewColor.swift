//
//  ViewColor.swift
//  Veryable
//
//  Created by Isaac Sheets on 10/11/20.
//  Copyright © 2020 Veryable, Inc. All rights reserved.
//

import Foundation
import UIKit

public enum ViewColor: VColor {
    case background
    case surface
    case primaryBlue
    case primaryBlueDark
    case greyDark
    case grey
    case greyLight
    case greyDisabled
    case accountName
    case desc
    
    var color: UIColor {
        switch self {
        case .background:
            return UIColor(named: "Background")!
        case .surface:
            return UIColor(named: "Surface")!
        case .primaryBlue:
            return UIColor(named: "PrimaryBlue")!
        case .primaryBlueDark:
            return UIColor(named: "PrimaryBlueDark")!
        case .greyDark:
            return UIColor(named: "GreyDark")!
        case .grey:
            return UIColor(named: "Grey")!
        case .greyLight:
            return UIColor(named: "GreyLight")!
        case .greyDisabled:
            return UIColor(named: "GreyDisabled")!
        case .accountName:
            return UIColor(hexString: "#4A4A4A")
        case .desc:
            return UIColor(hexString: "#7E7E7E")
        }
    }
}
