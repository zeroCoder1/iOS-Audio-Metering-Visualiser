//
//  ProgressView.h
//  testProgressBar
//
//  Created by Shrutesh Sharma on 18/02/15.

//

#import <UIKit/UIKit.h>

@interface SSProgressView : UIView{
    
    CGFloat startAngle;
    CGFloat endAngle;
}


@property (nonatomic) float percent;
@property (nonatomic) NSString *textContent;
@property (nonatomic, strong) UIColor *color;

@end
