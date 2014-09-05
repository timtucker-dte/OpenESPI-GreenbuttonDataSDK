<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ElectricPowerUsageSummary]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ElectricPowerUsageSummary]">
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:currentDayOverallConsumption/espi:powerOfTenMultiplier" diagnostics="for future use">
             D106|ElectricPowerUsageSummary currentDayOverallConsumption|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:currentDayOverallConsumption/espi:powerOfTenMultiplier and atom:content/espi:ElectricPowerUsageSummary/espi:currentDayOverallConsumption/espi:uom" diagnostics="for future use">
             D111|currentDayOverallConsumption SummaryMeasurement|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:peakDemand" diagnostics="for future use">
             D105|ElectricPowerUsageSummary peakDemand|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:peakDemand/espi:powerOfTenMultiplier and atom:content/espi:ElectricPowerUsageSummary/espi:peakDemand/espi:uom" diagnostics="for future use">
             D110|peakDemand SummaryMeasurement|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:previousDayOverallConsumption/espi:powerOfTenMultiplier" diagnostics="for future use">
             D107|ElectricPowerUsageSummary previousDayOverallConsumption|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:previousDayOverallConsumption/espi:powerOfTenMultiplier and atom:content/espi:ElectricPowerUsageSummary/espi:previousDayOverallConsumption/espi:uom" diagnostics="for future use">
             D112|previousDayOverallConsumptionSummaryMeasurement|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:ratchetDemand" diagnostics="for future use">
             D103|ElectricPowerUsageSummary ratchetDemand|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:ratchetDemand/espi:powerOfTenMultiplier and atom:content/espi:ElectricPowerUsageSummary/espi:ratchetDemand/espi:uom" diagnostics="for future use">
             D108|ratchetDemand SummaryMeasurement|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:ratchetDemandPeriod" diagnostics="for future use">
             D104|ElectricPowerUsageSummary ratchetDemandPeriod|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:ratchetDemandPeriod/espi:duration and atom:content/espi:ElectricPowerUsageSummary/espi:ratchetDemandPeriod/espi:start" diagnostics="for future use">
             D109|ratchetDemandPeriod  DateTimeInterval|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
