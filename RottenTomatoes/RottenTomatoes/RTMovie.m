//
//  RTMovie.m
//  RottenTomatoes
//
//  Created by David Bernthal on 6/7/14.
//  Copyright (c) 2014 dbernthal. All rights reserved.
//

#import "RTMovie.h"

@implementation RTMovie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.synopsis = dictionary[@"synopsis"];
        self.posterProfileURL = dictionary[@"posters"][@"profile"];
        self.posterOriginalURL = dictionary[@"posters"][@"original"];
        self.rating = dictionary[@"ratings" ][@"critics_score"];
    }
    
    return self;
}

+ (NSArray *)moviesWithArray:(NSArray *)array {
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        RTMovie *movie = [[RTMovie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    
    return movies;
}

@end
