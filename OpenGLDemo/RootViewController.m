//
//  RootViewController.m
//  OpenGLDemo
//
//  Created by 王 军 on 13-9-3.
//  Copyright (c) 2013年 王 军. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     NSLog(@"======viewDidLoad=========>%d",[NSThread isMainThread]);
    EAGLContext * context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView *glkView = [[GLKView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [glkView setEnableSetNeedsDisplay:YES];
    glkView.context = context;
    glkView.delegate = self;
    
    GLKViewController *glkViewController = [[GLKViewController alloc] initWithNibName:nil bundle:nil]; // 1
    glkViewController.view = glkView;
    glkViewController.delegate = self;
    glkViewController.preferredFramesPerSecond = 60;    
    [self addChildViewController:glkViewController];
    [self.view addSubview:glkViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
     NSLog(@"======glkView=========>%d",[NSThread isMainThread]);
    glClearColor(1.0, 0.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
}
- (void)glkViewControllerUpdate:(GLKViewController *)controller
{
    NSLog(@"======>>><<<<<=========>%d",[NSThread isMainThread]);
}
@end
