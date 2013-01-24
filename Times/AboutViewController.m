//
//  SettingsViewController.m
//  Tock
//
//  Created by Douglas Black on 1/9/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "AboutViewController.h"
#import "TimesViewController.h"
#import "CommonCLUtility.h"
#import "SettingsCell.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)init
{
    self = [super init];
    if (self) {

        self.leftStrings = [NSMutableArray arrayWithObjects:@"Developer", @"Twitter", @"Twitter", nil];
        self.rightStrings = [NSMutableArray arrayWithObjects:@"Doug Black", @"@thetockapp", @"@dougblackgt", nil];
        NSNumber *settingTypeSwitch = [NSNumber numberWithInt:SettingTypeSwitch];
        NSNumber *settingTypeSelectable = [NSNumber numberWithInt:SettingTypeSelectable];
        self.settingType = [NSMutableArray arrayWithObjects:settingTypeSelectable, settingTypeSelectable, settingTypeSelectable, nil];
    }
    return self;
}

-(void)saveAndClose
{
    [self.timesViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadView
{
    [super loadView];
    int navBarHeight = self.navigationController.navigationBar.frame.size.height;
    int frameHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, frameHeight-navBarHeight)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *navBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [navBarLabel setText:@"About"];
    [navBarLabel setBackgroundColor:[UIColor clearColor]];
    [navBarLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [navBarLabel setTextAlignment:NSTextAlignmentCenter];
    [navBarLabel setTextColor:[UIColor whiteColor]];
    [navBarLabel setOpaque:YES];
    [self.navigationItem setTitleView:navBarLabel];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings_back.png"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delaysContentTouches = NO;
    
    UIEdgeInsets inset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.contentInset = inset;
    
    [self.tableView registerClass:[SettingsCell class] forCellReuseIdentifier:@"Settings"];
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - TableView methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftStrings.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (indexPath.row == 0)
//    {
//        UITableViewCell *imageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Image"];
//
//        imageCell.backgroundColor = [UIColor clearColor];
//        [imageCell.contentView addSubview:image];
//        return imageCell;
//    }
//    
    static NSString *SettingsCellIdentifier = @"Settings";
    
    SettingsCell *settingsCell = [tableView dequeueReusableCellWithIdentifier:SettingsCellIdentifier];
    
    if (settingsCell == nil)
    {
        settingsCell = [[SettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SettingsCellIdentifier];
    }
    settingsCell.leftString = [self.leftStrings objectAtIndex:indexPath.row];
    settingsCell.rightString = [self.rightStrings objectAtIndex:indexPath.row];
    settingsCell.settingType = [[self.settingType objectAtIndex:indexPath.row] intValue];
    settingsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [settingsCell refresh];
    
    
    return settingsCell;
}

//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"Connect";
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 340;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,240)];
    tempView.backgroundColor=[UIColor clearColor];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tock_logo.png"]];
    image.frame = CGRectMake(0, 50, 320, 200);
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,270,300,30)];
    tempLabel.backgroundColor=[UIColor clearColor];
    tempLabel.shadowColor = [UIColor blackColor];
    tempLabel.shadowOffset = CGSizeMake(0,-2);
    tempLabel.textColor = [UIColor whiteColor]; //here you can change the text color of header.
    tempLabel.font = [UIFont boldSystemFontOfSize:15.0];
    tempLabel.text=@"Connect";
    
    [tempView addSubview:image];
//    [tempView addSubview:tempLabel];
    return tempView;
}

@end
