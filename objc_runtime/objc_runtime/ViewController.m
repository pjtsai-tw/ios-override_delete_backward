//
//  ViewController.m
//  objc_runtime
//
//  Created by  Pei-Chih Tsai on 10/7/17.
//  Copyright © 2017 Pei-Chih Tsai. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

typedef void (*funcptr)(id, SEL);
static funcptr origfunc;
static void myfunc(id object, SEL sel)
{
    UITextField *textField = object;
    BOOL shouldCallBack = (textField.text.length == 0);
    origfunc(object, sel);

    if (shouldCallBack && [textField.delegate respondsToSelector:@selector(deleteAtBeginning)]) {
        [textField.delegate performSelector:@selector(deleteAtBeginning)];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textField.layer.borderWidth = 1.0f;
    self.textField.delegate = self;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method origMethod = class_getInstanceMethod([self.textField class], @selector(deleteBackward));
        origfunc = (funcptr)class_replaceMethod([self.textField class], @selector(deleteBackward), (IMP)myfunc, method_getTypeEncoding(origMethod));
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deleteAtBeginning
{
    self.label.text = @"delete at beginning";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.label.text = @"Nothing Happened";
    });
}


@end
