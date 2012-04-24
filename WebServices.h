//
//  WebServices.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSXMLParser.h>



//#if __IPHONE_OS_VERSION_MAX_ALLOWED == __IPHONE_3_2

#if __IPHONE_3_2 == __IPHONE_OS_VERSION_MAX_ALLOWED
@protocol NSXMLParserDelegate
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict;
- (void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError;
- (void)parserDidEndDocument:(NSXMLParser *)parser;
@end
#endif


@interface WebServices : NSObject {

	NSMutableData *webData;
	id delegate;
}
- (void) setDelegate:(id)adelegate;
- (void) execWebService:(NSString*)soapString ;

@end


@protocol WebServicesDelegate

@optional
- (void) gettingDataFinish:(WebServices*)webservice data:(NSMutableData *)webData;
@end
