//
//  PMCustomKeyboard.h
//  PunjabiKeyboard
//
//  Created by Kulpreet Chilana on 7/31/12.
//  Copyright (c) 2012 Kulpreet Chilana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kFont [UIFont fontWithName:@"Ayar" size:16]
#define kAltLabel @"<3"
#define kReturnLabel @"return"
#define kSpaceLabel @"space"
#define kChar @[ @"\u1039", @"\u1006", @"\u1010", @"\u1014", @"\u1019", @"\u1021", @"\u1015", @"\u1000", @"\u1004", @"\u101E", @"\u1005", @"\u1031", @"- \u103B", @"- \u102D", @"- \u103A", @"- \u102B", @"- \u1037", @"\u103C-", @"- \u102F", @"- \u1030", @"- \u1038", @"\u1012", @"\u1016", @"\u1011", @"\u1001", @"\u101C", @"\u1018", @"\u100A", @"- \u102C", @"\u101A" ]
#define kChar_shift @[ @"\u101B", @"\u1002", @"\u101D", @"\u100F", @"\u1024", @"\u104C", @"\u104D", @"\u1025", @"\u101F", @"\u1027", @"\u1009", @"\u1017", @"- \u103E", @"- \u102E", @"- ႅ", @"- \u103D", @"- \u1036", @"- \u1032", @"​ ါ်", @"\u1013", @"- ဴ", @"ဿ", @"\u1007", @"\u100C", @"\u1003", @"\u1020", @"\u100B", @"\u100D", @"\u104F", @"\u104A" ]
#define kChar_alt @[ @"\u1041", @"\u1042", @"\u1043", @"\u1044", @"\u1045", @"\u1046", @"\u1047", @"\u1048", @"\u1049", @"\u1040", @"\u100E", @"\u1023", @"\u1026", @"\u104E\u1004\u103A\u1038", @"\u1029", @"\u102A", @"@", @"#", @"$", @"%", @"&", @"*", @"!", @"?", @"/", @"-", @"+", @"(", @")", @"။" ]

@interface PMCustomKeyboard : UIView <UIInputViewAudioFeedback>

@property (strong, nonatomic) IBOutlet UIImageView *keyboardBackground;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *characterKeys;
@property (strong, nonatomic) IBOutlet UIButton *shiftButton;
@property (strong, nonatomic) IBOutlet UIButton *altButton;
@property (strong, nonatomic) IBOutlet UIButton *returnButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong) id<UITextInput> textView;
@property (strong, nonatomic) IBOutlet UIButton *spaceButton;

- (IBAction)returnPressed:(id)sender;
- (IBAction)characterPressed:(id)sender;
- (IBAction)shiftPressed:(id)sender;
- (IBAction)altPressed:(id)sender;
- (IBAction)deletePressed:(id)sender;
- (IBAction)unShift;
- (IBAction)spacePressed:(id)sender;

@end
