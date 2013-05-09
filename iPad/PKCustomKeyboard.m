//
//  PKCustomKeyboard.m
//  PunjabiKeyboard
//
//  Created by Kulpreet Chilana on 7/19/12.
//  Copyright (c) 2012 Kulpreet Chilana. All rights reserved.
//

#import "PKCustomKeyboard.h"

@interface PKCustomKeyboard ()

@property (nonatomic, assign, getter=isShifted) BOOL shifted;

@end

@implementation PKCustomKeyboard
@synthesize textView = _textView;

#define kFont [UIFont fontWithName:@"Ayar" size:20]
#define kAltLabel @"<3"
#define kReturnLabel @"return"
#define kChar @[ @"\u1039", @"\u1006", @"\u1010", @"\u1014", @"\u1019", @"\u1021", @"\u1015", @"\u1000", @"\u1004", @"\u101E", @"\u1005", @"\u1031", @"- \u103B", @"- \u102D", @"- \u103A", @"- \u102B", @"- \u1037", @"\u103C-", @"- \u102F", @"- \u1030", @"- \u1038", @"\u1012", @"ဿ", @"\u1016", @"\u1011", @"\u1001", @"\u101C", @"\u1018", @"\u100A", @"- \u102C", @"\u101A",@"\u104F",@" "]
#define kChar_shift @[ @"\u101B", @"\u1002", @"\u101D", @"\u100F", @"\u1024", @"\u104C", @"\u104D", @"\u1025", @"\u101F", @"\u1027", @"\u1009", @"\u1017", @"- \u103E", @"- \u102E", @"- ႅ", @"- \u103D", @"- \u1036", @"- \u1032", @"​ ါ်", @"\u1013", @"\u1026", @"\u104E\u1004\u103A\u1038", @"\u1007", @"\u100C", @"\u1003", @"\u1020", @"\u100B", @"\u100D", @"\u100E", @"\u1023",@"\u1029", @"॥",@"" ]
#define kChar_alt @[ @"\u1041", @"\u1042", @"\u1043", @"\u1044", @"\u1045", @"\u1046", @"\u1047", @"\u1048", @"\u1049", @"\u1040", @"-", @"~", @"!", @"@", @"#", @"$", @"%", @"^", @"&", @"*", @"(", @")", @"\\", @";", @":", @"\"", @"'", @"<", @">", @",", @".", @"?", @"", @"" ]

- (id)init {
	UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
	CGRect frame;

	if(UIDeviceOrientationIsLandscape(orientation))
        frame = CGRectMake(0, 0, 1024, 352);
    else 
        frame = CGRectMake(0, 0, 768, 264);
	
	self = [super initWithFrame:frame];
	
	if (self) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PKCustomKeyboard" owner:self options:nil];
		[[nib objectAtIndex:0] setFrame:frame];
        self = [nib objectAtIndex:0];
    }
	
	NSMutableArray *buttons = [NSMutableArray arrayWithArray:self.characterKeys];
	[buttons addObjectsFromArray:self.altButtons];
	[buttons addObject:self.returnButton];
	[buttons addObject:self.dismissButton];
	[buttons addObject:self.deleteButton];

	
	for (UIButton *b in buttons) {
		[b setBackgroundImage:[PKCustomKeyboard imageFromColor:[UIColor colorWithWhite:0.5 alpha:0.5]]
						  forState:UIControlStateHighlighted];
		b.layer.cornerRadius = 7.0;
		b.layer.masksToBounds = YES;
		b.layer.borderWidth = 0;
	}
	
	for (UIButton *b in self.altButtons)
		[b setTitle:kAltLabel forState:UIControlStateNormal];
	
	[self.returnButton setTitle:kReturnLabel forState:UIControlStateNormal];
	self.returnButton.titleLabel.adjustsFontSizeToFitWidth = YES;
	
	[self loadCharactersWithArray:kChar];
	
	return self;
}

