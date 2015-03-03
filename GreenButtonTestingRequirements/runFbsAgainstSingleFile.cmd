@echo off
rem ===========================================================================
rem	Green Button File Tester
rem Author: Ron Pasquarelli, Marty Burns Hypertek for NIST
rem Version: 20140111
rem ===========================================================================
@echo =========================================================================
@echo **** Start Green Button File Composition Test (Version: 20131001)
@echo Date: %DATE% %TIME% 
if "%1"=="" (
@echo "Usage: runFbsAgainstSingleFile <filename> <function blocks>"
@echo Example: runFbsAgainstSingleFile gbtest.xml "01,04,05"
goto :EOF )

set TestFile=%1
@echo Test File=%TestFile%
set Scope=%2
set Scope=%Scope:~1,-1%
@echo Scope = %Scope%
@echo =========================================================================
@echo =========================================================================
if NOT EXIST .\OnDemandResults (
mkdir .\OnDemandResults
)
del /Q .\OnDemandResults\*.*

call :parse "%Scope%"

if  EXIST .\TestResults\Results.xml (
del /Q .\TestResults\Results.xml
)
copy Results_GOOD_SummaryTemplate.xml .\OnDemandResults\Results.xml

FOR %%A IN (.\OnDemandResults\*.xml) DO (
    REM ECHO Pattern matched
    REM ECHO Name in 8.3 notation : %%~snA
    ECHO --- Processing : %%~fA
	
	msxsl .\OnDemandResults\Results.xml MergeResults.xsl FileName=%%~fA > .\OnDemandResults\Results_TEMP.xml
	if EXIST .\OnDemandResults\Results.xml (
	del .\OnDemandResults\Results.xml
	)
	move .\OnDemandResults\Results_TEMP.xml .\OnDemandResults\Results.xml
)

msxsl .\OnDemandResults\Results.xml PresentResults.xsl > .\OnDemandResults\Results.html

@echo =========================================================================
@echo **** End Green Button File Composition Test
@echo Date: %DATE% %TIME% 
@echo =========================================================================
@echo =========================================================================

goto :end

:parse
setlocal
set list=%1
set list=%list:"=%
FOR /f "tokens=1* delims=," %%a IN ("%list%") DO (
  if not "%%a" == "" call :sub %%a %TestFile%
  if not "%%b" == "" call :parse "%%b"
)
endlocal
exit /b

:sub
setlocal
@echo =========================================================================
echo Performing analysis for FB%1 on file %2
@echo =========================================================================
msxsl %2 .\GeneratedTests\FB_%1.xsl -v -o .\OnDemandResults\FB_%1_results.xml
@echo =========================================================================
endlocal
exit /b

:end
