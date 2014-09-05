<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed/atom:entry[*/espi:IntervalBlock]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:IntervalBlock]">
         <sch:assert test="atom:content/espi:IntervalBlock/espi:IntervalReading/espi:cost" diagnostics="for future use">
             D043|IntervalReading cost|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ReadingType]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ReadingType]">
         <sch:assert test="atom:content/espi:ReadingType/espi:currency" diagnostics="for future use">
             D058|ReadingType currency|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
