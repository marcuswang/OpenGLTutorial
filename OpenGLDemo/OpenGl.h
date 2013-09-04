//
//  OpenGl.h
//  OpenGLDemo
//
//  Created by 王 军 on 13-9-4.
//  Copyright (c) 2013年 王 军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
@interface OpenGl : NSObject
{
    GLuint _program;
}
-(void)setupGL:(EAGLContext *)context;
-(void)tearDownGL:(EAGLContext *)context;
-(void)draw:(UIView *)view;
@end
