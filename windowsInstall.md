# Windows Install Tutorial
## Part 1: OpenCV
1. Download the OpenCV v3.1.0 Win Pack [[link](https://opencv.org/releases.html)].
2. Once downloaded, run the executable and extract the source, taking note of the destination.

## Part 2: Libtiff
1. Download the `tiff-4.0.9.zip` and unzip it, taking note of the destination [[link](https://download.osgeo.org/libtiff/)].
2. Download the Microsoft Visual C++ Build Tools [[link](http://go.microsoft.com/fwlink/?LinkId=691126)].
3. Run the executable to install the Build Tools software.
4. Run the `Visual C++ 2015 x64 Native Build Tools Command Prompt` executable from the MSVC Build Tools folder (default location is `C:\Program Files (x86)\Microsoft Visual C++ Build Tools`).
5. In the x64 Build Tools terminal, cd into your libtiff directory and run the commands:
`C:\...\tiff-4.0.9> nmake /f makefile.vc`
`C:\...\tiff-4.0.9> cd tools`
`C:\...\tiff-4.0.9\tools> nmake /f makefile.vc`

## Part 3: Qt
1. Download the Open Source version of the Qt installer [[link](https://www.qt.io/download)].
2. Once downloaded, run the executable. Either sign-up for an account or login with your current Qt account and continue through the various pages.
3. Once you arrive at the 'Select Components' page, click the 'Qt' drop-down as well as the 'Qt 5.11.0' drop-down. Under 'Qt 5.11.0' check off 'MSVC 2015 64-bit' and 'Sources'.
4. Accept the Terms of Service and begin the Qt install process.
5. Once Qt is installed, open up Qt Creator. Navigate to `File>Open File or Project...` and open your `LAUWebCalTag.pro` file.
6. Under the 'Projects' tab click on 'Manage Kits'.
7. Select 'Desktop Qt 5.11.0 MSVC2015 64bit'
8. Under 'Compiler:' set the 'C++:' drop-down to 'Microsoft Visual C++ Build Tools (x64)' and then hit 'Apply' at the bottom right.
9. Below the spot where you clicked 'Manage Kits...' there will be a section titled 'Build & Run'. Click 'Desktop Qt 5.11.0 MSVC2015 64bit' under this section. The play buttons and hammer in the lower left corner should be colorized after this.
10. Now, go to the 'Edit' tab, drop-down 'LAUWebCalTag' in the file explorer and double click LAUWebCalTag.pro. Scroll to the very bottom where `win32{...}` is. You will have to update the paths for where you installed OpenCV and Libtiff. For reference, mine looks like this:
```
win32 {
         INCLUDEPATH   += $$quote(C:\Users\Sam\Downloads\opencv\build\include)
         INCLUDEPATH   += $$quote(C:\Users\Sam\Downloads\tiff-4.0.9\libtiff)
         INCLUDEPATH   += $$quote(C:\usr\include)
         DEPENDPATH    += $$quote(C:\Users\Sam\Downloads\opencv\build\include)
         DEPENDPATH    += $$quote(C:\usr\include)
         LIBS          += -L$$quote(C:\usr\libs) -lopengl32
         LIBS          += -L$$quote(C:\Users\Sam\Downloads\libtiff) -llibtiff_i
         LIBS          += -L$$quote(C:\Users\Sam\Downloads\opencv\build\x64\vc14\lib)
         CONFIG(release, debug|release): LIBS += -lopencv_world310
         CONFIG(debug, debug|release):   LIBS += -lopencv_world310d
}
```
11. Now run 'Build'. Note: if you get build errors saying `#include "opencv2/core/core.hpp"` and `#include "libbtiff.h"` don't exist even after adding them to your `INCLUDEPATH`, try running `Build>Run qmake`

## Part 4: Linker Issues
##### Option 1 (Preferred)
Finally You do need to copy over any external DLLs that you may have included in your .pro file. After building the project, a 'debug' folder should appear in your build directory. Find the following files and paste them in your debug folder:

|Missing .dll Name|File Location|
|:---------------:|:-----------:|
|libtiff.dll|C:\\...\tiff-4.0\libtiff|
|opencv_world310.dll|C:\\...\opencv\build\x64\vc14\bin|
|opencv_world310d.dll|C:\\...\opencv\build\x64\vc14\bin|
##### Option 2
This option is for if you wish to run the executable as a standalone--outside of Qt. Open your debug folder in your File Explorer and run `LAUWebCalTag.exe`. You will get five errors such as "The code executation cannot proceed because libtiff.dll was not found. Reinstalling the program may fix this problem". These are the first five missing .dll's that the program can't find. You are going to have to find where these .dll's exist and copy them into the same directory as `LAUWebCalTag.exe`--the debug directory. Below is a table of what I was missing and where I found them. It may be different for you. Also be sure to verify that the .dll is the correct architecture (x64).

|Missing .dll Name|File Location|
|:---------------:|:-----------:|
|libtiff.dll|C:\\...\tiff-4.0\libtiff|
|opencv_world310d.dll|C:\\...\opencv\build\x64\vc14\bin|
|Qt5Cored.dll|C:\Qt\5.11.0\mscv2015_64\bin|
|Qt5Guid.dll|C:\Qt\5.11.0\mscv2015_64\bin|
|Qt5Multimediad.dll|C:\Qt\5.11.0\mscv2015_64\bin|
|Qt5Widgetsd.dll|C:\Qt\5.11.0\mscv2015_64\bin|
|Qt5Networkdd.dll|C:\Qt\5.11.0\mscv2015_64\bin|
|ucrtbased.dll|C:\Program Files (x86)\Windows Kits\10\bin\x64\ucrt|

After adding the .dll's, the executable in your debug folder should launch successfully.
