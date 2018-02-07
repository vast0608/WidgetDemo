//
//  ViewController.m
//  WidgetDemo
//
//  Created by 李晓璐 on 2018/2/7.
//  Copyright © 2018年 onmmc. All rights reserved.
//

#import "ViewController.h"

#define userGroup @"group.com.onmmc.WidgetDemo.TodayWidgetDemo"
#define widgetKey @"widget"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
//确认按钮
- (IBAction)ConfirmButton:(id)sender {
    [self.view endEditing:YES];
    
    if (self.textField.text.length == 0){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"拜托，稍微写两个字好不好" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"好的👌" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:confirmAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
        NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:userGroup];
        [userDefaults setObject:self.textField.text forKey:widgetKey];
        [userDefaults synchronize];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"数据已更新" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"好的👌" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:confirmAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
//取消按钮
- (IBAction)ClearButton:(id)sender {
    [self.view endEditing:YES];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定清楚数据吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //清除数据
        self.textField.text = nil;
        NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:userGroup];
        [userDefaults setObject:@"" forKey:widgetKey];
        [userDefaults synchronize];
        
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:confirmAction];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
