//
//  RootViewController.m
//  OpenGLDemo
//
//  Created by 王 军 on 13-9-3.
//  Copyright (c) 2013年 王 军. All rights reserved.
//

#import "RootViewController.h"
@interface RootViewController ()
@property (strong, nonatomic) EAGLContext *context;

@end

@implementation RootViewController
@synthesize context = _context;
@synthesize openGl=_openGl;

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
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView *glkView = [[GLKView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [glkView setEnableSetNeedsDisplay:YES];
    glkView.context = self.context;
    glkView.delegate = self;
    
    GLKViewController *glkViewController = [[GLKViewController alloc] initWithNibName:nil bundle:nil]; // 1
    glkViewController.view = glkView;
    glkViewController.delegate = self;
    glkViewController.preferredFramesPerSecond = 60;    
    [self addChildViewController:glkViewController];
    [self.view addSubview:glkViewController.view];
    
     self.openGl=[[OpenGl alloc] init];
    [self.openGl setupGL:self.context];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
   
    [self.openGl draw:self.view];
}
- (void)glkViewControllerUpdate:(GLKViewController *)controller
{
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [self.openGl tearDownGL:self.context];
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
}
@end
