//
//  NewsCell.h
//
//  Created by Eric on 18/08/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsCell : UITableViewCell {
	UILabel * titleLabel;
//	UILabel	* descriptionLabel;
	IBOutlet UIImageView *imageView;
}
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, retain) IBOutlet UILabel * titleLabel;

@property (nonatomic, retain) UIImageView *imageView;
//@property (nonatomic, retain) IBOutlet UILabel * descriptionLabel;

@end
