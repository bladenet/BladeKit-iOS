# BladeKit

BladeKit is a friendly framework for speedier iOS development. It is written in Swift. Mostly.

- Easy to import
- Friendly
- Stuff

### Installation to a new project
Go ahead and change directories to something relevant in your iOS project. No, this doesn't mean the root directory. This means something like /<project>/frameworks. From the command line, type the following:
```
git submodule add git@github.com:bladenet/BladeKit-iOS.git
```
Reminder these means that when you clone originally, you must include the recursive option, but I'm sure you knew that already.

```
git clone --recursive
```
And of course to update the submodule, the basic
```
git submodule foreach git pull
```
After this, go ahead and drag the <project>.xcodeproj into the finder in your active Xcode project. Be sure to copy files as needed.

Your next step will be to include the BladeKit.Framework as a build dependency in your target settings. Hit the + Button, it should auto populate as XCode is now familiar with these files and this target.

After this, you will need to include:
```
import BladeKit
```
In any files in your project that reference the Kit



### Todo's

- More documentation on using it!
- What should go into it
- Other stuff?


