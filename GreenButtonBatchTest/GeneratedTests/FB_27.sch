<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed/atom:entry/atom:content[espi:ElectricPowerUsageSummary | espi:UsageSummary]/child::*">
     <sch:rule context="/atom:feed/atom:entry/atom:content[espi:ElectricPowerUsageSummary | espi:UsageSummary]/child::*">
         <sch:assert test="espi:currentDayOverallConsumption/espi:powerOfTenMultiplier" diagnostics="for future use">
             D106|ElectricPowerUsageSummary currentDayOverallConsumption|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="espi:currentDayOverallConsumption/espi:powerOfTenMultiplier and espi:currentDayOverallConsumption/espi:uom" diagnostics="for future use">
             D111|currentDayOverallConsumption SummaryMeasurement|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="espi:peakDemand" diagnostics="for future use">
             D105|ElectricPowerUsageSummary peakDemand|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="espi:peakDemand/espi:powerOfTenMultiplier and espi:peakDemand/espi:uom" diagnostics="for future use">
             D110|peakDemand SummaryMeasurement|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="espi:previousDayOverallConsumption/espi:powerOfTenMultiplier" diagnostics="for future use">
             D107|ElectricPowerUsageSummary previousDayOverallConsumption|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="espi:previousDayOverallConsumption/espi:powerOfTenMultiplier and espi:previousDayOverallConsumption/espi:uom" diagnostics="for future use">
             D112|previousDayOverallConsumptionSummaryMeasurement|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="espi:ratchetDemand" diagnostics="for future use">
             D103|ElectricPowerUsageSummary ratchetDemand|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="espi:ratchetDemand/espi:powerOfTenMultiplier and espi:ratchetDemand/espi:uom" diagnostics="for future use">
             D108|ratchetDemand SummaryMeasurement|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="espi:ratchetDemandPeriod" diagnostics="for future use">
             D104|ElectricPowerUsageSummary ratchetDemandPeriod|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="espi:ratchetDemandPeriod/espi:duration and espi:ratchetDemandPeriod/espi:start" diagnostics="for future use">
             D109|ratchetDemandPeriod  DateTimeInterval|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
