//
//  RootViewController.h
//  OpenGLDemo
//
//  Created by 王 军 on 13-9-3.
//  Copyright (c) 2013年 王 军. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OpenGl.h"

@interface RootViewController : UIViewController<GLKViewDelegate,GLKViewControllerDelegate>
{
    OpenGl *openGl;
}
@property(nonatomic,strong)OpenGl *openGl;
@end
