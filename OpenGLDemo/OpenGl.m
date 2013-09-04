//
//  OpenGl.m
//  OpenGLDemo
//
//  Created by 王 军 on 13-9-4.
//  Copyright (c) 2013年 王 军. All rights reserved.
//

#import "OpenGl.h"
GLfloat vVertices[] = {
    -0.5f, 0.5f, 0,
    -0.5f, -0.5f, 0,
    0.5f, -0.5f, 0
};
@implementation OpenGl
-(void)setupGL:(EAGLContext *)context{
    [EAGLContext setCurrentContext:context];
    [self loadShaders];
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, vVertices);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
}
-(void)tearDownGL:(EAGLContext *)context
{
    [EAGLContext setCurrentContext:context];
    if (_program) {
        glDeleteProgram(_program);
        _program = 0;
    }
}
-(void)draw:(UIView *)view
{
    glViewport(0, 0, view.bounds.size.width, view.bounds.size.height);
    glUseProgram(_program);
    glDrawArrays(GL_TRIANGLES, 0, 3);
}
- (void)dealloc
{
    NSLog(@"Mesh dealloc");
}



-(BOOL)loadShaders{
    GLuint vertShader, fragShader;
    _program = glCreateProgram();
    if (_program == 0) {
        return NO;
    }
    NSString *vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"vertexes" ofType:@"glsl"];
    if (![self compilerShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname]) {
        NSLog(@"Failed to compile the vertex shader.");
        return NO;
    }
    NSString  *fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"fragment" ofType:@"glsl"];
    if (![self compilerShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname]) {
        NSLog(@"Failed to compile the fragment shader.");
        return NO;
    }
    glAttachShader(_program, vertShader);
    glAttachShader(_program, fragShader);
    glBindAttribLocation(_program, 0, "aPosition");
    if (![self linkProgram:_program]) {
        NSLog(@"Failed to link the program: %d", _program);
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (_program) {
            glDeleteProgram(_program);
            _program = 0;
        }
        return NO;
    }
    if (vertShader) {
        glDetachShader(_program, vertShader);
        glDeleteShader(vertShader);
        vertShader = 0;
    }
    if (fragShader) {
        glDetachShader(_program, fragShader);
        glDeleteShader(fragShader);
        fragShader = 0;
    }
    return YES;
}

-(BOOL)compilerShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    source = (GLchar*)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load shader file.");
        return NO;
    }
    // Create the shader.
    *shader = glCreateShader(type);
    // Check the shader creation
    if (shader == nil) {
        NSLog(@"Failed to create the shader.");
        return NO;
    }
    // Setting the shader source.
    glShaderSource(*shader, 1, &source, NULL);
    // Compile the shader.
    glCompileShader(*shader);
    // Check shader compile status.
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        GLint logLength;
        glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
        if (logLength > 1) {
            GLchar *log = (GLchar*)malloc(logLength);
            glGetShaderInfoLog(*shader, logLength, &logLength, log);
            NSLog(@"Shader compile error log:\n%s", log);
            free(log);
        }
        glDeleteShader(*shader);
        return NO;
    }
    return YES;
}
-(BOOL)linkProgram:(GLuint)pg{
    glLinkProgram(pg);
    return YES;
}
@end
