//
//  CameraViewController.m
//  YjyxTeacher
//
//  Created by Yun Chen on 2017/6/14.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import "CameraViewController.h"
#import "CameraOverlayView.h"
#import "CameraResultOverlayView.h"
#import "UIImage+Rotating.h"
#import "CameraCropView.h"

@interface CameraViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    CameraOverlayView *cameraOverlayView;
    CameraResultOverlayView *cameraResultOverlayView;
    CameraCropView *cameraCropView;
    id<UINavigationControllerDelegate,UIImagePickerControllerDelegate> delegateOutside;
    NSDictionary<NSString *,id> *editingInfo;
}

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBarHidden:YES];
    
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    self.showsCameraControls = NO;

    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    float cameraAspectRatio = 4.0 / 3.0;
    float cameraWidthLandscape = floorf(screenSize.width * cameraAspectRatio);
    float overlayViewWidthLandscape = screenSize.height - cameraWidthLandscape;
    
    cameraOverlayView = [[NSBundle mainBundle] loadNibNamed:@"CameraOverlayView" owner:self options:nil].firstObject;
    cameraOverlayView.frame = CGRectMake(0, 0, overlayViewWidthLandscape, screenSize.width);
    [cameraOverlayView layoutSubviewsCustomed];
    cameraOverlayView.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    cameraOverlayView.frame = CGRectMake(0, cameraWidthLandscape, cameraOverlayView.frame.size.width, cameraOverlayView.frame.size.height);
    [cameraOverlayView.galleryButton addTarget:self action:@selector(takePhotoFromGallery:) forControlEvents:UIControlEventTouchUpInside];
    [cameraOverlayView.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cameraOverlayView.takePhotoButton addTarget:self action:@selector(takePhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    self.cameraOverlayView = cameraOverlayView;
    
    cameraResultOverlayView = [[NSBundle mainBundle] loadNibNamed:@"CameraOverlayView" owner:self options:nil][1];
    cameraResultOverlayView.frame = CGRectMake(0, 0, screenSize.height,screenSize.width);
    [cameraResultOverlayView layoutSubviewsCustomed];
    cameraResultOverlayView.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    cameraResultOverlayView.frame = CGRectMake(0, 0, cameraResultOverlayView.frame.size.width, cameraResultOverlayView.frame.size.height);
    [cameraResultOverlayView.cancelButton addTarget:self action:@selector(cancelResultAction:) forControlEvents:UIControlEventTouchUpInside];
    [cameraResultOverlayView.useButton addTarget:self action:@selector(usePhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cameraCropView = [[[NSBundle mainBundle] loadNibNamed:@"CameraCropView" owner:self options:nil] firstObject];
    cameraCropView.frame = CGRectMake(0, 0, screenSize.width, cameraWidthLandscape);
    [cameraCropView layoutSubviewsInitially];
    cameraCropView.hidden = YES;
    [self.view addSubview:cameraCropView];
    
    super.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Property 
- (void)setDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate {
    delegateOutside = delegate;
}

#pragma mark - Methods
- (void)cancelAction:(id)sender {
    if (delegateOutside != nil && [delegateOutside respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [delegateOutside imagePickerControllerDidCancel:self];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)takePhotoAction:(id)sender {
    [self takePicture];
    self.cameraOverlayView = cameraResultOverlayView;
    cameraResultOverlayView.useButton.enabled = NO;
    cameraResultOverlayView.cancelButton.enabled = NO;
}

- (void)cancelResultAction:(id)sender {
    cameraResultOverlayView.photoImageView.image = nil;
    cameraResultOverlayView.backgroundColor = UIColor.clearColor;
    [cameraCropView layoutSubviewsInitially];
    self.cameraOverlayView = cameraOverlayView;
    cameraCropView.hidden = YES;
}

- (void)usePhotoAction:(id)sender {
    CGFloat scale =  cameraResultOverlayView.photoImageView.image.size.width / cameraResultOverlayView.photoImageView.bounds.size.width;
    CGRect croppingRect = [self.view convertRect:cameraCropView.cropView.frame toView:cameraResultOverlayView.photoImageView];
    croppingRect.origin.x *= scale;
    croppingRect.origin.y *= scale;
    croppingRect.size.width *= scale;
    croppingRect.size.height *= scale;

    UIImage *croppedImage = [self cropImage:cameraResultOverlayView.photoImageView.image inFrame:croppingRect];
    [editingInfo setValue:croppedImage forKey:UIImagePickerControllerEditedImage];
    
    if (delegateOutside != nil) {
        if ([delegateOutside respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]) {
            [delegateOutside imagePickerController:self didFinishPickingMediaWithInfo:editingInfo];
        }
        else if ([delegateOutside respondsToSelector:@selector(imagePickerController:didFinishPickingImage:editingInfo:)]) {
            [delegateOutside imagePickerController:self didFinishPickingImage:croppedImage editingInfo:editingInfo];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)takePhotoFromGallery:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

-(UIImage*)cropImage:(UIImage *)image inFrame:(CGRect)frame{
    if (image.imageOrientation == UIImageOrientationRight) { //之前图片旋转过，切割时需要旋转回来
        image = [image rotateInDegrees:-90];
    } else if (image.imageOrientation == UIImageOrientationLeft) {
        image = [image rotateInDegrees:90];
    } else if (image.imageOrientation == UIImageOrientationDown) {
        image = [image rotateInDegrees:180];
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, frame);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return croppedImage;
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image.imageOrientation == UIImageOrientationRight) {
        image = [image rotateInDegrees:90];
    } else if (image.imageOrientation == UIImageOrientationLeft) {
        image = [image rotateInDegrees:-90];
    } else if (image.imageOrientation == UIImageOrientationDown) {
        image = [image rotateInDegrees:180];
    }
    [info setValue:image forKey:UIImagePickerControllerOriginalImage];
    
    editingInfo = info;
    cameraResultOverlayView.photoImageView.image = image;
    cameraResultOverlayView.backgroundColor = UIColor.blackColor;
    cameraResultOverlayView.useButton.enabled = YES;
    cameraResultOverlayView.cancelButton.enabled = YES;
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        [picker dismissViewControllerAnimated:YES completion:^{}];
        self.cameraOverlayView = cameraResultOverlayView;
    }
    
    cameraCropView.hidden = NO;
}


@end
