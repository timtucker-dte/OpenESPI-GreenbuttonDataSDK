<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed">
     <sch:rule context="/atom:feed">
         <sch:assert test="atom:entry[*/espi:ElectricPowerUsageSummary]" diagnostics="for future use">
             D083|ElectricPowerUsageSummary|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ElectricPowerUsageSummary/espi:currentBillingPeriodOverAllConsumption]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ElectricPowerUsageSummary/espi:currentBillingPeriodOverAllConsumption]">
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:currentBillingPeriodOverAllConsumption/espi:powerOfTenMultiplier" diagnostics="for future use">
             D095|ElectricPowerUsageSummary currentBillingPeriodOverAllConsumption powerOfTenMultiplier|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:currentBillingPeriodOverAllConsumption/espi:timeStamp" diagnostics="for future use">
             D096|ElectricPowerUsageSummary currentBillingPeriodOverAllConsumption timeStamp|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:currentBillingPeriodOverAllConsumption/espi:uom" diagnostics="for future use">
             D097|ElectricPowerUsageSummary currentBillingPeriodOverAllConsumption uom|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:currentBillingPeriodOverAllConsumption/espi:value" diagnostics="for future use">
             D098|ElectricPowerUsageSummary currentBillingPeriodOverAllConsumption value|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ElectricPowerUsageSummary]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ElectricPowerUsageSummary]">
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:billingPeriod/espi:duration" diagnostics="for future use">
             D089|ElectricPowerUsageSummary billingPeriod duration|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:billingPeriod/espi:start" diagnostics="for future use">
             D090|ElectricPowerUsageSummary billingPeriod start|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:overallConsumptionLastPeriod" diagnostics="for future use">
             D081|ElectricPowerUsageSummary overallConsumptionLastPeriod|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:qualityOfReading" diagnostics="for future use">
             D099|ElectricPowerUsageSummary qualityOfReading|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ElectricPowerUsageSummary/espi:statusTimeStamp" diagnostics="for future use">
             D100|ElectricPowerUsageSummary statusTimeStamp|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ElectricPowerUsageSummary]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ElectricPowerUsageSummary]">
         <sch:assert test="atom:id" diagnostics="for future use">
             D082|ElectricPowerUsageSummary id|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='self']/@href" diagnostics="for future use">
             D085|ElectricPowerUsageSummary self link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='up']/@href" diagnostics="for future use">
             D087|ElectricPowerUsageSummary up link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:published" diagnostics="for future use">
             D101|ElectricPowerUsageSummary published|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:title" diagnostics="for future use">
             D084|ElectricPowerUsageSummary title|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:updated" diagnostics="for future use">
             D102|ElectricPowerUsageSummary updated|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:ElectricPowerUsageSummary]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" diagnostics="for future use">
             D086|ElectricPowerUsageSummary self link|verify that link is unique
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:UsagePoint]/atom:link[@rel='related' and @href=current()/atom:link[@rel='up']/@href])=1" diagnostics="for future use">
             D088|ElectricPowerUsageSummary up link|verify that each ElectricPowerUsageSummary points to a single UsagePoint
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
