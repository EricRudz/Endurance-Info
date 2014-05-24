//
//  DirectViewController.h
//  EI
//
//  Created by eric on 12/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"


@interface DirectViewController : UIViewController<UIWebViewDelegate> {
    IBOutlet UIWebView *liveWebView;
    IBOutlet UINavigationBar *navig;
    NSURL *url;
}
- (IBAction)refresh;
- (IBAction)showMenu;
@property (nonatomic, retain) UIWebView *liveWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
