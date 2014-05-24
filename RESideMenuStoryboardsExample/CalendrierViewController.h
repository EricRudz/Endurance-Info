//
//  CalendrierViewController2.h
//  Endurance-Info
//
//  Created by Eric on 15/11/2013.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RESideMenu.h"


@interface CalendrierViewController : UIViewController<UIWebViewDelegate> {
    IBOutlet UIWebView *liveWebView;
    IBOutlet UINavigationBar *navig;
    NSURL *url;
}
- (IBAction)refresh;
- (IBAction)showMenu;
@property (nonatomic, retain) UIWebView *liveWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
