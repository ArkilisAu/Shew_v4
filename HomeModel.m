//
//  HomeModel.m
//  Shew_v4
//
//  Created by Ben Liu on 26/10/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

#import "HomeModel.h"

#import "HomeModel.h"
#import "SenderAddress.h"

@interface HomeModel()
{
    NSMutableData *_downloadedData;
}
@end

@implementation HomeModel

- (void)downloadItems: (NSString*)lat :(NSString *)lgt
{
    // Download the json file
    NSString *url= [NSString stringWithFormat: @"http://54.210.200.34/getnearlocations.php?latitude=%@&longitude=%@", lat, lgt];

    NSURL *jsonFileUrl = [NSURL URLWithString: url];
    
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the locations
    NSMutableArray *_locations = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new location object and set its props to JsonElement properties
        SenderAddress *newLocation = [[SenderAddress alloc] init];
        newLocation.aid = jsonElement[@"id"];
        newLocation.userid = jsonElement[@"userid"];
        newLocation.latitude = jsonElement[@"latitude"];
        newLocation.longitude = jsonElement[@"longitude"];
        newLocation.fileurl = jsonElement[@"fileurl"];
        
        // Add this question to the locations array
        [_locations addObject:newLocation];
        NSLog(jsonElement[@"id"]);
        //NSLog(newLocation.aid);
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_locations];
    }
}

@end