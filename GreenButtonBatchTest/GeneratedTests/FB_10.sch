<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed">
     <sch:rule context="/atom:feed">
         <sch:assert test="/atom:feed/atom:entry[*/espi:MeterReading]/atom:link[@rel='related' and @href=/atom:feed/atom:entry[*/espi:ReadingType[espi:accumulationBehaviour=4 and espi:commodity=7 and espi:flowDirection=1 and espi:kind=12 and (espi:uom=31 or espi:uom=132 or espi:uom=169) or espi:kind=58 and (espi:uom=42 or espi:uom=119)]]/atom:link[@rel='self']/@href]/../atom:link[@rel='up']/@href=/atom:feed/atom:entry/atom:content/espi:UsagePoint[espi:ServiceCategory/espi:kind=1]/../../atom:link[@rel='related']/@href" diagnostics="for future use">
             D079|ReadingType|verify the presence of gas readings -- therms, joule, ft3, m3 or BTU
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
