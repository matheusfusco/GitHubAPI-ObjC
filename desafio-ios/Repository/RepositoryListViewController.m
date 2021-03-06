//
//  RepositoryListViewController.m
//  desafio-ios
//
//  Created by Matheus Fusco on 20/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import "RepositoryListViewController.h"

@interface RepositoryListViewController ()
{
    Repository * repository;
    RepositoryModel * model;
    
    NSMutableArray * repositories;
    NSInteger page;
    
    UITextField * activeTextField;
    UIPickerView * customPickerView;
    NSArray * pickerArray;
    NSArray * languageArray;
    NSArray * sortArray;
    NSArray * orderArray;
    
    NSString * languageToSearch;
    NSString * sortToSearch;
    NSString * orderToSearch;
    
    UITapGestureRecognizer * tap;
    
    BOOL shouldShowFilters;
}

@end

@implementation RepositoryListViewController
@synthesize languageTextField, sortByTextField, orderByTextField, searchRepository, repositoryTableView;
#pragma mark - Initialization & View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self initVariables];
    [self initPicker];
    
    [model fetchRepositoriesOf:@"" andSortingBy:@"" andOrderingBy:@"" withKeyWord: @"" andPage:page];
}

#pragma mark - Custom Methods
-(void) initVariables {
    repositories = [[NSMutableArray alloc] init];
    
    model = [[RepositoryModel alloc] init];
    model.delegate = self;
    
    pickerArray = [[NSArray alloc] init];
    languageArray = [[NSArray alloc] initWithObjects: @"", @"Swift", @"Java", @"C", nil];
    sortArray = [[NSArray alloc] initWithObjects: @"", @"Stars", @"Forks", @"Updated", nil];
    orderArray = [[NSArray alloc] initWithObjects: @"", @"Asc", @"Desc", nil];
    
    page = 1;
    
    languageToSearch = @"";
    orderToSearch = @"";
    sortToSearch = @"";
    
    [languageTextField setText:languageToSearch];
    [sortByTextField setText:sortToSearch];
    [orderByTextField setText:orderToSearch];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fetchRepositories)];
    
    shouldShowFilters = NO;
}
-(void) initPicker {
    customPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    customPickerView.dataSource = self;
    customPickerView.delegate = self;
    customPickerView.showsSelectionIndicator = YES;
    customPickerView.backgroundColor = [UIColor whiteColor];
    languageTextField.inputView = customPickerView;
    orderByTextField.inputView = customPickerView;
    sortByTextField.inputView = customPickerView;
    
    UIToolbar * toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(fetchRepositories)];
    UIBarButtonItem * flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    toolBar.items = @[flexibleSpace, doneButton];
    languageTextField.inputAccessoryView = toolBar;
    orderByTextField.inputAccessoryView = toolBar;
    sortByTextField.inputAccessoryView = toolBar;
}

-(void) fetchRepositories {
    [activeTextField resignFirstResponder];
    [searchRepository resignFirstResponder];
    
    [repositories removeAllObjects];
    //[repositoryTableView reloadData];
    [model fetchRepositoriesOf:languageToSearch andSortingBy:sortToSearch andOrderingBy:orderToSearch withKeyWord: searchRepository.text andPage:page];
    
    [self.view removeGestureRecognizer:tap];
}

-(void) setFilterHiddenTo :(BOOL)value {
    [UIView animateWithDuration:0.3f animations:^{
        [_filterStackView setHidden:value];
    }];
}

