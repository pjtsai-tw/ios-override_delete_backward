//
//  ViewController.m
//  inheritance
//
//  Created by  Pei-Chih Tsai on 10/7/17.
//  Copyright © 2017 Pei-Chih Tsai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.layer.borderWidth = 1.0f;
    self.textField.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
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
