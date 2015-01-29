//
//  EssayToolPopoverSelectViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-29.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "EssayToolPopoverSelectViewController.h"
#define GM_TAG        1002

@interface EssayToolPopoverSelectViewController ()<JCGridMenuControllerDelegate>

@end

@implementation EssayToolPopoverSelectViewController

@synthesize isPopMenuOpen;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initCallBackWithTarget : (id)target commentCallBack : (SEL)commentCallBackSEL likeCallBack : (SEL)likeCallBackSEL{
    callBackTarget = target;
    commentCallBack = commentCallBackSEL;
    likeCallBack = likeCallBackSEL;
}

-(id)init{
    if(self = [super init]){
        isPopMenuOpen = NO;
        JCGridMenuColumn *twitter = [[JCGridMenuColumn alloc]
                                     initWithButtonAndImages:CGRectMake(0, 0, 44, 44)
                                     normal:@"Twitter"
                                     selected:@"TwitterSelected"
                                     highlighted:@"TwitterSelected"
                                     disabled:@"Twiiter"];
        [twitter.button setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.8f]];
        [twitter setCloseOnSelect:YES];
        
        JCGridMenuColumn *email = [[JCGridMenuColumn alloc]
                                   initWithButtonAndImages:CGRectMake(0, 0, 44, 44)
                                   normal:@"Email"
                                   selected:@"EmailSelected"
                                   highlighted:@"EmailSelected"
                                   disabled:@"Email"];
        [email.button setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.8f]];
        [email setCloseOnSelect:YES];
        
        JCGridMenuColumn *pocket = [[JCGridMenuColumn alloc]
                                    initWithButtonAndImages:CGRectMake(0, 0, 44, 44)
                                    normal:@"Pocket"
                                    selected:@"PocketSelected"
                                    highlighted:@"PocketSelected"
                                    disabled:@"Pocket"];
        [pocket.button setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.8f]];
        [pocket setCloseOnSelect:YES];
        
        JCGridMenuColumn *facebook = [[JCGridMenuColumn alloc]
                                      initWithButtonAndImages:CGRectMake(0, 0, 44, 44)
                                      normal:@"Facebook"
                                      selected:@"FacebookSelected"
                                      highlighted:@"FacebookSelected"
                                      disabled:@"Facebook"];
        [facebook.button setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.8f]];
        [facebook setCloseOnSelect:YES];
        
        JCGridMenuRow *likeRow = [[JCGridMenuRow alloc] initWithImages:@"heart" selected:@"heart" highlighted:@"heart" disabled:@"heart"];
        [likeRow setIsModal:NO];
        [likeRow setHideAlpha:1.0f];
        [likeRow setIsSeperated:NO];
        [likeRow.button addTarget:self action:@selector(likeClickedCallBack) forControlEvents:UIControlEventTouchUpInside];
        [likeRow.button setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.4f]];
        
        
        JCGridMenuRow *share = [[JCGridMenuRow alloc] initWithImages:@"Share" selected:@"CloseSelected" highlighted:@"ShareSelected" disabled:@"Share"];
        [share setColumns:[[NSMutableArray alloc] initWithObjects:pocket, twitter, facebook, email, nil]];
        [share setIsModal:NO];
        [share setHideAlpha:0.2f];
        [share setIsSeperated:YES];
        [share.button setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.4f]];
        
        // favourite
        
        JCGridMenuRow *favourite = [[JCGridMenuRow alloc] initWithImages:@"Favourite" selected:@"FavouriteSelected" highlighted:@"FavouriteSelected" disabled:@"Favourite"];
        [favourite setHideAlpha:1.0f];
        [favourite setIsSeperated:NO];
        [favourite setIsModal:NO];
        [favourite.button setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.4f]];
        
        // Comments
        
        JCGridMenuRow *comments = [[JCGridMenuRow alloc] initWithImages:@"Comments" selected:@"CommentsSelected" highlighted:@"CommentsSelected" disabled:@"Comments"];
        [comments setHideAlpha:1.0f];
        [comments setIsSeperated:NO];
        [comments setIsModal:NO];
        [comments.button addTarget:self action:@selector(commentClickedCallBack) forControlEvents:UIControlEventTouchUpInside];
        [comments.button setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.4f]];
        
        NSArray *rows = [[NSArray alloc] initWithObjects: share, likeRow, favourite, comments, nil];
        
        self = [self initWithFrame:CGRectMake(0,0,320,(44*[rows count])+[rows count]) rows:rows tag:GM_TAG];
        
        [self setDelegate:self];
    }
    return self;
}

-(void)openPopMenu{
    isPopMenuOpen = YES;
    [self open];
}

-(void)closePopMenu{
    isPopMenuOpen = NO;
    [self close];
}

-(void)facebookClicked{
    NSLog(@"facebook clicked");
}

#pragma mark - JCGridMenuController Delegate

- (void)jcGridMenuRowSelected:(NSInteger)indexTag indexRow:(NSInteger)indexRow isExpand:(BOOL)isExpand
{

    
    if (indexTag==GM_TAG) {
        /*JCGridMenuRow *rowSelected = (JCGridMenuRow *)[_gmDemo.rows objectAtIndex:indexRow];
        
        if (indexRow==0) {
            // Search
            [[rowSelected button] setSelected:YES];
            [self searchInput:YES];
        }*/
        
    }
    
}

- (void)jcGridMenuColumnSelected:(NSInteger)indexTag indexRow:(NSInteger)indexRow indexColumn:(NSInteger)indexColumn
{
    [self closePopMenu];

    if (indexTag==GM_TAG) {
        
        /*if (indexRow==0) {
            // Search
            [self searchInput:NO];
            [[[_gmDemo.gridCells objectAtIndex:indexRow] button] setSelected:NO];
        }
        
        [_gmDemo setIsRowModal:NO];*/
    }
    
}

-(void)commentClickedCallBack{
    if(callBackTarget != nil && commentCallBack != nil){
        [callBackTarget performSelector:commentCallBack withObject:nil];
    }
}

-(void)likeClickedCallBack{
    if(callBackTarget != nil && likeCallBack != nil){
        [callBackTarget performSelector:likeCallBack withObject:nil];
    }
}

@end
