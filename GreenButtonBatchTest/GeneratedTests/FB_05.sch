<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed">
     <sch:rule context="/atom:feed">
         <sch:assert test="count(atom:entry[*/espi:ReadingType[espi:accumulationBehaviour=4 and espi:commodity=1 and espi:flowDirection=1 and espi:kind=12 and espi:uom=72]])>0" diagnostics="for future use">
             D078|ReadingType|verify the presence of 'Wh integrated over an interval' readings
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ReadingType]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ReadingType]">
         <sch:assert test="atom:content/espi:ReadingType/espi:phase" diagnostics="for future use">
             D064|ReadingType phase|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
