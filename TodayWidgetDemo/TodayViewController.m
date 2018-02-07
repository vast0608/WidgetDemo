//
//  TodayViewController.m
//  TodayWidgetDemo
//
//  Created by 李晓璐 on 2018/2/7.
//  Copyright © 2018年 onmmc. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#define userGroup @"group.com.onmmc.WidgetDemo.TodayWidgetDemo"
#define widgetKey @"widget"

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *orangeButton;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;//iOS 10下出现展开折叠按钮
    }

    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:userGroup];
    if ([[userDefaults objectForKey:widgetKey] isEqualToString:@""]) {
        self.label.text = @"暂时没有数据";
    }else{
        self.label.text = [userDefaults objectForKey:widgetKey];
    }
}
//点击了蓝色按钮
- (IBAction)BlueButton:(id)sender {
    [self.extensionContext openURL:[NSURL URLWithString:@"WidgetDemo://blue"] completionHandler:nil];
}
//点击了红色按钮
- (IBAction)redButton:(id)sender {
    [self.extensionContext openURL:[NSURL URLWithString:@"WidgetDemo://red"] completionHandler:nil];
}
//点击了橘色钮
- (IBAction)orangeButton:(id)sender {
    [self.extensionContext openURL:[NSURL URLWithString:@"WidgetDemo://orange"] completionHandler:nil];
}
//改变颜色
- (IBAction)changeColor:(id)sender {
    int  R =(arc4random()%256);
    int  G =(arc4random()%256);
    int  B =(arc4random()%256);
    [_button setBackgroundColor:[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]];
}


//折叠展开的代理
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    //NSLog(@"maxWidth %f maxHeight %f",maxSize.width,maxSize.height);
    if (activeDisplayMode == NCWidgetDisplayModeCompact)
    {
        self.preferredContentSize = CGSizeMake(maxSize.width, 100);//折叠后的高度
    }
    else
    {
        self.preferredContentSize = CGSizeMake(maxSize.width, 200);//展开时的高度
    }
}
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    completionHandler(NCUpdateResultNewData);
}
@end
