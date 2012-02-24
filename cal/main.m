//
//  main.m
//  cal
//
//  Created by Izaak Meckler on 1/19/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CalendarStore/CalendarStore.h>

int main (int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSInteger year = [[NSCalendarDate date] yearOfCommonEra];
        NSInteger month = [[NSCalendarDate date] monthOfYear];
        NSInteger day = [[NSCalendarDate date] dayOfMonth];
        
        NSDate *startDate = [[NSCalendarDate dateWithYear:year month:month day:day hour:0 minute:0 second:0 timeZone:nil] retain];
        NSDate *endDate = [[NSCalendarDate dateWithYear:year month:month day:day hour:23 minute:59 second:59 timeZone:nil] retain];
        
        NSPredicate *eventsForToday = [CalCalendarStore eventPredicateWithStartDate:startDate endDate:endDate calendars:[[CalCalendarStore defaultCalendarStore] calendars]];
        
        NSArray *events = [[CalCalendarStore defaultCalendarStore] eventsWithPredicate:eventsForToday];
        
        for (CalEvent *event in events) {
            NSDate *eventDate = [event startDate];
            
            int hour = [[eventDate dateWithCalendarFormat:nil timeZone:nil] hourOfDay];
            int min = [[eventDate dateWithCalendarFormat:nil timeZone:nil] minuteOfHour];
            
            NSString *minString = [[NSString alloc] init];
            
            if ( min < 10) {
                minString = [NSString stringWithFormat:@"0%i", min];
            }
            else{
                minString = [NSString stringWithFormat:@"%i", min];
            }
            
            printf("%s\n", [[NSString stringWithFormat:@"%2i:%@ %@", hour, minString, event.title] UTF8String]);
            
        }
    }
    return 0;
}
