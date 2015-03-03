Attribute VB_Name = "TestGeneration"

Dim iLastColumn
Dim iLastRow

Private Sub ClearSorts()

    On Error GoTo NextStep
    ActiveWorkbook.Worksheets("GreenButtonTestCases").AutoFilter.Sort.SortFields.Clear
    If (ActiveWorkbook.Worksheets("GreenButtonTestCases").AutoFilterMode = True) Then
        ActiveWorkbook.Worksheets("GreenButtonTestCases").AutoFilterMode = False
    End If
   
NextStep:
    
End Sub

Function FindLastColumn()

    Dim LastColumn As Long

    If WorksheetFunction.CountA(Cells) > 0 Then

        'Search for any entry, by searching backwards by Rows.

        LastColumn = Cells.Find(What:="*", After:=[A1], SearchOrder:=xlByColumns, SearchDirection:=xlPrevious).Column

        FindLastColumn = LastColumn

    End If

End Function
Function FindLastRow()

    Dim LastRow As Long

    If WorksheetFunction.CountA(Cells) > 0 Then

        'Search for any entry, by searching backwards by Rows.

        LastRow = Cells.Find(What:="*", After:=[A1], SearchOrder:=xlByRows, SearchDirection:=xlPrevious).Row

        FindLastRow = LastRow

    End If

End Function

Private Sub CompleteSorts()

    strColTestIDLtr = Trim(ConvertToLetter(LookupColumnNo("Test ID")))
    
    Cells.Select
    ActiveSheet.ShowAllData

    strRange1 = "$A$1:" + Trim(ConvertToLetter(Str(iLastColumn))) + "$" + Trim(Str(iLastRow))
    strRange2 = strColTestIDLtr + "1:" + strColTestIDLtr + Trim(Str(iLastRow))
    
    ActiveWorkbook.Worksheets("GreenButtonTestCases").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("GreenButtonTestCases").AutoFilter.Sort.SortFields.Add Key:=Range( _
        strRange2), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("GreenButtonTestCases").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    


End Sub

Private Sub SetupSorts()

    strColTestStepsLtr = Trim(ConvertToLetter(LookupColumnNo("Test Steps")))
    strColFunctionBlkLtr = Trim(ConvertToLetter(LookupColumnNo("Function Block")))
            
    iColIncludeTest = Val(LookupColumnNo("Category"))
    iLastRow = FindLastRow()
    iLastColumn = FindLastColumn()
    
    strRange1 = "$A$2:" + Trim(ConvertToLetter(Str(iLastColumn))) + "$" + Trim(Str(iLastRow))
    strRange2 = strColTestStepsLtr + "2:" + strColTestStepsLtr + Trim(Str(iLastRow))
    strRange3 = strColFunctionBlkLtr + "2:" + strColFunctionBlkLtr + Trim(Str(iLastRow))
    
    Cells.Select
    Selection.AutoFilter
    ActiveSheet.Range(strRange1).AutoFilter Field:=iColIncludeTest, Criteria1:="Data Element"
    
  
    ActiveWorkbook.Worksheets("GreenButtonTestCases").Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("GreenButtonTestCases").Sort.SortFields.Add Key:=Range(strRange3), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
    ActiveWorkbook.Worksheets("GreenButtonTestCases").Sort.SortFields.Add Key:=Range(strRange2), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
        
    With ActiveWorkbook.Worksheets("GreenButtonTestCases").Sort
        .SetRange Rows("2:" + Trim(Str(iLastRow)))
        .Header = xlGuess
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With

End Sub

Public Function LookupColumnNo(strName As String)

    For Each c In Worksheets("GreenButtonTestCases").Range("TestHeading").Columns
        
        DoEvents
        
        If Trim(c.Value2) = Trim(strName) Then
        
            LookupColumnNo = c.Column
            
            Exit Function
        
        End If
                
    Next c
    
    LookupColumnNo = -1
    
    MsgBox "Error: column name: '" + strName + "' not found. Cannot continue to execute"
    End
    
End Function


Function ConvertToLetter(iCol As Integer) As String
   Dim iAlpha As Integer
   Dim iRemainder As Integer
   iAlpha = Int(iCol / 27)
   iRemainder = iCol - (iAlpha * 26)
   If iAlpha > 0 Then
      ConvertToLetter = Chr(iAlpha + 64)
   End If
   If iRemainder > 0 Then
      ConvertToLetter = ConvertToLetter & Chr(iRemainder + 64)
   End If
