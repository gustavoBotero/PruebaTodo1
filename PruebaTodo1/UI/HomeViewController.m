//
//  HomeViewController.m
//  PruebaTodo1
//
//  Created by Sara Yazmin Espinal Araque on 1/31/19.
//  Copyright © 2019 Gustavo Adolfo Botero Arango. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self fetchGamesList];
}

- (void)fetchGamesList {
    
    NSString *urlString = @"";
    NSURL *url = [NSURL URLWithString: urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"");
    }] resume];
}

@end
