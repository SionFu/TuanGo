//
//  FDSGroupTableViewController.m
//  iWeater
//
//  Created by tarena on 16/4/25.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDSGroupTableViewController.h"
#import "FDSDataManager.h"
#import "FDSCity.h"
@interface FDSGroupTableViewController ()
@property (nonatomic, strong) NSArray *cityGroupArray;
@end

@implementation FDSGroupTableViewController
- (NSArray *)cityGroupArray {
    if (!_cityGroupArray) {
        _cityGroupArray = [FDSDataManager getAllCityGroups];
    }
    return _cityGroupArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"城市列表";
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickBackItem)];
    self.navigationItem.leftBarButtonItem = backItem;
    self.tableView.backgroundColor = [UIColor grayColor];
    //self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MenuBackground"]];

}
- (void)clickBackItem {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

      return self.cityGroupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    FDSCity *cityGroup = self.cityGroupArray[section];
    
    return cityGroup.cities.count;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    //    方式一
    NSMutableArray *titleMutablArray = [NSMutableArray array];
    for (FDSCity *cityGroup in self.cityGroupArray) {
        [titleMutablArray addObject:cityGroup.title];
    }
    return [titleMutablArray copy];
    //方式二
//    return [self.cityGroupArray valueForKey:@"title"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.pagingEnabled = NO;
        
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];

    }
    FDSCity *cityGroup = self.cityGroupArray[indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    cell.textLabel.tintColor = [UIColor whiteColor];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    FDSCity *cityGroup = self.cityGroupArray[section];
    return cityGroup.title;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
