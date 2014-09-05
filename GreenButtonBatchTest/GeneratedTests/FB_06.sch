<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed">
     <sch:rule context="/atom:feed">
         <sch:assert test="count(atom:entry[*/espi:ReadingType[espi:accumulationBehaviour=12 and espi:commodity=1 and espi:flowDirection=1 and espi:kind=12 and espi:uom=61]])>0" diagnostics="for future use">
             D072|ReadingType|verify the presence of VA demand readings
         </sch:assert>
         <sch:assert test="count(atom:entry[*/espi:ReadingType[espi:accumulationBehaviour=12 and espi:commodity=1 and espi:flowDirection=1 and espi:kind=12 and espi:uom=63]])>0" diagnostics="for future use">
             D073|ReadingType|verify the presence of VAR demand readings
         </sch:assert>
         <sch:assert test="count(atom:entry[*/espi:ReadingType[espi:accumulationBehaviour=12 and espi:commodity=1 and espi:flowDirection=1 and espi:kind=37 and espi:uom=38]])>0" diagnostics="for future use">
             D071|ReadingType|verify the presence of W demand readings
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
