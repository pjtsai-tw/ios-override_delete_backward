//
//  MyTextField.m
//  inheritance
//
//  Created by  Pei-Chih Tsai on 10/7/17.
//  Copyright © 2017 Pei-Chih Tsai. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)deleteBackward
{
    BOOL shouldCallBack = (self.text.length == 0);
    [super deleteBackward];

    if (shouldCallBack && [self.delegate respondsToSelector:@selector(deleteAtBeginning)]) {
        [self.delegate performSelector:@selector(deleteAtBeginning)];
    }
}

@end
