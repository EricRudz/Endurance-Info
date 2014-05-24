//
//  GTRssParser.h
//  GT-Tour
//
//  Created by Eric Rudz on 17/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsViewController;

@interface RssParser : NSObject<NSXMLParserDelegate> {
	NSString *titreFlux;
	NSXMLParser *theXMLParser;
	NSMutableString * theCurrentString;
	NSMutableDictionary * currentNewsItem;
	NSMutableArray * newsArray;
	NewsViewController *rootViewController;
	int i;
	NSDictionary *currentElementAttributes;
}
@property (nonatomic, retain) NSString *titreFlux;
@property (retain) NSMutableArray * newsArray;
@property (nonatomic, retain) NewsViewController *rootViewController;
@property (nonatomic, retain) NSDictionary *currentElementAttributes;

- (NSString *)flattenHTML:(NSString *)html;
- (id) initWithController:(id)cont;
-(void) parseRSSFeed:(NSString *)adresse;
@end