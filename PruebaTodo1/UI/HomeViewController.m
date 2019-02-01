//
//  HomeViewController.m
//  PruebaTodo1
//
//  Created by Sara Yazmin Espinal Araque on 1/31/19.
//  Copyright © 2019 Gustavo Adolfo Botero Arango. All rights reserved.
//

#import "HomeViewController.h"
#import "ResponseGeneric.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)fetchGamesList:(NSString *)urlString body:(NSString *)body {
    
    NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    NSString *bodyData = body;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [request setValue:@"bf52a985c6670a9b7bb9bf95949bd461" forHTTPHeaderField:@"user-key"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            
            NSError *err;
            NSArray *objectJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            
            if (err) {
                
            }
            
            NSMutableArray<ResponseGeneric *> *objects = NSMutableArray.new;
            for(NSDictionary *objectDict in objectJSON) {
                NSString *idObject = objectDict[@"id"];
                NSString *nameObject = objectDict[@"name"];
                NSString *urlObject = objectDict[@"url"];
                
                ResponseGeneric *object = ResponseGeneric.new;
                object.idObject = idObject;
                if(objectDict[@"name"]){
                    object.string = nameObject;
                } else if (objectDict[@"url"]){
                    object.string = urlObject;
                }
                [objects addObject:object];
            }
            NSLog(@"%@", objects);
            // Success
            NSLog(@"URL Session Task Succeeded: HTTP %ld", ((NSHTTPURLResponse*)response).statusCode);
        }
        else {
            // Failure
            NSLog(@"URL Session Task Failed: %@", [error localizedDescription]);
        }
    }];
    [task resume];
}

- (IBAction)topTenByPlatform:(id)sender {
    [self fetchGamesList: @"https://api-v3.igdb.com/platforms/" body:@"fields name; id;"];
    [self fetchGamesList: @"https://api-v3.igdb.com/platform_logos/" body:@"fields url;"];
}

- (IBAction)topTwenty:(id)sender {
    [self fetchGamesList: @"https://api-v3.igdb.com/games/" body:@"fields name; id;"];
}

- (IBAction)searchGame:(id)sender {
    [self fetchGamesList: @"https://api-v3.igdb.com/games/" body:@"fields name; id;"];
}


@end
