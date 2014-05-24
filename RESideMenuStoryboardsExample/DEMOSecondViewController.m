//
//  DEMOSecondViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOSecondViewController.h"
#import "MIBAboutSection.h"


@interface DEMOSecondViewController ()

@end

@implementation DEMOSecondViewController

- (IBAction)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        MIBAboutSection *section1 = [[MIBAboutSection alloc] init];
        section1.sectionHeaderText = NSLocalizedString(@"If you have any comments or suggestions about the app, please use the button below.", @"If you have any comments or suggestions about the app, please use the button below.");
        MIBAboutRow *row2 = [[MIBAboutRow alloc] initWithRowText:NSLocalizedString(@"SendFeedback", @"Send Feedback")];
        section1.rows = @[row2];
        
        MIBAboutSection *section2 = [[MIBAboutSection alloc] init];
        section2.sectionHeaderText = NSLocalizedString(@"DescriptionEnduranceInfo", @"description");
        MIBAboutRow *row3 = [[MIBAboutRow alloc] initWithRowText:NSLocalizedString(@"Find my apps on the AppStore", @"")];
        MIBAboutRow *row4 = [[MIBAboutRow alloc] initWithRowText:NSLocalizedString(@"Follow", @"follow")];
        section2.rows = @[row3, row4];
        
        self.sections = @[section1, section2];
        
    }
    
    return self;
}


@end
