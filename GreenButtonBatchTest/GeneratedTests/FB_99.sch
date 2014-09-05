<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed/atom:entry[*/espi:IntervalBlock]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:IntervalBlock]">
         <sch:assert test="atom:content/espi:IntervalBlock/espi:IntervalReading/espi:ReadingQuality/espi:quality" diagnostics="for future use">
             D047|IntervalReading ReadingQuality|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ReadingType]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ReadingType]">
         <sch:assert test="atom:content/espi:ReadingType/espi:consumptionTier" diagnostics="for future use">
             D057|ReadingType consumptionTier|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ReadingType/espi:dataQualifier" diagnostics="for future use">
             D059|ReadingType dataQualifier|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ReadingType/espi:defaultQuality" diagnostics="for future use">
             D060|ReadingType defaultQuality|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ReadingType/espi:timeAttribute" diagnostics="for future use">
             D066|ReadingType timeAttribute|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ReadingType/espi:tou" diagnostics="for future use">
             D067|ReadingType tou|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:UsagePoint]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:UsagePoint]">
         <sch:assert test="atom:content/espi:UsagePoint/espi:roleFlags" diagnostics="for future use">
             D017|UsagePoint roleFlags|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:UsagePoint/espi:status" diagnostics="for future use">
             D005|UsagePoint status|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
