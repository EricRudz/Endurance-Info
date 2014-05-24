//
//  PhotoViewController.h
//  Endurance-Info
//
//  Created by Eric on 08/11/2013.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
@class RssParser;
#define jFilename @"photos.plist"
#define jFilenamedejalues @"dejalues.plist"


@interface PhotoViewController : UITableViewController{
    int z;
}
- (IBAction)showMenu;
@property (weak, nonatomic) NSMutableArray *listeDesActualites;
@property (weak, nonatomic) NSMutableArray *listeDesActualitesHeader;
@property (weak, nonatomic) NSMutableArray *listeDesActualitesDejaLues;
@property (retain) RssParser * rssParser;
@property (weak, nonatomic) NSString * categories;
@property (weak, nonatomic) NSString * image;
@property (retain, nonatomic) NSMutableArray *listOfItems;
@property (retain, nonatomic) NSMutableArray *listOfImages;
@property (nonatomic, nonatomic) NSMutableArray *listOfNewsDejaLues;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
