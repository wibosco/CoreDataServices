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

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/*!
 
 @class CoreDataAccess
 
 @abstract This class provides a number of useful extensions to the NSManagedObject class
 
 @namespace model
 
 @updated 2010-08-12
 
 */
@interface WBCoreDataAccess : NSObject {
	
}

#pragma mark -
#pragma mark ManagedObjectContext accessors

+(void) setManagedObjectContext:(NSManagedObjectContext*)context;
+(NSManagedObjectContext*) getManagedObjectContext;

#pragma mark -
#pragma mark Retrieval Methods - without faulting

/*!
 @method This returns all records that exist for a table without faulting
 @param table - an NSString that presents a table in the database
 */
+(NSArray*) getRecordsWithoutFaultingForTable:(NSString*)table;

/*!
 @method This returns records that exist for a table based on a condition(s) without faulting
 @param table - an NSString that presents a table in the database
 @param predicate - A predicate which limits the number of records returned
 */
+(NSArray*) getRecordsWithoutFaultingForTable:(NSString *)table withPredicate:(NSPredicate *)prd;

/*!
 @method This returns records that exist for a table based on a condition(s) without faulting
 @param table - an NSString that presents a table in the database
 @param predicate - NSString representation of a predicate which limits the number of records returned
 */
+(NSArray*) getRecordsWithoutFaultingForTable:(NSString*)table WithStringPredicate:(NSString*)prd;

#pragma mark -
#pragma mark Retrieval Methods - With faulting

/*!
 @method This returns all records that exist for a table
 @param table - an NSString that presents a table in the database
 */
+(NSArray*) getRecordsForTable:(NSString*)table;

/*!
 @method This returns records that exist for a table based on a condition(s)
 @param table - an NSString that represents a table in the database
 @param predicate - A predicate which limits the number of records returned
 */
+(NSArray*) getRecordsForTable:(NSString *)table withPredicate:(NSPredicate *)prd;

/*!
 @method This returns records that exist for a table based on a condition(s)
 @param table - an NSString that represents a table in the database
 @param predicate - NSString representation of a predicate which limits the number of records returned
 */
+(NSArray*) getRecordsForTable:(NSString*)table WithStringPredicate:(NSString*)prd;

/*!
 @method This returns records that exist for a table based on a condition(s)
 @param table - an NSString that represents a table in the database
 @param top - NSNumber that determines how many records to return
 @param column - NSString that represents a column name
 @param ascending - Boolean to sort records in ascending or descending order
 */
+(NSArray*) getRecordsForTable:(NSString*)table Top:(NSNumber*)top OnColumn:(NSString*)column Ascending:(Boolean)order;


/*!
 @method This returns records that exist for a table based on a condition(s)
 @param table - an NSString that represents a table in the database
 @param column - NSString that represents a column name
 @param ascending - Boolean to sort records in ascending or descending order
 */
+(NSArray*) getRecordsForTable:(NSString*)table OnColumn:(NSString*)column Ascending:(Boolean)order;


#pragma mark -
#pragma mark Delete methods


/*!
 @method Deletes a managed object from the database
 @param object - Record to be deleted
 */
+(void) deleteRecord:(NSManagedObject *)object;

/*!
 @method Deletes all entries from database table
 @param table - an NSString that represents a table in the database
 */
+(void) deleteAllRecordsInTable:(NSString*)table;

#pragma mark -
#pragma mark Save context methods

/*!
 @method Save managedobjectcontext and provide error message handling
 */
+(void) saveContext;

@end