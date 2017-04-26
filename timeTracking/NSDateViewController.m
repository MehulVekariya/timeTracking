//
//  NSDateViewController.m
//  timeTracking
//
//  Created by mehul patel on 2017-04-26.
//  Copyright © 2017 mehul patel. All rights reserved.
//

#import "NSDateViewController.h"

@interface NSDateViewController ()
{
    NSInteger originalTimeSpent;
}

@property (strong, nonatomic) NSDate *startTime;

@end

@implementation NSDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.startTime = [NSDate date];
    
    // Obeserver To Check Application Is in Backround or didBecomeActive
    // If we don't add an obeserver timer will keep running in the background even Application is not on Foreground
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
}

#pragma mark - TimeSpent On View
-(void)applicationOnScreen{
    self.startTime = [NSDate date];
}

-(void)applicationOffScreen{
    NSTimeInterval newTimeSpent = [[NSDate date] timeIntervalSinceDate:self.startTime];
    originalTimeSpent = originalTimeSpent + round(newTimeSpent);
    NSLog(@"original TimeSpent %ld",(long)originalTimeSpent);
}

-(void)viewDidDisappear:(BOOL)animated{
    [self applicationOffScreen];
}

#pragma mark - Backgrounding App
-(void) didEnterBackground{
    [self applicationOffScreen];
}
-(void) didBecomeActive{
    _startTime = [NSDate date];
}

@end
