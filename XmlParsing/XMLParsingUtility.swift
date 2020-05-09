//
//  XMLParsingUtility.swift
//  XmlParsing
//
//  Created by JAVED SIDDIQUE on 09/05/20.
//  Copyright © 2020 JAVED SIDDIQUE. All rights reserved.
//

import Foundation



class FeedParser : NSObject,XMLParserDelegate{
    private var rssItems : [RSSItem] = []
    private var currentElement = ""
    private var currentTitle : String = ""
    private var currentDescription : String = ""
    private var currentPubDate : String = ""
    private var parserCompletionHandler : (([RSSItem])-> Void)?
    
    
    func parserRssData(data : Data,completionHandler : (([RSSItem])-> Void)?){
        self.parserCompletionHandler = completionHandler
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        if currentElement == "item"{
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title" : currentTitle += string
        case "description" : currentDescription += string
        case "pubDate" : currentPubDate += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"{
            let rssItem = RSSItem(title: currentTitle, description: currentDescription, pubDate:  currentPubDate)
            self.rssItems.append(rssItem)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        self.parserCompletionHandler?(rssItems)
    }
 
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}

