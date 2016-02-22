//
//  ViewController.m
//  pocimy
//
//  Created by Sathish Chinniah on 22/02/16.
//  Copyright © 2016 Sathish Chinniah. All rights reserved.
//

#import "ViewController.h"
#import "TableView.h"


@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    
    NSData *FirstDate;
    NSMutableArray *cells_Array;
    NSArray *jsonObject;
    UIPageControl *pageControl;

    
}

@end

@implementation ViewController
@synthesize scrollView = scroll;


@synthesize imageView;
@synthesize imgSubView;



- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:currentDate];
    NSInteger hour = [components hour];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    NSString *dateString = [NSString stringWithFormat:@"%@ %ti - %ti %@",
                            [dateFormatter stringFromDate:currentDate], hour % 12, (hour + 1) % 12, hour > 12? @"pm" : @"am"];
    
     _dateLabel.text=dateString;
    
    // For scroll view
    cells_Array = [[NSMutableArray alloc] init];
    
   // selectedIndex = -1;
    
    // Do any additional setup after loading the view, typically from a nib.
    //NSArray *jsonObject;
    jsonObject = @[
                   @{
                       @"GymName": @"Golden Gold",
                       @"Km": @"19 km",
                       @"Adress": @"144 , jp nagar 5 phase, Banglore",
                       @"Gymsubname": @"GG"
                       
                       
                       
                       },
                   @{
                       @"GymName": @"Universal Spike",
                       @"Km": @"12 km",
                       @"Adress": @"122 ,madivala 5 phase,Banglore",
                       @"Gymsubname": @"US",
                       //@"color": @"Green"
                       },
         
                   ];
    
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
    
    
    
    NSString * jsonString=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    

//    
//    UIImage* img1 = [UIImage imageNamed:@"1.jpg"];
//    UIImage* img2 = [UIImage imageNamed:@"2.jpg"];
//    
//    
//    //imgView = [[UIImageView alloc] initWithFrame:self.view.frame]; // create a UIImageView with the same size as the view.
//    imageView.animationImages = @[img1, img2]; // use a nice NSArray literal to pass in your images.
//    imageView.animationDuration = 2.0*2.0; // 2 seconds for each image (x3 images)
//    [self.imgSubView addSubview:imageView]; // add UIImageView to view
//    
//    [imageView startAnimating]; // start animating
    
    ///
    
    // Scroll View
    
    //scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    scroll.backgroundColor=[UIColor clearColor];
    scroll.delegate=self;
    scroll.pagingEnabled=YES;
    [scroll setContentSize:CGSizeMake(scroll.frame.size.width*3, scroll.frame.size.height)];
    
    // page control
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(180, 220, 320, 36)];
    //pageControl.backgroundColor=[UIColor blackColor];
    pageControl.numberOfPages=3;
    [pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
    
    CGFloat x=0;
    for(int i=1;i<4;i++)
    {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(x+0, 0, 320, 150
                                                                           )];
        [image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg",i]]];
        [scroll addSubview:image];
        
        x+=320;
    }
    [self.view addSubview:scroll];
    
    [self.view addSubview:pageControl];

    //
    
	
}
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    
    CGFloat viewWidth = _scrollView.frame.size.width;
    // content offset - tells by how much the scroll view has scrolled.
    
    int pageNumber = floor((_scrollView.contentOffset.x - viewWidth/100) / viewWidth) +1;
    
    pageControl.currentPage=pageNumber;
    
}

- (void)pageChanged {
    
    int pageNumber = pageControl.currentPage;
    
    CGRect frame = scroll.frame;
    frame.origin.x = frame.size.width*pageNumber;
    frame.origin.y=0;
    
    [scroll scrollRectToVisible:frame animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // [cells_Array removeAllObjects];
    
    return [jsonObject count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableView";
    TableView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.GymNmae.text = [jsonObject objectAtIndex:indexPath.row][@"GymName"];
    cell.GymAdress.text = [jsonObject objectAtIndex:indexPath.row][@"Adress"];
    cell.GymKm.text = [jsonObject objectAtIndex:indexPath.row][@"Km"];
    cell.GymSubName.text = [jsonObject objectAtIndex:indexPath.row][@"Gymsubname"];
    
    
    
    [cells_Array addObject:cell];
    
    return cell;
   // NSLog(@"Select Cell Row: %d", indexPath.row);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for (TableView *view in cells_Array ) {
        //[view.checkBtn setSelected:false];
    }
    TableView *cellView = [self.ContainerTableView cellForRowAtIndexPath:indexPath];
    
//    selectedIndex = (int)indexPath.row;
//    
//    [cellView.checkBtn setSelected:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
