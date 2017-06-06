//
//  ViewController.m
//  gpuimage-demo
//
//  Created by zhangpeng on 6/1/17.
//  Copyright © 2017 zhangpeng. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage/GPUImageFramework.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property(strong, nonatomic) GPUImageStillCamera *mCamera;
@property(strong, nonatomic) GPUImageFilter *mFilter;
@property(strong, nonatomic) GPUImageView *mGPUImgView;
@property(strong, nonatomic) NSArray *mAllFilters;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAllFilters];
    _mCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    _mCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    Class filterClass = NSClassFromString(_mAllFilters[0]);
    _mFilter = [[filterClass alloc] init];
    CGRect viewRect = self.view.bounds;
    viewRect.size.width = self.view.bounds.size.width*2/3;
    viewRect.size.height = self.view.bounds.size.height/2;
    viewRect.origin.x = (self.view.bounds.size.width - viewRect.size.width)/2;
    viewRect.origin.y = 40;
    _mGPUImgView = [[GPUImageView alloc]initWithFrame:viewRect];
    [_mCamera addTarget:_mFilter];
    [_mFilter addTarget:_mGPUImgView];
    [_mCamera startCameraCapture];
    [self.view addSubview:_mGPUImgView];
    
    UIPickerView* picker = [[UIPickerView alloc]initWithFrame:CGRectMake(20, self.view.bounds.size.height-140, self.view.bounds.size.width-40, 120)];
    [self.view addSubview:picker];
    picker.delegate = self;
    picker.dataSource = self;
    [picker selectedRowInComponent:0];
}

