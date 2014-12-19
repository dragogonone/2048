//
//  Segues.m
//  new2048
//
//  Created by USER on 2014/04/29.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import "Segues.h"

@implementation Segues

- (void)perform {
    UIViewController *sourceViewController = (UIViewController *)self.sourceViewController;
    UIViewController *destinationViewController = (UIViewController *)self.destinationViewController;
    
    [UIView transitionWithView:sourceViewController.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        [sourceViewController.navigationController pushViewController:destinationViewController animated:NO];
                    }
                    completion:^(BOOL finished){
                        [sourceViewController dismissViewControllerAnimated:NO completion:nil];
                    }];
    //[[self sourceViewController] navigationController] pushViewController:[self   destinationViewController] animated:NO];
}



@end