End Function


Function testDir(targetpath As String) As Boolean
    testDir = False
     
    If Dir(targetpath, vbDirectory) = "" Then
        testDir = False
    Else
        testDir = True
    End If
          
End Function


Sub GenerateTests()
            
    Dim strContext As String
    Dim strTest As String
    Dim strResult As String
    Dim targetpath As String
    Dim strTestID As String
    Dim strTestName As String
    Dim strTestReq As String
    
    targetpath = ActiveWorkbook.Path + "\GeneratedTests"
    
    Sheets("GreenButtonTestCases").Select

    If testDir(targetpath) = True Then
    Else
        MkDir targetpath
    End If
    
    targetpath = ActiveWorkbook.Path + "\TestResults"
    
    If testDir(targetpath) = True Then
    Else
        MkDir targetpath
    End If
    
    targetpath = ActiveWorkbook.Path + "\GenBadData"
    
    If testDir(targetpath) = True Then
    Else
        MkDir targetpath
    End If
    
            
    strColTestReq = LookupColumnNo("Test Purpose / Requirement")
    strColTestID = LookupColumnNo("Test ID")
    strColFunctionBlk = LookupColumnNo("Function Block")
    strColTestName = LookupColumnNo("Test Name")
    strColFnBlock = LookupColumnNo("Function Block")
    strColTestSteps = LookupColumnNo("Test Steps")
    strColDataFileName = LookupColumnNo("Example Test Input") '  : sample good file
    strColFailureCriteria = LookupColumnNo("Failure Criteria")
    
    ClearSorts
    SetupSorts
       
    ' script used to generate .xsl files from .sch files
    Open ActiveWorkbook.Path + "\GenTests.cmd" For Output As #2
    ' script used to run the tests
    Open ActiveWorkbook.Path + "\RunTests.cmd" For Output As #3
     ' script to generate all test data files
    Open ActiveWorkbook.Path + "\GenBadData.cmd" For Output As #5
     ' generate summary results strating file
    Open ActiveWorkbook.Path + "\Results_BAD_SummaryTemplate.xml" For Output As #6
    EmitSummaryHeader
    
    strCurrFunctionBlk = ""
    strCurrContext = ""
    bSCHFileOpen = False
    bDoEndRule = False
     
    With ActiveWorkbook.Worksheets("GreenButtonTestCases")
    
        cnt = .AutoFilter.Range.Rows.Count
    
        On Error GoTo NoTests
        Set Rng = .AutoFilter.Range.Offset(1, 0).Resize(.AutoFilter.Range.Rows.Count - 1, .AutoFilter.Range.Columns.Count - 1).SpecialCells(xlCellTypeVisible)
    
        For Each c In Rng.Rows
         
            DoEvents
              
            strFunctionBlk = Trim(c.Cells(1, strColFunctionBlk).Value2)
            strTestID = Trim(c.Cells(1, strColTestID).Value2)
            strTestName = Trim(c.Cells(1, strColTestName).Value2)
            strTestReq = Trim(c.Cells(1, strColTestReq).Value2)
            strFailureCriteria = Trim(c.Cells(1, strColFailureCriteria).Value2)
            strTestSteps = Trim(c.Cells(1, strColTestSteps).Value2)
            strLines = Split(strTestSteps, vbLf)
            strDataFileName = Trim(c.Cells(1, strColDataFileName).Value2)
            strBadDataFileName = Left(strDataFileName, InStr(strDataFileName, ".xml") - 1) + "_" + strTestID + "_BAD.xml"
            strResult = strTestID + "|" + strTestName + "|" + strTestReq
                        
            strContext = ""
            strTest = ""
            
            If Left(strLines(0), Len("CONTEXT:")) = "CONTEXT:" Then
                strContext = Mid(strLines(0), Len("CONTEXT:") + 1)
            End If
            
            If Left(strLines(1), Len("TEST:")) = "TEST:" Then
                strTest = Mid(strLines(1), Len("TEST:") + 1)
            End If
            
            EmitSummaryTest strTestID, strTestName, strTestReq
            
            If strFunctionBlk <> strCurrFunctionBlk Then
                
                ' starting new fn block
                strCurrContext = ""
                
                If bSCHFileOpen Then
                
                    If bDoEndRule Then
                        EmitRuleEnd
                        bDoEndRule = False
                    End If
                
                    EmitSCHTail
                    Close #1
                End If
                
                ' schmeatron .sch file
                Open ActiveWorkbook.Path + "\GeneratedTests\" + strFunctionBlk + ".sch" For Output As #1
                EmitSCHHeader
                
                strCurrFunctionBlk = strFunctionBlk
                bSCHFileOpen = True
            
                ' script used to generate .xsl files from .sch files
                Print #2, "msxsl .\GeneratedTests\" + strFunctionBlk + ".sch XMLschematron-report.xsl diagnose=yes -v -o .\GeneratedTests\" + strFunctionBlk + ".xsl"
            
            End If

            ' schmeatron .sch file
            If strCurrContext <> strContext Then
                ' new context
                If bDoEndRule Then
                    EmitRuleEnd
                End If
                
                EmitRuleStart (strContext)
                bDoEndRule = True
                strCurrContext = strContext
            
            End If
           
            EmitAssertion strTest, strResult
            
            ' generate test data file
            Open ActiveWorkbook.Path + "\GenBadData\Gen_" + strTestID + "_BAD.xsl" For Output As #4
            
            GenBadDataHeader
            
            If Left(strFailureCriteria, Len("Duplicate:")) = "Duplicate:" Then
                strData = Mid(strFailureCriteria, Len("Duplicate:") + 1)
                GenBadDataDuplicate (strData)
            End If
            If Left(strFailureCriteria, Len("Duplicate2:")) = "Duplicate2:" Then
                strData = Mid(strFailureCriteria, Len("Duplicate2:") + 1)
                GenBadDataDuplicate2 (strData)
            End If
            If Left(strFailureCriteria, Len("BreakUplink:")) = "BreakUplink:" Then
                strData = Mid(strFailureCriteria, Len("BreakUplink:") + 1)
                GenBadDataBreakUplink (strData)
            End If
            If Left(strFailureCriteria, Len("RemoveEntry:")) = "RemoveEntry:" Then
                strData = Mid(strFailureCriteria, Len("RemoveEntry:") + 1)
                GenBadDataRemoveEntry (strData)
            End If

            GenBadDataTail
            
            Close #4
            
            ' script to generate all test data files
            Print #5, "msxsl .\TestData\" + strDataFileName + " .\GenBadData\Gen_" + strTestID + "_BAD.xsl -v -o .\TestData\" + strBadDataFileName
            
            ' script used to run the tests
            Print #3, "msxsl .\TestData\" + strDataFileName + " .\GeneratedTests\" + strFunctionBlk + ".xsl -v -o .\TestResults\" + strFunctionBlk + "_" + strTestID + "_GOOD.xml"
            Print #3, "msxsl .\TestData\" + strBadDataFileName + " .\GeneratedTests\" + strFunctionBlk + ".xsl -v -o .\TestResults\" + strFunctionBlk + "_" + strTestID + "_BAD.xml"
         
        Next c
        
    End With
    
    If bDoEndRule Then
        EmitRuleEnd
    End If
                

    
    GoTo Complete
    
