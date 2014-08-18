//
//  IconSubtitle.m
//  AppBuilder
//
//  Created by Josh Prochaska on 8/18/14.
//  Copyright (c) 2014 JoshProchaska. All rights reserved.
//

#import "IconSubtitle.h"

@implementation IconSubtitle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    NSLog(@"IconSubtitle initWithFrame");
    if (self) {
        self.iconRatio = 0.8f;

        self.subtitle = [[UILabel alloc] init];
        [self.subtitle setBackgroundColor:[UIColor clearColor]];
        [self.subtitle setTextColor:[UIColor darkGrayColor]];
        [self.subtitle setFont:[UIFont systemFontOfSize:10]];
        [self addSubview:self.subtitle];
    }
    return self;
}

-(void)changeSubtitle:(NSString *)text{
    self.subtitleSize = [text sizeWithFont:self.subtitle.font];
    [self.subtitle setText:text];
    [self.subtitle setFrame:CGRectMake((self.frame.size.width/2) - (self.subtitleSize.width/2), (self.frame.size.height), self.subtitleSize.width, self.subtitleSize.height)];
}

@end
