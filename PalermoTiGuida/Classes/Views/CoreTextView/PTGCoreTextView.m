//
//  PTGCoreTextView.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 26/10/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGCoreTextView.h"
#import <CoreText/CoreText.h>

@implementation PTGCoreTextView
@synthesize text;
@synthesize lines = _lines;
@synthesize textFont;
@synthesize fontColor;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(NSInteger)linesForFrame:(CGRect )frame {
    self.opaque = NO;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attrString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, attrString.length)];
    if(self.fontColor) {
        [attrString addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0, attrString.length)];
    }
    if(attrString!=nil) {
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, frame);
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
        
        
        CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attrString length]), path, NULL);
        _lines = CFArrayGetCount(CTFrameGetLines(frameRef));
        CFRelease(framesetter);
        CGPathRelease(path);
    }
    return _lines;
}

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor clearColor];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attrString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, attrString.length)];
    [attrString addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, attrString.length)];
    if(self.fontColor) {
        [attrString addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0, attrString.length)];
    }

    if(attrString!=nil) {
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, rect);
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
        
        
        CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
        CFRelease(framesetter);
        CGPathRelease(path);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextTranslateCTM(context, 0, self.bounds.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        
        CTFrameDraw(frameRef, context);
        CFRelease(frameRef);
        [super drawRect:rect];
        //        [self.attrString release];
    }
    
    
}

-(CGFloat )heightForText {
    CGFloat leading = self.textFont.lineHeight;
    return leading;
}


@end
