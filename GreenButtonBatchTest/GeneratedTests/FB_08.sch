<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed">
     <sch:rule context="/atom:feed">
         <sch:assert test="count(atom:entry[*/espi:ReadingType[espi:accumulationBehaviour=1 and espi:commodity=1 and espi:flowDirection=1 and espi:kind=12 and espi:uom=72]])>0" diagnostics="for future use">
             D075|ReadingType|verify the presence of Wh forward readings
         </sch:assert>
         <sch:assert test="count(atom:entry[*/espi:ReadingType[espi:accumulationBehaviour=1 and espi:commodity=1 and espi:flowDirection=19 and espi:kind=12 and espi:uom=72]])>0" diagnostics="for future use">
             D076|ReadingType|verify the presence of Wh reverse readings
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
