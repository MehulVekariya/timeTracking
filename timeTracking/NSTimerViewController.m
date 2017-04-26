//
//  NSTimerViewController.m
//  timeTracking
//
//  Created by mehul patel on 2017-04-26.
//  Copyright © 2017 mehul patel. All rights reserved.
//

#import "NSTimerViewController.h"

@interface NSTimerViewController (){
    
    NSInteger incseconds;
    NSTimer *URLTimer;

}

@end

@implementation NSTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    URLTimer = 0;
    incseconds = 0;
    [self timerMethod];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
}

- (void)timerMethod{
    URLTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                target:self
                                              selector:@selector(startTimerMethod)
                                              userInfo:nil
                                               repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:URLTimer forMode:NSDefaultRunLoopMode];
}

- (void)startTimerMethod
{
    incseconds++;
    NSLog(@"seconds Spent NSTimer %ld", (long)incseconds);
}

-(void)viewDidDisappear:(BOOL)animated{
    [URLTimer invalidate];
    // To Stop Timer When View Disappears
}

#pragma mark - Backgrounding App
-(void) didEnterBackground{
    if (URLTimer.isValid) {
        [URLTimer invalidate];
        NSLog(@"seconds Spent NSTimer %ld", (long)incseconds);
    }
}

-(void) didBecomeActive{
    [self timerMethod];
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
