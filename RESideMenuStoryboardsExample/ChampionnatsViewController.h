//
//  SecondViewController.h
//  EI
//
//  Created by Eric on 04/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"


@interface ChampionnatsViewController : UITableViewController {
	NSMutableArray *categorie;
	NSMutableArray *tableau;
	NSMutableDictionary *currentNewsItem;
}
- (IBAction)showMenu;
@property (nonatomic, retain) NSMutableDictionary *currentNewsItem;
@property (nonatomic, retain) NSMutableArray *categorie;
@property (nonatomic, retain) NSMutableArray *tableau;

@end