-(BOOL)isShowingFirstRow {
    NSIndexPath * firstVisibleIndexPath = [[repositoryTableView indexPathsForVisibleRows] objectAtIndex:0];
    if (firstVisibleIndexPath.row < 2){
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - Button Actions
- (IBAction)showFiltersButtonClicked:(id)sender {
    //NSLog(@"touch");
    if (_filterStackView.isHidden) {
        [self setFilterHiddenTo:NO];
    }
    else {
        [self setFilterHiddenTo:YES];
    }
}

#pragma mark - TableView Data Source & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (repositories.count > 0) {
        return repositories.count;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * CellIdentifier = @"repositoryCell";
    
    RepositoryTableViewCell * cell = [repositoryTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[RepositoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    repository = [repositories objectAtIndex:indexPath.row];
    [cell setRepository:repository];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    repository = [repositories objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"loadRepositoryPRs" sender:self];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:[self tableView:repositoryTableView numberOfRowsInSection:0] -1 inSection: 0]])
    {
        if ([searchRepository.text isEqualToString:@""]) {
            page += 1;
            [model fetchRepositoriesOf:languageToSearch andSortingBy:sortToSearch andOrderingBy:orderToSearch withKeyWord: searchRepository.text andPage:page];
        }
    }
}

#pragma mark - ScrollView Delegate Methods
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    CGFloat yVelocity = [repositoryTableView.panGestureRecognizer velocityInView:repositoryTableView].y;
    if (repositories.count > 0) {
        if ([self isShowingFirstRow]) {
            //NSLog(@"first row - show search if scrolling from top to bottom - up");
            if (yVelocity > 0) {
                [self setFilterHiddenTo:NO];
            }
            else if (yVelocity < 0) {
                [self setFilterHiddenTo:YES];
            }
        }
        else {
            [self setFilterHiddenTo:YES];
        }
    }
    [self.view removeGestureRecognizer:tap];
}

#pragma mark - PickerView Delegate & DataSource Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerArray.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%@", [pickerArray objectAtIndex:row]];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([languageTextField isFirstResponder]) {
        languageToSearch = [NSString stringWithFormat:@"%@", [languageArray objectAtIndex:row]];
        [languageTextField setText:languageToSearch];
    }
    else if ([orderByTextField isFirstResponder]) {
        orderToSearch = [[NSString stringWithFormat:@"%@", [orderArray objectAtIndex:row]] lowercaseString];
        [orderByTextField setText: orderToSearch];
    }
    else if ([sortByTextField isFirstResponder]) {
        sortToSearch = [[NSString stringWithFormat:@"%@", [sortArray objectAtIndex:row]] lowercaseString];
        [sortByTextField setText: sortToSearch];
    }
}

#pragma mark - TextField Delegate Methods
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.view addGestureRecognizer:tap];
    
    if (textField == languageTextField) {
        pickerArray = languageArray;
    }
    else if (textField == orderByTextField) {
        pickerArray = orderArray;
    }
    else if (textField == sortByTextField) {
        pickerArray = sortArray;
    }
    activeTextField = textField;
    [customPickerView reloadAllComponents];
    
    for (int i = 0; i < pickerArray.count; i++) {
        NSString * strTxt = [[NSString stringWithFormat:@"%@", textField.text] lowercaseString];
        NSString * strArray = [[NSString stringWithFormat:@"%@", [pickerArray objectAtIndex:i]] lowercaseString];
        if ([strTxt isEqualToString:strArray]) {
            [customPickerView selectRow:i inComponent:0 animated:NO];
        }
    }
    return YES;
}

#pragma mark - SearchBar Delegate Methods
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [repositories removeAllObjects];
    [model fetchRepositoriesOf:languageToSearch andSortingBy:sortToSearch andOrderingBy:orderToSearch withKeyWord: searchRepository.text andPage:page];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.view addGestureRecognizer:tap];
}

#pragma mark - Repository Model Delegate Methods
-(void)fetchedRepositories:(NSMutableArray *)repos {
    for (Repository * repo in repos) {
        [repositories addObject:repo];
    }
    [repositoryTableView reloadData];
    
    if (page == 1) {
        if (repositories.count > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.repositoryTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            [self setFilterHiddenTo:YES];
        }
        else {
            [self setFilterHiddenTo:NO];
        }
    }
    
    [searchRepository setHidden:NO];
    [languageTextField setHidden:NO];
    [orderByTextField setHidden:NO];
    [sortByTextField setHidden:NO];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[PullRequestTableViewController class]]) {
        [(PullRequestTableViewController *)segue.destinationViewController setRepositoryToLoad:repository.name];
    }
}

#pragma mark - Memory Management
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
