//
//  RepositoryModel.m
//  desafio-ios
//
//  Created by Matheus Fusco on 17/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import "RepositoryModel.h"
#import "RepositoryService.h"
#import <MBProgressHUD.h>
#import "Repository.h"

@implementation RepositoryModel
@synthesize delegate;

-(void) fetchRepositoriesOf: (NSString *) language andSortingBy:(NSString *) sortBy andOrderingBy:(NSString *) orderBy withKeyWord:(NSString *) keyWord andPage:(NSInteger) page {
    NSMutableArray * repositories = [[NSMutableArray alloc] init];
    
    UIViewController * curVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:curVC.view animated:YES];
    [RepositoryService searchRepositoriesFor:language sortingBy:sortBy orderingBy:orderBy withKeyWord: keyWord andPage:page response:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
        else {
            //NSLog(@"resp: %@", [[responseObject objectForKey:@"items"] objectAtIndex:0]);
            NSMutableArray * repoArray = [[NSMutableArray alloc] initWithArray:[responseObject objectForKey:@"items"]];
            //NSLog(@"repoArray: %@", repoArray);
            for (int i = 0; i < repoArray.count; i++) {
                NSDictionary * dict = [[NSDictionary alloc] init];
                dict = [repoArray objectAtIndex:i];
                
                Repository * rp = [MTLJSONAdapter modelOfClass:[Repository class] fromJSONDictionary:dict error:&error];
                //NSLog(@"rp: %@", rp);
                [repositories addObject:rp];
            }
            [hud hideAnimated:YES];
            [self.delegate fetchedRepositories:repositories];
        }
    }];
}
@end
