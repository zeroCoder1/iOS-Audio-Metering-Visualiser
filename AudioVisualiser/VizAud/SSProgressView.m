//
//  ProgressView.m
//  testProgressBar
//
//  Created by Shrutesh Sharma on 18/02/15.

//

#import "SSProgressView.h"

@implementation SSProgressView


- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        startAngle = M_PI * 1.5;
        endAngle = startAngle + (M_PI * 2);
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [bezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:75
                      startAngle:startAngle
                        endAngle:(endAngle - startAngle) * (_percent / 100.0) + startAngle
                       clockwise:YES];
    
    bezierPath.lineWidth = 3;
    [_color setStroke];
    [bezierPath stroke];
    
    

    CGRect textRect = CGRectMake((rect.size.width / 2.0) - 71/2.0, (rect.size.height / 2.0) - 45/2.0, 71, 45);
    [[UIColor blackColor] setFill];
    
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue" size: 28], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};

    [_textContent drawInRect:textRect withAttributes:textFontAttributes];
}

@end
