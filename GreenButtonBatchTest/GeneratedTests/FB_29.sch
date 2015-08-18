<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed">
     <sch:rule context="/atom:feed">
         <sch:assert test="count(atom:entry[*/espi:ReadingType[espi:kind=46 and espi:uom=6]])>0" diagnostics="for future use">
             D147|ReadingType|verify the presence of temperature (Kelvin) readings
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