-(void)setTextView:(id<UITextInput>)textView {
	
	if ([textView isKindOfClass:[UITextView class]])
        [(UITextView *)textView setInputView:self];
    else if ([textView isKindOfClass:[UITextField class]])
        [(UITextField *)textView setInputView:self];
    
    _textView = textView;
}

-(id<UITextInput>)textView {
	return _textView;
}

-(void)loadCharactersWithArray:(NSArray *)a {
	int i = 0;
	for (UIButton *b in self.characterKeys) {
		[b setTitle:[a objectAtIndex:i] forState:UIControlStateNormal];
        if ([b.titleLabel.text characterAtIndex:0] < 128 && ![[b.titleLabel.text substringToIndex:1] isEqualToString:@"-"])
			[b.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        else
            if ([[b.titleLabel.text substringToIndex:1] isEqualToString:@"\u102A"])
                [b.titleLabel setFont:[UIFont fontWithName:@"Ayar" size:13]];
            else
                [b.titleLabel setFont:kFont];
		i++;
	}
}

- (BOOL) enableInputClicksWhenVisible {
    return YES;
}

/* IBActions for Keyboard Buttons */

- (IBAction)returnPressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
	[self.textView insertText:@"\n"];
	if ([self.textView isKindOfClass:[UITextView class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
	else if ([self.textView isKindOfClass:[UITextField class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}

- (IBAction)shiftPressed:(id)sender {
	[[UIDevice currentDevice] playInputClick];
	if (!self.isShifted) {
		[self.keyboardBackground setImage:[UIImage imageNamed:@"Keyboard_Shift.png"]];
		[self loadCharactersWithArray:kChar_shift];
		for (UIButton *b in self.altButtons)
			[b setTitle:kAltLabel forState:UIControlStateNormal];
	}
}

- (IBAction)unShift {
	if (self.isShifted) {
		[self.keyboardBackground setImage:[UIImage imageNamed:@"Keyboard_Blank.png"]];
		[self loadCharactersWithArray:kChar];
	}
	if (!self.isShifted)
		self.shifted = YES;
	else
		self.shifted = NO;
}

- (IBAction)altPressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
	[self.keyboardBackground setImage:[UIImage imageNamed:@"Keyboard_Blank.png"]];
	self.shifted = NO;
	UIButton *button = (UIButton *)sender;
	
	if ([button.titleLabel.text isEqualToString:kAltLabel]) {
		[self loadCharactersWithArray:kChar_alt];
		for (UIButton *b in self.altButtons)
			[b setTitle:[kChar objectAtIndex:18] forState:UIControlStateNormal];
	}
	else {
		[self loadCharactersWithArray:kChar];
		for (UIButton *b in self.altButtons)
			[b setTitle:kAltLabel forState:UIControlStateNormal];
	}
}

- (IBAction)dismissPressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
	
	if ([self.textView isKindOfClass:[UITextView class]]) 
        [(UITextView *)self.textView resignFirstResponder];
	
    else if ([self.textView isKindOfClass:[UITextField class]])
        [(UITextField *)self.textView resignFirstResponder];
}

- (IBAction)deletePressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
	[self.textView deleteBackward];
	[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification
														object:self.textView];
	if ([self.textView isKindOfClass:[UITextView class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
	else if ([self.textView isKindOfClass:[UITextField class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}

- (IBAction)characterPressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
	UIButton *button = (UIButton *)sender;
	NSString *character = [NSString stringWithString:button.titleLabel.text];
	
	if ([[character substringToIndex:1] isEqualToString:@"-"])
		character = [character substringFromIndex:2];
	
	else if ([[character substringFromIndex:character.length - 1] isEqualToString:@"-"])
		character = [character substringToIndex:character.length - 1];
	
	[self.textView insertText:character];

	/*if (self.isShifted)
		[self unShift];
	*/
	if ([self.textView isKindOfClass:[UITextView class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
	else if ([self.textView isKindOfClass:[UITextField class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}

/* UI Utilities */

+ (UIImage *) imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
