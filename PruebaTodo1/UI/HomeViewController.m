//
//  HomeViewController.m
//  PruebaTodo1
//
//  Created by Sara Yazmin Espinal Araque on 1/31/19.
//  Copyright © 2019 Gustavo Adolfo Botero Arango. All rights reserved.
//

#import "HomeViewController.h"
#import "ResponseGeneric.h"
#import "ListResultTableViewController.h"

@interface HomeViewController ()

@property (strong, nonatomic) NSMutableArray<ResponseGeneric *> *objects;
@property (strong, nonatomic) NSMutableArray<ResponseGeneric *> *objectsImg;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)fetchGamesList:(NSString *)segue urlString:(NSString *)urlString body:(NSString *)body {
    
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
                    [objects addObject:object];
                    self.objects = objects;
                } else if (objectDict[@"url"]){
                    object.string = urlObject;
                    [objects addObject:object];
                    self.objectsImg = objects;
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:segue sender:nil];
            });
//            ListResultTableViewController *listResultTableViewController = [[ListResultTableViewController alloc] initWithNibName:@"ListResultTableViewController" bundle:nil];
//            listResultTableViewController.object = self.objects;
//            [self.navigationController pushViewController:listResultTableViewController animated:YES];
            
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"topTenSegue"]) {
        ListResultTableViewController *listResultTableViewController = segue.destinationViewController;
        listResultTableViewController.object = self.objects;
    }
    if ([segue.identifier isEqualToString:@"topTwentySegue"]) {
        ListResultTableViewController *listResultTableViewController = segue.destinationViewController;
        listResultTableViewController.object = self.objects;
    }
    if ([segue.identifier isEqualToString:@"searchGameSegue"]) {
        ListResultTableViewController *listResultTableViewController = segue.destinationViewController;
        listResultTableViewController.object = self.objects;
    }
}

- (IBAction)topTenByPlatform:(id)sender {
    [self fetchGamesList:@"topTenSegue" urlString:@"https://api-v3.igdb.com/platforms/" body:@"fields name; id;"];
    //[self fetchGamesList: @"" urlString:@"https://api-v3.igdb.com/platform_logos/" body:@"fields url;"];
}

- (IBAction)topTwenty:(id)sender {
    [self fetchGamesList: @"topTwentySegue" urlString:@"https://api-v3.igdb.com/games/" body:@"fields name; id;"];
    
//    [self performSegueWithIdentifier:@"topTwentySegue" sender:nil];
}

- (IBAction)searchGame:(id)sender {
    [self fetchGamesList: @"searchGameSegue" urlString:@"https://api-v3.igdb.com/games/" body:@"fields name; id;"];
}


@end
