<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ElectricPowerUsageSummary]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ElectricPowerUsageSummary]">
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:billToDate" diagnostics="for future use">
             D092|ElectricPowerUsageSummary billToDate|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
