//
//  ViewController.m
//  SendMail
//
//  Created by Jay Versluis on 21/05/2015.
//  Copyright (c) 2015 Pinkstone Pictures LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMail:(id)sender {
    
    // bring up an MFMailComposeViewController
    // check if device can actually send mail
    
    if ([MFMailComposeViewController canSendMail]) {
        
        // create the controller and set the delegate
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        
        // email subject line
        [mailer setSubject:@"I've written a frigging Masterpiece!"];
        
        // email recipients
        NSArray *toRecipients = [NSArray arrayWithObjects:@"you@domain.com", @"me@domain.com", nil];
        [mailer setToRecipients:toRecipients];
        
        // attach an image
        UIImage *myImage = [UIImage imageNamed:@"Promo1"];
        NSData *imageData = UIImagePNGRepresentation(myImage);
        [mailer addAttachmentData:imageData mimeType:@"image/jpg" fileName:@"Promo1"];
        
        // create the actual email message
        NSString *emailBody = @"This is your message.";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        // present the mail view controller
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:nil];
        
    } else {
        
        // if device can't send mail, show an alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"Darn!"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - MFMailComposeViewController Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    // this method is called when the mail view controller has finished
    // you can check the error object for a better user experience
    // or simply dismiss the controller here
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

@end
