//
//  ColorGetter.swift
//  preferrd
//
//  Created by Timothy Ananda on 21/06/21.
//

import UIKit

struct ColorManager {
    
    func getRelatedColors(themes: [ColorTheme]) -> [Color] {
        var allColors = Constants.colors
        var relatedColors = [Color]()
        
        var indexToRemove = [Int]()
        
        // All themes same
        for i in 0...(allColors.count-1) {
            if themes.allSatisfy({ (theme: ColorTheme) -> Bool in
                return allColors[i].relatedTags.contains(theme)
            }) {
                relatedColors.append(allColors[i])
                indexToRemove.append(i)
            }
        }
        
        allColors = filteredColors(colors: allColors, indexToRemove: indexToRemove)
        indexToRemove.removeAll()

        var themeForCheck = [ColorTheme]()

        if themes.count == 3 {

            //0&1
            themeForCheck.append(themes[0])
            themeForCheck.append(themes[1])
            for i in 0...(allColors.count-1) {
                if themeForCheck.allSatisfy({ (theme: ColorTheme) -> Bool in
                    return allColors[i].relatedTags.contains(theme)
                }) {
                    relatedColors.append(allColors[i])
                    indexToRemove.append(i)
                }
            }

            allColors = filteredColors(colors: allColors, indexToRemove: indexToRemove)
            indexToRemove.removeAll()

            themeForCheck.removeAll()

            //0&2
            themeForCheck.append(themes[0])
            themeForCheck.append(themes[2])
            for i in 0...(allColors.count-1) {
                if themeForCheck.allSatisfy({ (theme: ColorTheme) -> Bool in
                    return allColors[i].relatedTags.contains(theme)
                }) {
                    relatedColors.append(allColors[i])
                    indexToRemove.append(i)
                }
            }

            allColors = filteredColors(colors: allColors, indexToRemove: indexToRemove)
            indexToRemove.removeAll()

            themeForCheck.removeAll()

            //1&2
            themeForCheck.append(themes[1])
            themeForCheck.append(themes[2])
            for i in 0...(allColors.count-1) {
                if themeForCheck.allSatisfy({ (theme: ColorTheme) -> Bool in
                    return allColors[i].relatedTags.contains(theme)
                }) {
                    relatedColors.append(allColors[i])
                    indexToRemove.append(i)
                }
            }

            allColors = filteredColors(colors: allColors, indexToRemove: indexToRemove)
            indexToRemove.removeAll()

            themeForCheck.removeAll()
        }

        if themes.count >= 2 {
            for i in 0...(allColors.count-1) {
                if allColors[i].relatedTags.contains(themes[0]) {
                    relatedColors.append(allColors[i])
                    indexToRemove.append(i)
                }
            }

            allColors = filteredColors(colors: allColors, indexToRemove: indexToRemove)
            indexToRemove.removeAll()

            for i in 0...(allColors.count-1) {
                if allColors[i].relatedTags.contains(themes[1]) {
                    relatedColors.append(allColors[i])
                    indexToRemove.append(i)
                }
            }

            allColors = filteredColors(colors: allColors, indexToRemove: indexToRemove)
            indexToRemove.removeAll()

            if themes.count == 3 {
                for i in 0...(allColors.count-1) {
                    if allColors[i].relatedTags.contains(themes[2]) {
                        relatedColors.append(allColors[i])
                        indexToRemove.append(i)
                    }
                }

                allColors = filteredColors(colors: allColors, indexToRemove: indexToRemove)
                indexToRemove.removeAll()
            }
        }

        return relatedColors
    }
    
    func filteredColors(colors: [Color], indexToRemove: [Int]) -> [Color] {
        var newColors = colors
        
        for i in stride(from: (indexToRemove.count-1), through: 0, by: -1) {
            newColors.remove(at: indexToRemove[i])
        }
        
        return newColors
    }
}
