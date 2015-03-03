OpenESPI-GreenbuttonDataSDK/GreenButtonTestingRequirements
===========================

This package contains the following:

1. GreenButtonTestCases.xslm
2. A series of batch files
3. A series of xslts
4. A folder with test data


The GreenButtonTestCases.xlsm file contains the test cases for Green Button DMD and CMD as devised the UCAIug [OpenADE Task force](http://osgug.ucaiug.org/sgsystems/OpenADE/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2fsgsystems%2fOpenADE%2fShared%20Documents%2fTesting%20and%20Certification%2fGreenButtonTestPlan&FolderCTID=&View={60F72F59-7B0F-4BA0-985C-D253868CFCEF} "OpenADE Task Force") Each row in the spreadsheet contains a separate test case for use in testing.

Additionally, the xslm file contains macros used to generate the test schematron files for each function block which analyzes Green Button files for their data content.

The batch files in this package along with the test files generate the xslts that can be used to verify the contents of Green Button data. Additionally, this test suite supports a self-regression test by running against test good and bad data according to the corresponding test vectors described in the individual test cases.