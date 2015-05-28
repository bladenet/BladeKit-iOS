# BladeKit

BladeKit is a friendly framework for speedier iOS development. It is written in Swift. It is intended to be lightweight, customizable, and have useful stuff for which building more stuff is easier.

- Easy to import
- Friendly
- Useful Subscripting and Extensions
- Server interactions

## Installation to a new project
#### Step one, cloning and misc maintenance
Go ahead and change directories to something relevant in your iOS project. No, this doesn't mean the root directory. This means something like `<project>/frameworks`. From the command line, type the following:
```
git submodule add git@github.com:bladenet/BladeKit-iOS.git
```
##### Upkeep
Reminder these means that when you clone originally, you must include the recursive option, but I'm sure you knew that already.
```
git clone --recursive
```
And of course to update the submodule, the basic
```
git submodule foreach git pull
```
For what it's worth, you will probably also want a nice alias to help with the matter of submodules.
```
git config --global alias.pr '!git pull --rebase; git submodule init; git submodule update;'
```

#### Step two, dragging the folder and adding the build dependency
After this, go ahead and drag the `BladeKit-iOS.xcodeproj` (*not the folder*) into the finder in your active Xcode project. Be sure to copy files as needed.

Your next step will be to include the BladeKit.Framework as a build dependency in your target settings. Hit the + Button, it should auto populate as XCode is now familiar with these files and this target.

#### Step three, embedding the framework for device builds
And finally, for device builds, you will need to add the 'Embed Framework' phase. In the target's General tab, there is an Embedded Binaries field. Add the BladeKit.framework there as well. If you don't do this, you will get an error like 'missing image' when you build on your actual device. And, of course, you don't want that.

After this, you will need to include:
```
import BladeKit
```
In any files in your project that reference the Kit

## Server Interactions
There are two main ways to use this piece of BladeKit. 
- Generic
- Subclassing

You can also mix and match these two ideas. Let's take a look at the generic approach first:
### Generic Server Interactions
The meat of this public facing API is in `ServerClient`. And the most relevant call you will be making is:
```
public class func performRequest(request: ServerRequest, completion:(response: ServerResponse) -> Void) -> NSOperation)
```
The idea being that this performs your configurable `ServerRequest` on a separate thread (managed by NSOperationQueue), and performs the completion block with a `ServerResponse`, which notably includes an `NSError*` on it as well. The method call itself returns an NSOperation object (a subclass of, that is, but the caller doesn't need to know that) that the caller can manage if need be, or not. Notably something like `func cancel()`. 

Moving on, let's take a look at this `ServerRequest` object.
```
public class ServerRequest
```
For your purposes reading the 'Generic Interactions' piece of this tutorial, the most important thing to notice is that this contains a `public var url : NSURL?`. Set this and your request is good to go. For more interesting things to do with this class, scroll down to the 'Custom subclassing' section. It is highly recommended, for example, that your own project would contain a `__your_project__Request` object that manages some very consistent pieces of data that go back and forth to your server. Something, for example, like HTTPHeaders. But I digress, take a look at the custom interactions section for this. As far as setting up parameters for a JSON Post, take a look at:
```
public var parameters : [String:AnyObject]?
public var httpMethod : HTTPMethod
```
Set that to normal Foundation objects and the method to .Post, and you are set to go. This will autoJsonSerialize those for you and put them in the postbody of the request. As viewed in the NSJSONSerialization Class Docs:

> An object that may be converted to JSON must have the following properties:
> - The top level object is an NSArray or NSDictionary.
> - All objects are instances of NSString, NSNumber, NSArray, NSDictionary, or NSNull.
> - All dictionary keys are instances of NSString.
> - Numbers are not NaN or infinity.

Next up is the `ServerResponse` object.
```
public class ServerResponse
```
Two key things here, which is that this object contains an optional `error`. In your completion block, be sure to check for that. Next is the concept of the generic results.
```
public func results() -> AnyObject
```
The generic implementation already tries to deserialize JSON from the server and give this to you here in a dictionary. To take a look at this, simple call in your closure: 
```
response.results()
```
This will get you to the JSON you are looking for. That's it really. You may want to do some checking here, using a `let ... as? __something__`, but that's up to you.

### Custom(subclassing) Server Interactions
Good, you decided you want to make this even better for your custom application. As mentioned above, your first step will be to subclass `ServerRequest`. This will let you do more customization for things that need to happen every time you talk to your own server. Perhaps sending user credentials, for example. 

You may also want to do some custom parsing, and not just get a basic `AnyObject` back. This is handled in the `ServerRequest` as well, most notably:
```
public var parsingClosure : ((data: NSData?, error: NSError?) -> ServerResponse)
```
This closure is what is executed on your custom `ServerRequest` subclass. Go ahead and write your own if you'd like. Just be sure to handle errors and return the correct response object. Most notable if you are also subclassing the `ServerResponse` object ;)

With that said, notice how in `ServerResponse` you can actually override the following function:
```
// remember this?
public override func results() -> AnyObject
```
Now you can do all sorts of interesting things and keep your APIClient looking consistent and clean.

## Basic Example 1
```
// Sample server call
let url = NSURL(string: "http://example.com")
let request = ServerRequest(url: url)
ServerClient.performRequest(request, completion: { (response) -> Void in
    if let err = response.error {
        // handle error
    } else { 
        // something interesting with response.results()
    }
})
```
## Basic Example 2 (Some paramaters)
```
// Sample server call with parameters
let url = NSURL(string: "http://example.com")
let request = ServerRequest(url: url)
request.httpMethod = .Post
request.parameters = ["colour":"orange"]
ServerClient.performRequest(request, completion: { (response) -> Void in
    if let err = response.error {
        // handle error
    } else { 
        // something interesting with response.results()
    }
})
```

Reminder, the `performRequest(...)` call does indeed return an NSOperation. You can feel free to keep track of that, or just disregard it.

## Discussion
What advantage does this kit have over, say, Alamofire or even just the generic calls in NSURLConnection? 

Well, behind the scenes this handles the networking requests a bit differently then Alamofire, for example, and is a thin layer using NSOperation and NSOperationQueue on top of the basic NSURLConnection handling in Foundation. So customizing and subclassing should, based on this author's interpretation, be easier and more intuitive. If you take a look at the examples above, I hope your mind immediately leaps out with a conclusion like 'oh I really want to subclass `ServerRequest` to remove some of that boilerplate, since obviously I'll be hitting similar URLs that are not example.com' And then you have then understood the point of the framework, which giving the quick customizablility at an obvious override point. Similarly, in contradiction to Alamofire, there is no need to create a `Manager` object. You can configure something like Timeout directly on each requests, OR you can set a global timeout for all requests that aren't otherwise set with the simple: `ServerClient.urlTimeout = TIMEOUT_INTERVAL_FOR_REQUEST`.

Does this framework attempt to replace Alamofire?

No, Alamofire has a ton of other server interaction functionality and cool stuff. If you have read and identified some of those features that you really want in Alamofire, use that. Or, I imagine it may be a fairly small change to include some additional features in BladeKit, and you can submit a pull request if you'd like. But as it stands, the kit is a lot less bulky and full-featured by design. And of course, BladeKit also includes other helpful materials as well, such as subscripting and string manipulation code that you may find useful, and eventually more customizable UI code as well.

## Todo's

- What more cool stuff should go into it
- Other stuff?

