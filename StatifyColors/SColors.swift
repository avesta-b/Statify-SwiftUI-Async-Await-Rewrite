//
//  SColors.swift
//  StatifyColors
//
//  Created by Avesta Barzegar on 2022-03-04.
//

import UIKit

extension UIColor {
    
    static private var bundle = Bundle(for: SColors.self)
    
    static internal func getColor(named: String) -> UIColor {
        return UIColor(named: named, in: self.bundle, compatibleWith: nil) ?? UIColor.white
    }
    
}

public class SColors {
    
    public static var backgroundColor: UIColor {
        return UIColor.getColor(named: "BackgroundColor")
    }
    
    public static var lightGreen: UIColor {
        return UIColor.getColor(named: "LightGreen")
    }
    
    public static var pear: UIColor {
        return UIColor.getColor(named: "Pear")
    }
    
    public static var secondaryBackgroundColor: UIColor {
        return UIColor.getColor(named: "SecondaryBackgroundColor")
    }
    
    public static var spotifyGray: UIColor {
        return UIColor.getColor(named: "SpotifyGray")
    }
    
    public static var spotifyGreen: UIColor {
        return UIColor.getColor(named: "SpotifyGreen")
    }
    
    public static var spotifyLightGreen: UIColor {
        return UIColor.getColor(named: "SpotifyLightGreen")
    }
    
    public static var spotifyTurkoise: UIColor {
        return UIColor.getColor(named: "SpotifyTurkoise")
    }
    
    public static var spotifyWhite: UIColor {
        return UIColor.getColor(named: "SpotifyWhite")
    }
    
    public static var tertiaryBackgroundColor: UIColor {
        return UIColor.getColor(named: "TertiaryBackgroundColor")
    }
}
