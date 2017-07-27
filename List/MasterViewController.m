//
//  MasterViewController.m
//  List
//
//  Created by Facheng Liang  on 25/07/2017.
//  Copyright © 2017 Facheng Liang . All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()
@property NSMutableArray *DataSource;
@property NSMutableArray *objects;
@property int index;
- (void)initDataSource;
- (void)fixDataSource;
@end

@implementation MasterViewController

- (void)initDataSource{
    self.DataSource = [[NSMutableArray alloc] init];
    for(int i = 0;i < 10; i++){
        NSNumber *num = [NSNumber numberWithInt:i+1];
        [self.DataSource addObject:num];
    }
}

- (void)fixDataSource{
    NSEnumerator *enumer = [self.DataSource reverseObjectEnumerator];
    self.DataSource = [[NSMutableArray alloc]initWithArray:[enumer allObjects]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.initDataSource;
    //self.fixDataSource;
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    
    
    if (self.DataSource.count > 0){
        NSNumber *data = [self.DataSource objectAtIndex:(self.DataSource.count - 1)];
        [self.DataSource removeLastObject];
        [self.objects insertObject:data atIndex:0];
    }
    
    /*
    //removeObjectsAtIndexes:0挂了
    if (self.DataSource.count > 0){
        NSNumber *data = [self.DataSource objectAtIndex:0];
        [self.DataSource removeObjectsAtIndexes:0];
        [self.objects insertObject:data atIndex:0];
    }
     */
    else{
        return;
    }
    
    /*
    if (self.DataSource.count > 0){
        [self.objects insertObject:[[NSNumber alloc] initWithInt:(self.num--)] atIndex:0];
    }
    else {
        return;
    }
     */
    
    //[self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
