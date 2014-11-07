<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed/atom:entry/atom:content[espi:ElectricPowerUsageSummary | espi:UsageSummary]/child::*">
     <sch:rule context="/atom:feed/atom:entry/atom:content[espi:ElectricPowerUsageSummary | espi:UsageSummary]/child::*">
         <sch:assert test="espi:billLastPeriod" diagnostics="for future use">
             D091|ElectricPowerUsageSummary billLastPeriod|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="espi:costAdditionalLastPeriod" diagnostics="for future use">
             D093|ElectricPowerUsageSummary costAdditionalLastPeriod|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="espi:currency" diagnostics="for future use">
             D094|ElectricPowerUsageSummary currency|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
