//
//  RepositoryListViewController.h
//  desafio-ios
//
//  Created by Matheus Fusco on 20/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Repository.h"
#import "RepositoryModel.h"
#import "RepositoryTableViewCell.h"
#import "PullRequestTableViewController.h"
#import <Foundation/Foundation.h>

@interface RepositoryListViewController : UIViewController <RepositoryDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *repositoryTableView;
@property (weak, nonatomic) IBOutlet UITextField *languageTextField;
@property (weak, nonatomic) IBOutlet UITextField *sortByTextField;
@property (weak, nonatomic) IBOutlet UITextField *orderByTextField;
@property (weak, nonatomic) IBOutlet UISearchBar *searchRepository;

- (IBAction)searchRepositoryButtonClicked:(id)sender;
@end
