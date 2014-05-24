//
//  NewsCell.m
//
//  Created by Eric on 18/08/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewsCell.h"


@implementation NewsCell
@synthesize descriptionLabel;
@synthesize titleLabel, imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		// initialise the title Label
//		titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 280, 21)];

//		[self.contentView addSubview:titleLabel];
//		[titleLabel release];
		
		// initialise the description label
//		descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, 238, 46)];
//		descriptionLabel.textColor = [UIColor darkGrayColor];
//		descriptionLabel.backgroundColor = [UIColor clearColor];
//		[self.contentView addSubview:descriptionLabel];
//		[descriptionLabel release];
	}
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
}


@end
