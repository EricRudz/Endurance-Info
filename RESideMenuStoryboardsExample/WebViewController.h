//
//  WebViewController.h
//  EI
//
//  Created by Eric on 20/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface WebViewController : UIViewController<UIWebViewDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate> {
	IBOutlet UIWebView *storyWebView;
	NSMutableDictionary *storyNewsItem;
	UILabel * titre;
	UILabel * auteurDate;
	UIScrollView *scrollView;
    UIBarButtonItem *flexible;
    UIBarButtonItem *fix;
    UIBarButtonItem *buttongoback;
    UIBarButtonItem *buttongoforward;
    UIBarButtonItem *envoyerSurFacebookOuTwitterOuMailOuSMS;
    IBOutlet UIBarButtonItem *envoie;
	UIImage *img;
    NSInteger compteur;
    NSString *langue;
}
//- (void)backButtonClicked;
//- (void)forwardButtonClicked;
//- (void) passerAFacebook;
//- (NSString *) raccourcirURL:(NSString *)uairl;
//- (IBAction) passerAConnexion;
-(void)envoiMail;
//-(void)envoiSMS;
-(void)envoiFacebookOuTwitterOuMailOuSMS;
-(void)passerAFacebook;
-(void)passerATwitter;
@property (nonatomic) NSInteger compteur;
@property (nonatomic, retain) IBOutlet UIImage *img;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) UIWebView *storyWebView;
@property (retain) NSMutableDictionary * storyNewsItem;
@property (nonatomic, retain) IBOutlet UILabel * titre;
@property (nonatomic, retain) IBOutlet UILabel * auteurDate;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSString *langue;


@end
