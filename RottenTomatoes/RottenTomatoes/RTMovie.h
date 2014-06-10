//
//  RTMovie.h
//  RottenTomatoes
//
//  Created by David Bernthal on 6/7/14.
//  Copyright (c) 2014 dbernthal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTMovie : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* synopsis;
@property (nonatomic, strong) NSString* posterProfileURL;
@property (nonatomic, strong) NSString* posterOriginalURL;
@property (nonatomic, strong) NSNumber* rating;
@property (nonatomic, strong) NSString* castList;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)moviesWithArray:(NSArray *)array;

@end
