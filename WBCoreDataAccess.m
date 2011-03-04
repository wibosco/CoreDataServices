/*
 Copyright (C) 2010 Boles. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 Neither the name of the author nor the names of its contributors may be used
 to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "WBCoreDataAccess.h"

@implementation WBCoreDataAccess

static NSManagedObjectContext *managedObjectContext;

#pragma mark -
#pragma mark ManagedObjectContext accessors

+(void) setManagedObjectContext:(NSManagedObjectContext*)context
{
	managedObjectContext = context;
}

+(NSManagedObjectContext*) getManagedObjectContext
{
	return managedObjectContext;
}

#pragma mark -
#pragma mark Retrieval Methods - without faulting

+(NSArray*) getRecordsWithoutFaultingForTable:(NSString*)table 
{
	NSEntityDescription *entity = [NSEntityDescription entityForName:table inManagedObjectContext:managedObjectContext];
	
	NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
	
	// needed to prevent faults being returned
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	[fetchRequest setEntity:entity];
	
	NSArray *records = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
	
	[fetchRequest release];
	
	return records;
}

+(NSArray*) getRecordsWithoutFaultingForTable:(NSString *)table withPredicate:(NSPredicate *)prd
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:table inManagedObjectContext:managedObjectContext];
	
	// needed to prevent faults being returned
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	[fetchRequest setEntity:entity];
	
	[fetchRequest setPredicate:prd];
	
	NSArray *records = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
	
	[fetchRequest release];
	
	return records;
}


+(NSArray*) getRecordsWithoutFaultingForTable:(NSString*)table WithStringPredicate:(NSString*)prd
{
	NSEntityDescription *entity = [NSEntityDescription entityForName:table inManagedObjectContext:managedObjectContext];
	
	NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
	
	// needed to prevent faults being returned
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	[fetchRequest setEntity:entity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:prd];
	
	[fetchRequest setPredicate:predicate];
	
	NSArray *records = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
	
	[fetchRequest release];
	
	return records;
}

#pragma mark -
#pragma mark Retrieval Methods - With faulting

+(NSArray*) getRecordsForTable:(NSString*)table 
{
	NSEntityDescription *entity = [NSEntityDescription entityForName:table inManagedObjectContext:managedObjectContext];
	
	NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
	
	[fetchRequest setEntity:entity];
	
	NSArray *records = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
	
	[fetchRequest release];
	
	return records;
}

+(NSArray*) getRecordsForTable:(NSString *)table withPredicate:(NSPredicate *)prd
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:table inManagedObjectContext:managedObjectContext];
	
	[fetchRequest setEntity:entity];
	
	[fetchRequest setPredicate:prd];
	
	NSArray *records = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
	
	[fetchRequest release];
	
	return records;
}

+(NSArray*) getRecordsForTable:(NSString*)table WithStringPredicate:(NSString*)prd
{
	NSEntityDescription *entity = [NSEntityDescription entityForName:table inManagedObjectContext:managedObjectContext];
	
	NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
	
	[fetchRequest setEntity:entity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:prd];
	
	[fetchRequest setPredicate:predicate];
	
	NSArray *records = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
	
	[fetchRequest release];
	
	return records;
}

+(NSArray*) getRecordsForTable:(NSString*)table Top:(NSNumber*)top OnColumn:(NSString*)column Ascending:(Boolean)order{
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:table inManagedObjectContext:managedObjectContext];
	
	NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
	
	[fetchRequest setEntity:entity];
	
	NSArray *records = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
	
	[fetchRequest release];
	
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:column ascending:order];
	
	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
	
	NSArray* sortedReadings = [NSArray arrayWithArray:[records sortedArrayUsingDescriptors:descriptors]];
	
	NSMutableArray* topRecords = [[[NSMutableArray alloc] initWithCapacity:[top intValue]] autorelease];
	
	for (int i = 0; i < [top intValue]; i++) {
		[topRecords addObject:[sortedReadings objectAtIndex:i]];
	}
	
	return topRecords;
	
}

+(NSArray*) getRecordsForTable:(NSString*)table OnColumn:(NSString*)column Ascending:(Boolean)order{
	NSEntityDescription *entity = [NSEntityDescription entityForName:table inManagedObjectContext:managedObjectContext];
	
	NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
	
	[fetchRequest setEntity:entity];
	
	NSArray *records = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
	
	[fetchRequest release];
	
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:column ascending:order];
	
	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
	
	NSArray* sortedReadings = [NSArray arrayWithArray:[records sortedArrayUsingDescriptors:descriptors]];
	
	return sortedReadings;
	
}



#pragma mark -
#pragma mark Delete methods

+(void) deleteRecord:(NSManagedObject *)object{
	[managedObjectContext deleteObject:object];
	
	[self saveContext];
}

+(void) deleteAllRecordsInTable:(NSString*)table
{
    // Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:table inManagedObjectContext:managedObjectContext];
    
	NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
	
	// needed to prevent faults being returned
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	[fetchRequest setEntity:entity];
	
	NSArray* resultsArray = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
	[fetchRequest release];
	for (NSManagedObject *managedObject in resultsArray) {
        [managedObjectContext deleteObject:managedObject];
    }
	
	[self saveContext];
}

#pragma mark -
#pragma mark Save context methods

+(void) saveContext
{	
	NSError* error = nil;
	if (![managedObjectContext save:&error]) {
		NSLog(@"Error with database transaction: %@", error);
	}
}

@end