<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed">
     <sch:rule context="/atom:feed">
         <sch:assert test="atom:entry[*/espi:ElectricPowerQualitySummary]" diagnostics="for future use">
             D126|ElectricPowerQualitySummary|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ElectricPowerQualitySummary]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ElectricPowerQualitySummary]">
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:flickerPlt" diagnostics="for future use">
             D113|ElectricPowerQualitySummary flickerPlt|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:flickerPst" diagnostics="for future use">
             D114|ElectricPowerQualitySummary flickerPst|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:harmonicVoltage" diagnostics="for future use">
             D115|ElectricPowerQualitySummary harmonicVoltage|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:longInterruptions" diagnostics="for future use">
             D116|ElectricPowerQualitySummary longInterruptions|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:mainsVoltage" diagnostics="for future use">
             D117|ElectricPowerQualitySummary mainsVoltage|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:powerFrequency" diagnostics="for future use">
             D118|ElectricPowerQualitySummary powerFrequency|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:rapidVoltageChanges" diagnostics="for future use">
             D119|ElectricPowerQualitySummary rapidVoltageChanges|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:shortInterruptions" diagnostics="for future use">
             D120|ElectricPowerQualitySummary shortInterruptions|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:summaryInterval" diagnostics="for future use">
             D121|ElectricPowerQualitySummary summaryInterval|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:summaryInterval/espi:duration and atom:content/espi:ElectricPowerQualitySummary/espi:summaryInterval/espi:start" diagnostics="for future use">
             D134|summaryInterval DateTimeInterval|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:supplyVoltageDips" diagnostics="for future use">
             D122|ElectricPowerQualitySummary supplyVoltageDips|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:supplyVoltageImbalance" diagnostics="for future use">
             D123|ElectricPowerQualitySummary supplyVoltageImbalance|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:supplyVoltageVariations" diagnostics="for future use">
             D124|ElectricPowerQualitySummary supplyVoltageVariations|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerQualitySummary/espi:tempOvervoltage" diagnostics="for future use">
             D125|ElectricPowerQualitySummary tempOvervoltage|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ElectricPowerQualitySummary]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ElectricPowerQualitySummary]">
         <sch:assert test="atom:id" diagnostics="for future use">
             D128|ElectricPowerQualitySummary id|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='self']/@href" diagnostics="for future use">
             D129|ElectricPowerQualitySummary self link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='up']/@href" diagnostics="for future use">
             D130|ElectricPowerQualitySummary up link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:published" diagnostics="for future use">
             D131|ElectricPowerQualitySummary published|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:title" diagnostics="for future use">
             D127|ElectricPowerQualitySummary title|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:updated" diagnostics="for future use">
             D132|ElectricPowerQualitySummary updated|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:ElectricPowerQualitySummary]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" diagnostics="for future use">
             D133|ElectricPowerQualitySummary self link|verify that link is unique
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
