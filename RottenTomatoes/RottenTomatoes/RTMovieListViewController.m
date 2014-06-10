//
//  RTMovieListViewController.m
//  RottenTomatoes
//
//  Created by David Bernthal on 6/6/14.
//  Copyright (c) 2014 dbernthal. All rights reserved.
//

#import "RTMovieListViewController.h"
#import "RTMovieDetailViewController.h"
#import "RTMovieCell.h"
#import "RTMovie.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"

@interface RTMovieListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *movieTableView;
@property (nonatomic, strong) NSArray* movies;
@property (weak, nonatomic) IBOutlet UILabel *networkErrorLabel;
@property (nonatomic, strong) UIRefreshControl* refresh;

@end

@implementation RTMovieListViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refresh = [[UIRefreshControl alloc] init];
    self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.movieTableView addSubview:self.refresh];
    [self.refresh addTarget:self action:@selector(loadMovies) forControlEvents:UIControlEventValueChanged];
    
    [self.networkErrorLabel setHidden:YES];
    self.movieTableView.dataSource = self;
    self.movieTableView.delegate = self;
    self.movieTableView.rowHeight = 122;
    [self.movieTableView registerNib:[UINib nibWithNibName:@"RTMovieCell" bundle:nil] forCellReuseIdentifier:@"RTMovieCell"];
    
    [self loadMovies];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMovies
{
    [SVProgressHUD show];
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=rntj8khcqk4fad43xvyyp3e3";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError != nil)
        {
            [self.networkErrorLabel setHidden:NO];
            [self.refresh endRefreshing];
        } else
        {
            [self.networkErrorLabel setHidden:YES];
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.movies = [RTMovie moviesWithArray:object[@"movies"]];
            
            [self.refresh endRefreshing];
            [self.movieTableView reloadData];
        }
        
        [SVProgressHUD dismiss];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTMovieCell* cell = [tableView dequeueReusableCellWithIdentifier:@"RTMovieCell"];
    
    RTMovie* movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie.title;
    cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    cell.synopsisLabel.text = movie.synopsis;
    
    NSURL *posterURL = [NSURL URLWithString:movie.posterProfileURL];
    [cell.posterView setImageWithURL:posterURL];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTMovieDetailViewController *detailvc = [[RTMovieDetailViewController alloc] initWithMovie:self.movies[indexPath.row]];
    [self.navigationController pushViewController:detailvc animated:YES];
}


@end
