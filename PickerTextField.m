/*
Copyright (c) 2012 Cullen SUN

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
//
//  PickerTextField.m
//  http://creiapp.blogspot.hk/2012/11/uitextfield-with-input-from-uipickerview.html
//

#import "PickerTextField.h"
@interface PickerTextField()
- (void) setup;
@end



@implementation PickerTextField
@synthesize pickedIndex,picker;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void) awakeFromNib{
    [super awakeFromNib];
    [self setup];
    
}

- (void) setup{
    self.pickedIndex=-1;
    deleHandler=[[PickerTextFieldHandler alloc]init];
    self.delegate=(id)deleHandler;
    
}

-(void)setDataSource:(NSArray *) sourceArray andPlaceHolder:(NSString*)theholder
{
    
    [self setPlaceholder:theholder];
    sourceStringsArray=[[NSArray alloc] initWithArray:sourceArray];
    //setup pickerview here

    if (!self.picker) {
        UIPickerView * _picker=[[UIPickerView alloc] init];
        self.picker=[_picker autorelease];
        self.inputView=self.picker;
        
    }
    
    [self.picker setFrame:CGRectMake(0, 40, 320, 216)];
    self.picker.delegate=self;
    self.picker.dataSource=self;
    self.picker.showsSelectionIndicator=YES;
    
    if (self.pickedIndex!=-1) {
        [self setText:[sourceStringsArray objectAtIndex:self.pickedIndex]];
    }
    
}



#pragma mark -
#pragma mark PickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    
    return 50;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [sourceStringsArray count];
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *cellLable = (UILabel*) view;
    if (cellLable == nil)
    {
        cellLable = [[[UILabel alloc] init] autorelease];
        [cellLable setFrame:CGRectMake(40, 5, 260, 40)];
        cellLable.backgroundColor=[UIColor clearColor];
        cellLable.numberOfLines=2;
        cellLable.font=[UIFont boldSystemFontOfSize:16];
        
    }
    
    
    cellLable.text=[sourceStringsArray objectAtIndex:row];
    return cellLable ;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.text=[sourceStringsArray objectAtIndex:row];
    self.pickedIndex=row;
}

#pragma mark -
#pragma mark Forwarded UITextFieldDelegate
-(void) pickerTextFieldDidBeginEditing{
    if (self.pickedIndex==-1) {
           self.pickedIndex=0;
           [self setText:[sourceStringsArray objectAtIndex:self.pickedIndex]];
        }
      [self.picker selectRow:self.pickedIndex inComponent:0 animated:NO];
}
- (void)dealloc {
    [sourceStringsArray release];
    [deleHandler release];
    [picker release];
    [super dealloc];
}


@end
