<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed">
     <sch:rule context="/atom:feed">
         <sch:assert test="/atom:feed/atom:entry[*/espi:MeterReading]/atom:link[@rel='related' and @href=/atom:feed/atom:entry[*/espi:ReadingType[espi:accumulationBehaviour=4 and espi:commodity=9 and espi:flowDirection=1 and espi:kind=12 and espi:uom=128]]/atom:link[@rel='self']/@href]/../atom:link[@rel='up']/@href=/atom:feed/atom:entry/atom:content/espi:UsagePoint[espi:ServiceCategory/espi:kind=2]/../../atom:link[@rel='related']/@href" diagnostics="for future use">
             D080|ReadingType|verify the presence of water (USG) readings
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