-(void)loadAllFilters{
    _mAllFilters = [NSArray arrayWithObjects:@"GPUImage3x3ConvolutionFilter",
                    @"GPUImage3x3TextureSamplingFilter",
                    @"GPUImageAdaptiveThresholdFilter",
                    @"GPUImageAddBlendFilter",
                    @"GPUImageAlphaBlendFilter",
                    @"GPUImageAmatorkaFilter",
                    @"GPUImageAverageLuminanceThresholdFilter",
                    @"GPUImageBilateralFilter",
                    @"GPUImageBoxBlurFilter",
                    @"GPUImageBrightnessFilter",
                    @"GPUImageBulgeDistortionFilter",
                    @"GPUImageCGAColorspaceFilter",
                    @"GPUImageCannyEdgeDetectionFilter",
                    @"GPUImageChromaKeyBlendFilter",
                    @"GPUImageChromaKeyFilter",
                    @"GPUImageClosingFilter",
                    @"GPUImageColorBlendFilter",
                    @"GPUImageColorBurnBlendFilter",
                    @"GPUImageColorDodgeBlendFilter",
                    @"GPUImageColorInvertFilter",
                    @"GPUImageColorMatrixFilter",
                    @"GPUImageColorPackingFilter",
                    @"GPUImageContrastFilter",
                    @"GPUImageCropFilter",
                    @"GPUImageCrosshatchFilter",
                    @"GPUImageDarkenBlendFilter",
                    @"GPUImageDifferenceBlendFilter",
                    @"GPUImageDilationFilter",
                    @"GPUImageDirectionalNonMaximumSuppressionFilter",
                    @"GPUImageDirectionalSobelEdgeDetectionFilter",
                    @"GPUImageDissolveBlendFilter",
                    @"GPUImageDivideBlendFilter",
                    @"GPUImageEmbossFilter",
                    @"GPUImageErosionFilter",
                    @"GPUImageExclusionBlendFilter",
                    @"GPUImageExposureFilter",
                    @"GPUImageFASTCornerDetectionFilter",
                    @"GPUImageFalseColorFilter",
                    @"GPUImageFilter",
                    @"GPUImageGammaFilter",
                    @"GPUImageGaussianBlurFilter",
                    @"GPUImageGaussianBlurPositionFilter",
                    @"GPUImageGaussianSelectiveBlurFilter",
                    @"GPUImageGlassSphereFilter",
                    @"GPUImageGrayscaleFilter",
                    @"GPUImageHSBFilter",
                    @"GPUImageHalftoneFilter",
                    @"GPUImageHardLightBlendFilter",
                    @"GPUImageHarrisCornerDetectionFilter",
                    @"GPUImageHazeFilter",
                    @"GPUImageHighPassFilter",
                    @"GPUImageHighlightShadowFilter",
                    @"GPUImageHistogramEqualizationFilter",
                    @"GPUImageHistogramFilter",
                    @"GPUImageHueBlendFilter",
                    @"GPUImageHueFilter",
                    @"GPUImageJFAVoronoiFilter",
                    @"GPUImageKuwaharaFilter",
                    @"GPUImageKuwaharaRadius3Filter",
                    @"GPUImageLanczosResamplingFilter",
                    @"GPUImageLaplacianFilter",
                    @"GPUImageLevelsFilter",
                    @"GPUImageLightenBlendFilter",
                    @"GPUImageLinearBurnBlendFilter",
                    @"GPUImageLocalBinaryPatternFilter",
                    @"GPUImageLookupFilter",
                    @"GPUImageLowPassFilter",
                    @"GPUImageLuminanceRangeFilter",
                    @"GPUImageLuminanceThresholdFilter",
                    @"GPUImageLuminosityBlendFilter",
                    @"GPUImageMaskFilter",
                    @"GPUImageMedianFilter",
                    @"GPUImageMissEtikateFilter",
                    @"GPUImageMonochromeFilter",
                    @"GPUImageMosaicFilter",
                    @"GPUImageMotionBlurFilter",
                    @"GPUImageMultiplyBlendFilter",
                    @"GPUImageNobleCornerDetectionFilter",
                    @"GPUImageNonMaximumSuppressionFilter",
                    @"GPUImageNormalBlendFilter",
                    @"GPUImageOpacityFilter",
                    @"GPUImageOpeningFilter",
                    @"GPUImageOverlayBlendFilter",
                    @"GPUImageParallelCoordinateLineTransformFilter",
                    @"GPUImagePerlinNoiseFilter",
                    @"GPUImagePinchDistortionFilter",
                    @"GPUImagePixellateFilter",
                    @"GPUImagePixellatePositionFilter",
                    @"GPUImagePoissonBlendFilter",
                    @"GPUImagePolarPixellateFilter",
                    @"GPUImagePolkaDotFilter",
                    @"GPUImagePosterizeFilter",
                    @"GPUImagePrewittEdgeDetectionFilter",
                    @"GPUImageRGBClosingFilter",
                    @"GPUImageRGBDilationFilter",
                    @"GPUImageRGBErosionFilter",
                    @"GPUImageRGBFilter",
                    @"GPUImageRGBOpeningFilter",
                    @"GPUImageSaturationBlendFilter",
                    @"GPUImageSaturationFilter",
                    @"GPUImageScreenBlendFilter",
                    @"GPUImageSepiaFilter",
                    @"GPUImageSharpenFilter",
                    @"GPUImageShiTomasiFeatureDetectionFilter",
                    @"GPUImageSingleComponentGaussianBlurFilter",
                    @"GPUImageSketchFilter",
                    @"GPUImageSmoothToonFilter",
                    @"GPUImageSobelEdgeDetectionFilter",
                    @"GPUImageSoftEleganceFilter",
                    @"GPUImageSoftLightBlendFilter",
                    @"GPUImageSourceOverBlendFilter",
                    @"GPUImageSphereRefractionFilter",
                    @"GPUImageStretchDistortionFilter",
                    @"GPUImageSubtractBlendFilter",
                    @"GPUImageSwirlFilter",
                    @"GPUImageThreeInputFilter",
                    @"GPUImageThresholdEdgeDetectionFilter",
                    @"GPUImageThresholdSketchFilter",
                    @"GPUImageThresholdedNonMaximumSuppressionFilter",
                    @"GPUImageTiltShiftFilter",
                    @"GPUImageToneCurveFilter",
                    @"GPUImageToonFilter",
                    @"GPUImageTransformFilter",
                    @"GPUImageTwoInputCrossTextureSamplingFilter",
                    @"GPUImageTwoInputFilter",
                    @"GPUImageTwoPassFilter",
                    @"GPUImageTwoPassTextureSamplingFilter",
                    @"GPUImageUnsharpMaskFilter",
                    @"GPUImageVignetteFilter",
                    @"GPUImageVoronoiConsumerFilter",
                    @"GPUImageWeakPixelInclusionFilter",
                    @"GPUImageWhiteBalanceFilter",
                    @"GPUImageXYDerivativeFilter",
                    @"GPUImageZoomBlurFilter",
                    @"GPUImageiOSBlurFilter",
                    nil];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_mAllFilters count];
}

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return pickerView.bounds.size.width - 10;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.font = [UIFont fontWithName:@"SourceSansPro-Semibold" size:18];
        
        pickerLabel.textAlignment=NSTextAlignmentCenter;
    }
    [pickerLabel setText:[_mAllFilters objectAtIndex:row]];
    
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_mCamera stopCameraCapture];
    [_mCamera removeAllTargets];
    if (_mFilter) {
        [_mFilter removeAllTargets];
    }
    Class filterClass = NSClassFromString(_mAllFilters[row]);
    _mFilter = [[filterClass alloc] init];
    [_mCamera addTarget:_mFilter];
    [_mFilter addTarget:_mGPUImgView];
    [_mCamera startCameraCapture];
}

@end
