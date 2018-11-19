Green Button Data Batch Test
===========================

This folder contains tools to batch test Green Button data files. It supports upwards of several gigabyte data files containing many Usage Points.

### GeneratedTests Folder ###

The contents of the GeneratedTests folder are created using the **GreenButtonTestCases.xlsm** file contained in the **GreenButtonTestingRequirements** folder, by using the **GenTest.cmd** batch file.

The generated FB_xx.xsl files are then uploaded to the [http://dmdvalidator.greenbuttonalliance.org](http://dmdvalidator.greenbuttonalliance.org "Green Button DMD Validator") website.  However, the website requires no leading zeroes (i.e., "0") appear in the file names, but the Schematron generator appends zeroes to all single digit Function Block test.  This means once uploaded single digit FB test **MUST** be renamed.
