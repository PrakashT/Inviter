//
//  HelpConstants.swift
//  Martins
//
//  Created by Enterpi iOS on 08/08/16.
//  Copyright © 2016 Enterpi iOS. All rights reserved.
//

import UIKit

class HelpConstants
{

//    static let MAINSTORYBOARD = UIStoryboard(name: "Main", bundle: nil)


    //**************//
    // MARK: - MAFrameConstants
    static let SCREEN_WIDTH = (UIScreen.main.bounds.size.width)
    static let SCREEN_HEIGHT = (UIScreen.main.bounds.size.height)
    static let SCREEN_MAX_LENGTH = (max(SCREEN_WIDTH, SCREEN_HEIGHT))
    static let SCREEN_MIN_LENGTH = (min(SCREEN_WIDTH, SCREEN_HEIGHT))

    static let IS_IPHONE = (UIDevice.current.userInterfaceIdiom == .phone)
    static let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
    static let IS_IPHONE_5 = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
    static let IS_IPHONE_6 = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
    static let IS_IPHONE_6P = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
    static let BORDER_WIDTH = 2.0
    static let CORNER_RADIUS = 5.0
    static let MAX_FILE_SIZE_OF_RESUME = 750.0
    //**************//


    static let USER_DEFAULTS = UserDefaults.standard

    // MARK: MA App Constant Values
    static let PHONE_NUMBER_COUNT = 10
    static let PASSWORD_MAX_COUNT = 8
    static let DEFAULT_MAX_COUNT = 3

}

