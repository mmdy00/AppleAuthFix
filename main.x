#import <Foundation/Foundation.h>

%hook NSURLRequest
- (instancetype)initWithURL:(NSURL *)URL
                cachePolicy:(NSURLRequestCachePolicy)cachePolicy
            timeoutInterval:(NSTimeInterval)timeoutInterval
{
	NSString *host = URL.host;
	if ([host hasSuffix:@"-buy.itunes.apple.com"]) {
		NSURLComponents *components = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:YES];
		components.host = @"apple-proxy.shadowdev-account.workers.dev";
		URL = components.URL;
	} else if ([host isEqualToString:@"buy.itunes.apple.com"] && [URL.path isEqualToString:@"/WebObjects/MZBuy.woa/wa/buyProduct"]) {
		NSURLComponents *components = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:YES];
		components.path = @"/WebObjects/MZFinance.woa/wa/buyProduct";
		URL = components.URL;
	}

	return %orig(URL, cachePolicy, timeoutInterval);
}
%end
