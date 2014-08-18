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
    if (self) {
        self.iconRatio = 0.8f;
        [self setBackgroundColor:[UIColor clearColor]];
        self.icon = [[Icon alloc] initWithFrame:CGRectMake(frame.size.width * (self.iconRatio/2), frame.size.height * (self.iconRatio/2), self.iconRatio * frame.size.width, self.frame.size.height)];
        self.subtitle = [[UILabel alloc] init];
        [self.subtitle setBackgroundColor:[UIColor clearColor]];
        [self.subtitle setTextColor:[UIColor darkGrayColor]];
        [self addSubview:self.subtitle];
    }
    return self;
}

-(void)changeSubtitle:(NSString *)text{
    self.subtitleSize = [text sizeWithFont:self.subtitle.font];
    [self.subtitle setText:text];
    [self.subtitle setFrame:CGRectMake(self.center.x - (self.subtitleSize.width/2), self.icon.frame.origin.y + self.icon.frame.size.height, self.subtitleSize.width, self.subtitleSize.height)];
}

@end
