<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/">
     <sch:rule context="/">
         <sch:assert test="atom:feed" diagnostics="for future use">
             D000|feed|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed">
     <sch:rule context="/atom:feed">
         <sch:assert test="atom:entry[*/espi:LocalTimeParameters]" diagnostics="for future use">
             D136|LocalTimeParameters|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:entry[*/espi:UsagePoint]" diagnostics="for future use">
             D006|UsagePoint|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:id" diagnostics="for future use">
             D001|feed id|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:title" diagnostics="for future use">
             D002|feed title|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:updated" diagnostics="for future use">
             D003|feed updated|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry">
     <sch:rule context="/atom:feed/atom:entry">
         <sch:assert test="count(/atom:feed/atom:entry[atom:id = current()/atom:id])>0" diagnostics="for future use">
             D004|entry id's (URNs)|verify the uniqueness
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:LocalTimeParameters]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:LocalTimeParameters]">
         <sch:assert test="atom:id" diagnostics="for future use">
             D138|LocalTimeParameters id|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='self']/@href" diagnostics="for future use">
             D139|LocalTimeParameters self link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='up']/@href" diagnostics="for future use">
             D140|LocalTimeParameters up link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:published" diagnostics="for future use">
             D141|LocalTimeParameters published|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:title" diagnostics="for future use">
             D137|LocalTimeParameters title|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:updated" diagnostics="for future use">
             D142|LocalTimeParameters updated|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:LocalTimeParameters]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" diagnostics="for future use">
             D143|LocalTimeParameters self link|verify that link is unique
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:UsagePoint]/atom:link[@rel='related' and @href=current()/atom:link[@rel='self']/@href])>0" diagnostics="for future use">
             D135|LocalTimeParameters self link|verify that each LocalTimeParameter points to at least one UsagePoint
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:UsagePoint]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:UsagePoint]">
         <sch:assert test="atom:content/espi:UsagePoint/espi:ServiceCategory/espi:kind" diagnostics="for future use">
             D008|UsagePoint ServiceCategory|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:UsagePoint]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:UsagePoint]">
         <sch:assert test="atom:id" diagnostics="for future use">
             D011|UsagePoint id|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='related']/@href" diagnostics="for future use">
             D016|UsagePoint related MeterReadingList|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='self']/@href" diagnostics="for future use">
             D013|UsagePoint self link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='up']/@href" diagnostics="for future use">
             D015|UsagePoint up link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:published" diagnostics="for future use">
             D009|UsagePoint published|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:title" diagnostics="for future use">
             D012|UsagePoint title|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:updated" diagnostics="for future use">
             D010|UsagePoint updated|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:LocalTimeParameters]/atom:link[@rel='self' and @href=current()/atom:link[@rel='related']/@href])=1" diagnostics="for future use">
             D007|UsagePoint related LocalTimeParameters|verify that UsagePoint points to at most one LocalTimeParameters
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:UsagePoint]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" diagnostics="for future use">
             D014|UsagePoint self link|verify that link is unique
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
