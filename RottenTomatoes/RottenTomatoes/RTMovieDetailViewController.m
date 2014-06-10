//
//  RTMovieDetailViewController.m
//  RottenTomatoes
//
//  Created by David Bernthal on 6/7/14.
//  Copyright (c) 2014 dbernthal. All rights reserved.
//

#import "RTMovieDetailViewController.h"
#import "RTMovie.h"
#import "UIImageView+AFNetworking.h"

@interface RTMovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (strong, nonatomic) RTMovie *currentMovie;

@end

@implementation RTMovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithMovie:(RTMovie *)movie
{
    self = [super initWithNibName:@"RTMovieDetailViewController" bundle:nil];
    if (self) {
        self.currentMovie = movie;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = self.currentMovie.title;
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    self.synopsisLabel.text = self.currentMovie.synopsis;
    [self.synopsisLabel sizeToFit];
    self.ratingLabel.text = [NSString stringWithFormat:@"%@", self.currentMovie.rating];
    
    NSURL *imageURL = [NSURL URLWithString:self.currentMovie.posterOriginalURL];
    [self.backgroundImageView setImageWithURL:imageURL];
    
    self.backgroundView.frame = CGRectMake(self.backgroundView.frame.origin.x, self.backgroundView.frame.origin.y, self.backgroundView.frame.size.width, self.synopsisLabel.frame.size.height + 300);
    
    float contentHeight = self.backgroundView.frame.size.height -
    self.navigationController.toolbar.frame.size.height -
    self.navigationController.navigationBar.frame.size.height;
    [self.scrollView setContentSize:CGSizeMake(320, contentHeight + 380)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
