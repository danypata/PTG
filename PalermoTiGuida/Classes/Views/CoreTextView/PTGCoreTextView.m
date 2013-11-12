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
@synthesize lineSpacing;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineSpacing = 2;
    }
    return self;
}

-(NSInteger)linesForFrame:(CGRect )frame {
    self.opaque = NO;
    if(VALID_NOTEMPTY(self.text, NSString)) {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:self.lineSpacing];
        [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrString.length)];
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
            CFRelease(frameRef);
        }
        return _lines;
    }
    return 0;
}

- (void)drawRect:(CGRect)rect {
    if(VALID_NOTEMPTY(self.text, NSString)) {
        self.backgroundColor = [UIColor clearColor];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:self.lineSpacing];
        [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrString.length)];
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
            
            //        [self.attrString release];
        }
    }
    [super drawRect:rect];
    
}

-(CGFloat )heightForText {
    if(VALID_NOTEMPTY(self.text, NSString)) {
        self.opaque = NO;
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:self.lineSpacing];
        [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrString.length)];
        [attrString addAttribute:NSFontAttributeName value:self.textFont range:NSMakeRange(0, attrString.length)];
        if(self.fontColor) {
            [attrString addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0, attrString.length)];
        }
        if(attrString!=nil) {
            CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
            
            CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(self.frame.size.width, MAXFLOAT), NULL);
            
            CFRelease(framesetter);
            return size.height;
        }
    }
    return 0;
}


@end
