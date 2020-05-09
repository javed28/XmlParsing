//
//  XMLParsingUtility.swift
//  XmlParsing
//
//  Created by JAVED SIDDIQUE on 09/05/20.
//  Copyright © 2020 JAVED SIDDIQUE. All rights reserved.
//

import Foundation

struct Plant{
    var Common : String
    var Botanical : String
    var Zone : String
}

struct CD{
    var Title : String
    var Artist : String
    var Country : String
}

class PlantParser : NSObject,XMLParserDelegate{
    private var plantItems : [Plant] = []
    private var currentElement = ""
    private var currentCommon : String = ""
    private var currentBotanical : String = ""
    private var currentZone : String = ""
    private var parserCompletionHandler : (([Plant])-> Void)?
    
    
    func parserPlantData(data : Data,completionHandler : (([Plant])-> Void)?){
        self.parserCompletionHandler = completionHandler
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        if currentElement == "PLANT"{
            currentCommon = ""
            currentBotanical = ""
            currentZone = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "COMMON" : currentCommon += string
        case "BOTANICAL" : currentBotanical += string
        case "ZONE" : currentZone += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "PLANT"{
            let plantItem = Plant(Common: currentCommon, Botanical: currentBotanical, Zone: currentZone)
            self.plantItems.append(plantItem)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        self.parserCompletionHandler?(plantItems)
    }
 
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}



class CDParser : NSObject,XMLParserDelegate{
    private var cdItems : [CD] = []
    private var currentElement = ""
    private var currentTitle : String = ""
    private var currentArtist : String = ""
    private var currentCountry : String = ""
    private var parserCompletionHandler : (([CD])-> Void)?
    
    
    func parserCDData(data : Data,completionHandler : (([CD])-> Void)?){
        self.parserCompletionHandler = completionHandler
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        if currentElement == "CD"{
            currentTitle = ""
            currentArtist = ""
            currentCountry = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "TITLE" : currentTitle += string
        case "ARTIST" : currentArtist += string
        case "COUNTRY" : currentCountry += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "CD"{
            let cdItem = CD(Title: currentTitle, Artist: currentArtist, Country: currentCountry)
            self.cdItems.append(cdItem)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        self.parserCompletionHandler?(cdItems)
    }
 
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