NoTests:

    MsgBox "No tests to generate."

Complete:
    
    If bSCHFileOpen Then
        EmitSCHTail
        Close #1
    End If
    
    Close #2
    Close #3
    Close #5
    
    EmitSummaryTail
    Close #6
    
    ' complete and restore filters
    CompleteSorts
    

    
End Sub

Private Sub EmitSCHHeader()
    Print #1, "<?xml version=""1.0""?>"
    Print #1, "<sch:schema xmlns:sch=""http://purl.oclc.org/dsdl/schematron"" xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" >"
    Print #1, "<sch:ns uri=""http://naesb.org/espi"" prefix=""espi""/>"
    Print #1, "<sch:ns uri=""http://www.w3.org/2005/Atom"" prefix=""atom""/>"
    'Print #1, "<sch:pattern name=""Green Button Download My Data"">"
End Sub


Private Sub EmitSCHTail()
    'Print #1, "</sch:pattern>"
    Print #1, "</sch:schema>"
End Sub

Private Sub EmitRuleStart(strContext As String)
    Print #1, "<sch:pattern name=""" + Trim(strContext) + """>"
    Print #1, "     <sch:rule context=""" + Trim(strContext) + """>"
End Sub

Private Sub EmitRuleEnd()
    Print #1, "     </sch:rule>"
    Print #1, "</sch:pattern>"
End Sub

