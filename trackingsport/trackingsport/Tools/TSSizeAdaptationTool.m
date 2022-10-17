//
//  TSSizeAdaptationTool.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import "TSSizeAdaptationTool.h"

CGFloat adjustsSizeToFitWidth480(CGFloat size) {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return size*width/480;
}

UIFont* adjustsSizeToFitFont(CGFloat pix) {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    pix = pix * 2;
    pix = width / 640 * pix ;
    return [UIFont systemFontOfSize:pix];
}

UIFont* adjustsSizeToFitBoldFont(CGFloat pix) {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    pix = pix * 2;
    pix = width / 640 * pix ;
    return [UIFont boldSystemFontOfSize:pix];
}
