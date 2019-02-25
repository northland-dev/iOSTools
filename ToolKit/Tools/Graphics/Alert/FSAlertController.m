//
//  FSAlertController.m
//  Lolly
//
//  Created by Charles on 2017/11/9.
//  Copyright © 2017年 Fission. All rights reserved.
//

#import "FSAlertController.h"

@interface FSAlertController ()

@end

@implementation FSAlertController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _dissMissDelayTime = 1.5f;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self performSelector:@selector(hide) withObject:nil afterDelay:_dissMissDelayTime];
}

- (void)hide {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
