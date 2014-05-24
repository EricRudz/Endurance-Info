//
//  RssParser.m
//
//  Created by Eric Rudz on 17/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RssParser.h"
#import "NewsViewController.h"

@implementation RssParser
@synthesize newsArray;
@synthesize rootViewController;
@synthesize titreFlux;
@synthesize currentElementAttributes;

- (id) initWithController:(id)cont {
	//on récupère une seule fois le titre du flux(c.a.d le site)
	i = 0;
	self.rootViewController=cont;
	if (self == [super init]) {
		newsArray = [NSMutableArray alloc];
	}
	
	return self;
}

-(void) parseRSSFeed:(NSString *)adresse {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL * flux = [NSURL URLWithString:adresse];

    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:flux];
	//set self as deletegate of the parser so that it will receive the parser deletegate methods callback.
	[parser setDelegate:self];
	// Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	
}


- (void)parserDidStartDocument:(NSXMLParser *)parser 
{
	newsArray = [[NSMutableArray alloc] init];
    NSLog(@"Début", nil);
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	self.currentElementAttributes = attributeDict;
	if (([elementName isEqualToString:@"item"])||([elementName isEqualToString:@"entry"])) {
		// allocate and initialise a new News Item
		currentNewsItem = [[NSMutableDictionary alloc] init];
	}
	else if ([elementName isEqualToString:@"title"] ||
			 [elementName isEqualToString:@"category"] ||
			 [elementName isEqualToString:@"link"] ||
			 [elementName isEqualToString:@"author"] ||
			 [elementName isEqualToString:@"pubDate"] ){
		// initialise the current string to receive text
		theCurrentString = [NSMutableString string];
		//si c'est le lien "alternate" c'est à dire le lien qui contient l'adresse vers la news
	}
	else {
		theCurrentString = nil;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (theCurrentString != nil) {
		[theCurrentString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	NSLog(@"%@", theCurrentString);

    if ([elementName isEqualToString:@"item"]) {
		// add it to our mutable array which represents our database
		[newsArray addObject:currentNewsItem];
		// we can release the old one as the mutable array will hold a reference to the old file
	}
	else if ([elementName isEqualToString:@"title"]) {
		[currentNewsItem setObject:[NSString stringWithString:theCurrentString] forKey:@"title"];
		if (i==1) {
			titreFlux = [NSString stringWithString:theCurrentString];
		}
		i++;
		[currentNewsItem setObject:titreFlux forKey:@"feed"];
	}
	else if ([elementName isEqualToString:@"category"]) {
		[currentNewsItem setObject:[self flattenHTML:[NSString stringWithString:theCurrentString]] forKey:@"category"];
	}
	else if ([elementName isEqualToString:@"link"]) {
		[currentNewsItem setObject:theCurrentString forKey:@"link"];
	}
	else if ([elementName isEqualToString:@"author"]) {
		[currentNewsItem setObject:theCurrentString forKey:@"author"];
	}
	else if ([elementName isEqualToString:@"pubDate"]) {
		[currentNewsItem setObject:theCurrentString forKey:@"pubDate"];
	}
	else if ([elementName isEqualToString:@"rss"]) {
		[self.rootViewController.tableView reloadData];
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	//on recharge le tableView afin de prendre en compte les données chargées
    if ((![newsArray isEqualToArray:self.rootViewController.listOfItems])&&([newsArray count]!=0)) {
        [self.rootViewController setListOfItems:newsArray];
        [self.rootViewController.tableView reloadData];
    }
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"Fin.", nil);
}



- (NSString *)flattenHTML:(NSString *)html {
	
	NSScanner *theScanner;
	NSString *text = nil;
	
	theScanner = [NSScanner scannerWithString:html];
	
	while ([theScanner isAtEnd] == NO) {
		html = [html stringByReplacingOccurrencesOfString:
				[ NSString stringWithFormat:@"%@</p>", text]
											   withString:@"\n"];
		// find start of tag
		[theScanner scanUpToString:@"<" intoString:NULL] ;
		
		// find end of tag
		[theScanner scanUpToString:@">" intoString:&text] ;
		
		// replace the found tag with a space
		//(you can filter multi-spaces out later if you wish)
		html = [html stringByReplacingOccurrencesOfString:
				[ NSString stringWithFormat:@"%@>", text]
											   withString:@""];
		
	} // while //
	
	return html;
}


-(void) dealloc {
//    [theCurrentString release];
//    [theXMLParser release];
//	[super dealloc];
}

@end
