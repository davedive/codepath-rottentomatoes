//
//  RTMovieCell.h
//  RottenTomatoes
//
//  Created by David Bernthal on 6/7/14.
//  Copyright (c) 2014 dbernthal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTMovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end
