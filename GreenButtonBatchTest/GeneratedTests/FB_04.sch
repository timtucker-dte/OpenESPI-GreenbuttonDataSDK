<?xml version="1.0"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<sch:ns uri="http://naesb.org/espi" prefix="espi"/>
<sch:ns uri="http://www.w3.org/2005/Atom" prefix="atom"/>
<sch:pattern name="/atom:feed">
     <sch:rule context="/atom:feed">
         <sch:assert test="atom:entry[*/espi:IntervalBlock]" diagnostics="for future use">
             D032|IntervalBlock|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:entry[*/espi:MeterReading]" diagnostics="for future use">
             D027|MeterReading|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:entry[*/espi:ReadingType]" diagnostics="for future use">
             D049|ReadingType|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:IntervalBlock]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:IntervalBlock]">
         <sch:assert test="atom:content/espi:IntervalBlock/espi:interval/espi:start" diagnostics="for future use">
             D039|IntervalBlock interval start|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:IntervalBlock/espi:interval/espi:start=atom:content/espi:IntervalBlock/espi:IntervalReading/espi:timePeriod/espi:start" diagnostics="for future use">
             D042|first interval in block|verify that first interval in block start time matches the start time of the block
         </sch:assert>
         <sch:assert test="atom:content/espi:IntervalBlock/espi:IntervalReading/espi:timePeriod/espi:duration" diagnostics="for future use">
             D044|IntervalReading timePeriod duration|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:IntervalBlock/espi:IntervalReading/espi:timePeriod/espi:start" diagnostics="for future use">
             D045|IntervalReading timePeriod start|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:IntervalBlock/espi:IntervalReading/espi:value" diagnostics="for future use">
             D046|IntervalReading value|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:IntervalBlock]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:IntervalBlock]">
         <sch:assert test="atom:content/espi:IntervalBlock/espi:interval/espi:duration" diagnostics="for future use">
             D038|IntervalBlock interval duration|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:id" diagnostics="for future use">
             D031|IntervalBlock id|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='self']/@href" diagnostics="for future use">
             D034|IntervalBlock self link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='up']/@href" diagnostics="for future use">
             D036|IntervalBlock up link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:published" diagnostics="for future use">
             D040|IntervalBlock published|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:title" diagnostics="for future use">
             D033|IntervalBlock title|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:updated" diagnostics="for future use">
             D041|IntervalBlock updated|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:IntervalBlock]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" diagnostics="for future use">
             D035|IntervalBlock self link unique|verify that link is unique
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:MeterReading]/atom:link[@rel='related' and @href=current()/atom:link[@rel='up']/@href])=1" diagnostics="for future use">
             D037|IntervalBlock up link|verify that each IntervalBlock points to a single MeterReading
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:MeterReading]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:MeterReading]">
         <sch:assert test="atom:content/espi:MeterReading" diagnostics="for future use">
             D028|MeterReading (this test row is temporary for testing)|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:MeterReading]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:MeterReading]">
         <sch:assert test="atom:id" diagnostics="for future use">
             D018|MeterReading id|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='self']/@href" diagnostics="for future use">
             D020|MeterReading self link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='up']/@href" diagnostics="for future use">
             D022|MeterReading up link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:published" diagnostics="for future use">
             D029|MeterReading published|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:title" diagnostics="for future use">
             D019|MeterReading title|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:updated" diagnostics="for future use">
             D030|MeterReading updated|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="count (/atom:feed/atom:entry/atom:content/espi:IntervalBlock[../../atom:link[@rel='up']/@href = current()/atom:link[@rel='related']/@href]/espi:IntervalReading[espi:timePeriod/espi:start = preceding-sibling::espi:IntervalReading/espi:timePeriod/espi:start])=0" diagnostics="for future use">
             D145|MeterReading Interval Block/Interval Readings/ are all unique (by start time)|verify the presence of unique values
         </sch:assert>
         <sch:assert test="count (/atom:feed/atom:entry[atom:link[@rel='up']/@href = current()/atom:link[@rel='related']/@href]/atom:content/espi:IntervalBlock/espi:interval/espi:start[ . = preceding::espi:IntervalBlock[../../atom:link[@rel='up']/@href = current()/atom:link[@rel='related']/@href]/espi:interval/espi:start])=0" diagnostics="for future use">
             D146|MeterReading Interval Blocks are all unique (by start time)|verify the presence of unique values
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:IntervalBlock]/atom:link[@rel='up' and @href=current()/atom:link[@rel='related']/@href])>0" diagnostics="for future use">
             D025|MeterReading related (IntervalBlockList)|verify that each MeterReading has associated metering data
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:MeterReading]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" diagnostics="for future use">
             D021|MeterReading self link|verify that link is unique
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:ReadingType]/atom:link[@rel='self' and @href=current()/atom:link[@rel='related']/@href])=1" diagnostics="for future use">
             D024|MeterReading related (ReadingType)|verify that each MeterReading has one and only one associated ReadingType
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:UsagePoint]/atom:link[@rel='related' and @href=current()/atom:link[@rel='up']/@href])=1" diagnostics="for future use">
             D023|Meter reading up link|verify correct up link
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ReadingType[espi:accumulationBehaviour=4]]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ReadingType[espi:accumulationBehaviour=4]]">
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:IntervalBlock]/atom:link[@rel = 'up' and @href = /atom:feed/atom:entry[*/espi:MeterReading][atom:link[@rel='related' and @href = current()/atom:link[@rel='self']/@href]]/atom:link[@rel='related']/@href])>0" diagnostics="for future use">
             D026|MeterReading|verify that "load profile" meter readings (accumulationBehavour=4) have any associated interval blocks
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ReadingType]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ReadingType]">
         <sch:assert test="atom:content/espi:ReadingType/espi:intervalLength" diagnostics="for future use">
             D062|ReadingType intervalLength|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ReadingType/espi:kind" diagnostics="for future use">
             D063|ReadingType kind|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ReadingType/espi:powerOfTenMultiplier" diagnostics="for future use">
             D065|ReadingType powerOfTenMultiplier|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:content/espi:ReadingType/espi:uom" diagnostics="for future use">
             D068|ReadingType uom|verify the presence of a valid value
         </sch:assert>
     </sch:rule>
</sch:pattern>
<sch:pattern name="/atom:feed/atom:entry[*/espi:ReadingType]">
     <sch:rule context="/atom:feed/atom:entry[*/espi:ReadingType]">
         <sch:assert test="atom:id" diagnostics="for future use">
             D048|ReadingType id|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='self']" diagnostics="for future use">
             D051|ReadingType self link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:link[@rel='up']" diagnostics="for future use">
             D053|ReadingType up link|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:published" diagnostics="for future use">
             D069|ReadingType published|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:title" diagnostics="for future use">
             D050|ReadingType title|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="atom:updated" diagnostics="for future use">
             D070|ReadingType updated|verify the presence of a valid value
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:MeterReading]/atom:link[@rel='related' and @href=current()/atom:link[@rel='self']/@href])>0" diagnostics="for future use">
             D054|ReadingType up link|verify that each ReadingType points to at least one MeterReading
         </sch:assert>
         <sch:assert test="count(/atom:feed/atom:entry[*/espi:ReadingType]/atom:link[@rel='self' and @href=current()/atom:link[@rel='self']/@href])=1" diagnostics="for future use">
             D052|ReadingType self link|verify that link is unique
         </sch:assert>
     </sch:rule>
</sch:pattern>
</sch:schema>