Private Sub EmitAssertion(strTest As String, strResult As String)
    Print #1, "         <sch:assert test=""" + Trim(strTest) + """ diagnostics=""for future use"">"
    Print #1, "             " + Trim(strResult)
    Print #1, "         </sch:assert>"
End Sub

Private Sub GenBadDataHeader()
    Print #4, "<?xml version=""1.0"" encoding=""UTF-8""?>"
    Print #4, "<xsl:stylesheet version=""1.0"" xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" xmlns:fo=""http://www.w3.org/1999/XSL/Format"" xmlns:espi=""http://naesb.org/espi"" xmlns:atom=""http://www.w3.org/2005/Atom"">"
    Print #4, "    <xsl:output method=""xml"" version=""1.0"" encoding=""UTF-8"" indent=""yes""/>"
    Print #4, "    <xsl:template match=""node() | @*"">"
    Print #4, "        <xsl:copy>"
    Print #4, "            <xsl:apply-templates select=""@* | node()""/>"
    Print #4, "        </xsl:copy>"
    Print #4, "    </xsl:template>"
End Sub

Private Sub GenBadDataTail()
    Print #4, "</xsl:stylesheet>"
End Sub

Private Sub GenBadDataDuplicate(strMatch As String)
    Print #4, "    <xsl:template match=""atom:feed/atom:entry[atom:content/" + strMatch + "]"">"
    Print #4, "        <xsl:element name=""{local-name(.)}"" namespace=""{namespace-uri(..)}"">"
    Print #4, "            <xsl:apply-templates select=""@* | node()""/>"
    Print #4, "        </xsl:element>"
    Print #4, "        <xsl:element name=""{local-name(.)}"" namespace=""{namespace-uri(..)}"">"
    Print #4, "            <xsl:apply-templates select=""@* | node()""/>"
    Print #4, "        </xsl:element>"
    Print #4, "    </xsl:template>"
End Sub

Private Sub GenBadDataDuplicate2(strMatch As String)
    Print #4, "    <xsl:template match=""" + strMatch + """>"
    Print #4, "        <xsl:element name=""{local-name(.)}"" namespace=""{namespace-uri(..)}"">"
    Print #4, "            <xsl:apply-templates select=""@* | node()""/>"
    Print #4, "        </xsl:element>"
    Print #4, "        <xsl:element name=""{local-name(.)}"" namespace=""{namespace-uri(..)}"">"
    Print #4, "            <xsl:apply-templates select=""@* | node()""/>"
    Print #4, "        </xsl:element>"
    Print #4, "    </xsl:template>"
End Sub

Private Sub GenBadDataBreakUplink(strMatch As String)
    Print #4, "    <xsl:template match=""atom:link[@rel='up' and ancestor::atom:entry/atom:content/espi:" + strMatch + "]"">"
    Print #4, "        <xsl:element name=""link"" namespace=""{namespace-uri(..)}"">"
    Print #4, "            <xsl:attribute name=""rel""><xsl:text>up</xsl:text></xsl:attribute>"
    Print #4, "            <xsl:attribute name=""href""><xsl:text>DUMMY</xsl:text></xsl:attribute>"
    Print #4, "        </xsl:element>"
    Print #4, "    </xsl:template>"
End Sub

Private Sub GenBadDataRemoveEntry(strMatch As String)
    Print #4, "    <xsl:template match=""" + strMatch + """>"
    Print #4, "    </xsl:template>"
End Sub

Private Sub EmitSummaryHeader()
    Print #6, "<?xml version=""1.0"" encoding=""UTF-8""?>"
    Print #6, "<anElement xmlns:sch=""http://www.ascc.net/xml/schematron"" xmlns:iso=""http://purl.oclc.org/dsdl/schematron"" xmlns:espi=""http://naesb.org/espi"" xmlns:atom=""http://www.w3.org/2005/Atom"">"
    Print #6, "<pattern name=""""/>"
End Sub

Private Sub EmitSummaryTest(strTestID As String, strTestName As String, strTestReq As String)
    Print #6, "<assert TestID=""" + strTestID + """>"
    Print #6, "     <TestName>" + strTestName + "</TestName>"
    Print #6, "     <Report>" + strTestReq + "</Report>"
    Print #6, "         <Occurances>"
    Print #6, "            <Occurance>NONE</Occurance>"
    Print #6, "         </Occurances>"
    Print #6, "    </assert>"
End Sub


Private Sub EmitSummaryTail()
    Print #6, "</anElement>"
End Sub


