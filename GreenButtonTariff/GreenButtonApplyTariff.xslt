<?xml version="1.0" encoding="UTF-8"?>
<!--
==========================================================================
 Stylesheet: GreenButtonApplyTariff.xslt
    Version: 0.7 20120720
     Author: Ron Pasquarelli, Marty Burns (Hypertek for EnerNex)
     Notice: This is draft prototype developed for SGIP by the Administrator Technical Team (EnerNex)
========================================================================== 
Copyright (c) 2011, 2012 EnergyOS.Org
 
Licensed by EnergyOS.Org under one or more contributor license agreements.
 
See the NOTICE file distributed with this work for additional information regarding copyright ownership.  The EnergyOS.org licenses this file to you under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.  You may obtain a copy of the License at:
    http://www.apache.org/licenses/LICENSE-2.0
  
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and limitations under the License.

-->
<!--<?altova_samplexml file:///D:/_project/Enernex/Source/GreenButtonTariff/data/2Month_Coastal_Multi_Family_Jan_1_2011_to_Mar_1_2011.xml?>-->
<?altova_samplexml file:///D:/_project/Enernex/Source/GreenButtonTariff/data/1hrLP_32DaysNoCostTEST_FIXED_TARIFF.xml?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:espi="http://naesb.org/espi" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="atom espi xsi" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:user="http://mycompany.com/mynamespace">

<!--
==========================================================================
JavaScript code for interval cost computations
========================================================================== 
-->
<msxsl:script language="JavaScript" implements-prefix="user"><![CDATA[
//////////////////////////////////////////////////////////////////////////////
// Global variables used during JavaScript processing
//////////////////////////////////////////////////////////////////////////////

	var gl_strError;
	var gl_strLog;
	
	var gl_BillToDate = 0;
	var gl_billLastPeriod = 0;
	var gl_costAdditionalLastPeriod = 0;
	var gl_Currency = 0
	
    var gl_strBillingPeriod = "monthly";	
	var gl_billingPeriodDuration;
	var gl_billingPeriodStart;
	
	var gl_currMonth = -1;
	var gl_CurrPerTotValue = 0;
	
	var gl_powerOfTenMultiplierForMeterData = 0;
	
	var gl_timeTariffInterval = [];
	
//////////////////////////////////////////////////////////////////////////////
// simple get functions
//////////////////////////////////////////////////////////////////////////////	
	function GetLogStr(){return gl_strLog;}
	function GetBillToDate(){return parseInt(gl_BillToDate * 100000);}
	function GetBillLastPeriod(){return parseInt(gl_billLastPeriod * 100000);}	
	function GetCurrency(){return gl_Currency;}		
	
//////////////////////////////////////////////////////////////////////////////
// Initialize billing info variables. This is called by xslt for 
// each instance of UsagePoint/summary info
//////////////////////////////////////////////////////////////////////////////		
	function InitializeBillingInformation(billingPeriodDuration,billingPeriodStart,billingPeriodTimeStamp,statusTimeStamp)
	{
		gl_billingPeriodDuration = billingPeriodDuration;
		gl_billingPeriodStart = billingPeriodStart;
		
		gl_currMonth = -1;
		gl_CurrPerTotValue = 0;
		gl_BillToDate = 0;
		gl_billLastPeriod = 0;
		gl_costAdditionalLastPeriod = 0;
	
		return 1;
	}
	
//////////////////////////////////////////////////////////////////////////////
// Initialize billing info variables. This is called by xslt for 
// each instance of UsagePoint/reading type info
//////////////////////////////////////////////////////////////////////////////		
	function InitializeReadingTypeInformation(powerOfTenMultiplier)
	{
		gl_powerOfTenMultiplierForMeterData = powerOfTenMultiplier;
	
		return "success";
	}	

//////////////////////////////////////////////////////////////////////////////
// Called for each interval ... this is where accumations and 
// conversions are applied
//////////////////////////////////////////////////////////////////////////////		
	function ProcessIntervalReading(start,duration,value)
	{
		var cost = "Error - could not compute cost";
		
		// JS Date object requires time in milliseconds but ESPI uses seconds. Convert here.
		var d1 = new Date(start * 1000);
		
		// Extract hours, minutes and seconds as tariff tiers are specified as time's not date/times
		var Time1 =  (d1.getUTCHours() * 60 * 60) + (d1.getUTCMinutes() * 60) + d1.getUTCSeconds(); // convert start dateTime to just hours mins secs in secs.

		gl_strLog= "d1=" + d1 + " Time1=" + Time1;
		
		// apply reading type power of ten multiplier to this interval value
		value = value * Math.pow(10 , gl_powerOfTenMultiplierForMeterData);
		
		// for now we only handle "montly" billing periods
		// if we need to this is where other durations would be processed
		
		if (gl_strBillingPeriod == "monthly")
		{
			if (gl_currMonth != d1.getUTCMonth())
			{
				gl_CurrPerTotValue = 0;		
				gl_currMonth = d1.getUTCMonth();		
			}
		}
		else
		{
			gl_strLog = "Error: unknown billing period";
			return "Error: unknown billing period";
		}	
		
		// accumulate total for the billing period currently being processed
		gl_CurrPerTotValue = gl_CurrPerTotValue + value;
			
		// Find tariff tier that applies to this interval value	
		for(var i = 0; i< gl_timeTariffInterval.length;i++)
		{
			var intvlStart = gl_timeTariffInterval[i].interval.start;
			var intvlEnd = gl_timeTariffInterval[(i+1)%gl_timeTariffInterval.length].interval.start ;
			
			if( intvlStart > intvlEnd )		
			{
				// handle case where wrap occured
				if( (Time1 >= intvlStart ) || (Time1< intvlEnd))
				{
					gl_strLog = gl_strLog + " MATCH 1 start:" + intvlStart + " end:" + intvlEnd  + " desc: " + gl_timeTariffInterval[i].description;
					break;
				}
			}
			else
			{
				if( (Time1 >= intvlStart ) && (Time1< intvlEnd))
				{
					gl_strLog = gl_strLog + " MATCH 2  start:" + intvlStart + " end:" + intvlEnd + " desc: " + gl_timeTariffInterval[i].description;
					break;
				}					
			}
		}

		// loop counter i contains the applicable tarrif tier.
		if( i < gl_timeTariffInterval.length )
		{
			// found match
			for(var j = gl_timeTariffInterval[i].consumptionTariffIntervals.length - 1; j > -1  ; j--)
			{
				// find tariff block that applies to current interval
				if(gl_CurrPerTotValue >= gl_timeTariffInterval[i].consumptionTariffIntervals[j].startValue)
				{
					// apply price to this interval value
					cost = value * gl_timeTariffInterval[i].consumptionTariffIntervals[j].price;
					
					gl_strLog = gl_strLog + " block = " + gl_timeTariffInterval[i].consumptionTariffIntervals[j].consumptionBlock + " price= " + gl_timeTariffInterval[i].consumptionTariffIntervals[j].price + " Cost = " + cost;
			
					// now we 'bin' the accumlated cost according to which billing period we are processing
					
					if (start < gl_billingPeriodStart)
					{
						// data prior to previous billing period
						// no need to store totals
						gl_strLog = gl_strLog + " old billing period";
					}
					else if ((start >= gl_billingPeriodStart) && (start < (gl_billingPeriodStart + gl_billingPeriodDuration)))
					{
						// data in previous billing period
						gl_billLastPeriod = gl_billLastPeriod + cost;
						gl_strLog = gl_strLog + " previous billing period";
					}
					else
					{
						// data must be current billing period
						gl_BillToDate = gl_BillToDate + cost;
						gl_strLog = gl_strLog + " current billing period";
					}			
					break;
				}
			}
		}
		else
		{
			gl_strLog = "No match " + i  + gl_strLog;
		}			

		// scale to fixed ESPI cost units
		cost = parseInt(cost * 100000); 
		
		return cost;
	}
	
//////////////////////////////////////////////////////////////////////////////
// get active x object for DOM and load file
//////////////////////////////////////////////////////////////////////////////		
	function LoadDOM(file)
	{
		var dom = null;
		try 
		{
			dom = MakeDOM(null);
			if(dom==null)
			{
				return null;
			}
			dom.load(file);
		}
		catch (e) 
		{
			gl_strError = gl_strError + e.description;
			return null;
		}
		return dom;
	}

//////////////////////////////////////////////////////////////////////////////
// get active x object for DOM
//////////////////////////////////////////////////////////////////////////////	
	function MakeDOM(progID)
	{
		if (progID == null)
		{
			progID = "msxml2.DOMDocument.6.0";
		}
	
		var dom = null;
		
		try 
		{
			dom = new ActiveXObject(progID);
			dom.setProperty("ResolveExternals", true);  
			dom.async = false;
			dom.validateOnParse = false;
			dom.resolveExternals = true;
		}
		catch (e) 
		{
			gl_strError = gl_strError + e.description;
			return null;
		}
		
		return dom;
	}
	
//////////////////////////////////////////////////////////////////////////////
// Load tariff model xml data and initialize JS memory 
// structures
//////////////////////////////////////////////////////////////////////////////		
	function LoadTariff(XMLString)
	{
		gl_timeTariffInterval = [];
		gl_strError = "";

		var dom = LoadDOM(XMLString);

		try 
		{
			if(dom==null)
			{
				gl_strLog = "Error: could not load tariff:" + gl_strError;
				return 0;
			}
			
			var ns = "xmlns:sep='http://zigbee.org/sep'";
			dom.setProperty("SelectionNamespaces", ns);
			
			// retreive currency
			gl_Currency = dom.selectSingleNode("//sep:TariffProfile/sep:currency").nodeTypedValue;
			
			// retreive price PoTM 
			
			var pricePowerOfTenMultiplier = dom.selectSingleNode("//sep:TariffProfile/sep:pricePowerOfTenMultiplier").nodeTypedValue;
			
			// retreive block PoTM
			var powerOfTenMultiplier = dom.selectSingleNode("//sep:TariffProfile/sep:rateComponent/sep:readingType/sep:powerOfTenMultiplier").nodeTypedValue;

			// find rate component / tariff intervals	
			var oNodes = dom.selectNodes("//sep:TariffProfile/sep:rateComponent/sep:timeTariffInterval"); 
			
			if(oNodes == null)
			{
				gl_strLog = "Error: tariff contains no matching nodes: " + gl_strError;;
				return 0; 			
			}
			
			gl_strLog = "Filename: " + XMLString;
			gl_strLog = gl_strLog + "Num nodes: " + oNodes.length;
			gl_strLog = gl_strLog + " pricePoTM=" + pricePowerOfTenMultiplier + "PoTM=" + powerOfTenMultiplier;

			var oNodeA;
			
			// iterate through rate component / tariff intervals
			for (var i=0; i<oNodes.length; i++)
			{
				var oNode = oNodes[i];
				oNodeA = oNode.selectSingleNode("sep:interval/sep:start");
				
				var d1 = new Date(oNode.selectSingleNode("sep:interval/sep:start").nodeTypedValue * 1000);
							
				var interval = {
					start: (d1.getUTCHours() * 60 * 60) + (d1.getUTCMinutes() * 60) + d1.getUTCSeconds(), // convert start dateTime to just hours mins secs in secs.
					duration: oNode.selectSingleNode("sep:interval/sep:duration").nodeTypedValue
				};
				
				var timeTariffInterval = {
					description : oNode.selectSingleNode("sep:description").nodeTypedValue,
					touTier: oNode.selectSingleNode("sep:touTier").nodeTypedValue,
					interval: interval,
					consumptionTariffIntervals:[]
				};
				
				var oNodesConsTarIntvls = oNode.selectNodes("sep:consumptionTariffInterval"); 
				
				for (var j=0; j<oNodesConsTarIntvls.length; j++)
				{				
					var price = parseFloat(oNodesConsTarIntvls[j].selectSingleNode("sep:price").nodeTypedValue) * Math.pow(10, pricePowerOfTenMultiplier);
					var startValue  = parseFloat(oNodesConsTarIntvls[j].selectSingleNode("sep:startValue").nodeTypedValue) * Math.pow(10 , powerOfTenMultiplier);
					
					gl_strLog = gl_strLog + "\r" + "price= " +price+ " startval= " + startValue + "\r";
									
					var consumptionTariffInterval = {
						consumptionBlock:oNodesConsTarIntvls[j].selectSingleNode("sep:consumptionBlock").nodeTypedValue ,
						price: price,
						startValue: startValue
					};
					
					timeTariffInterval.consumptionTariffIntervals.push(consumptionTariffInterval);
				}	
				
				gl_timeTariffInterval.push(timeTariffInterval);			  
			} 
			
			for(var i = 0; i< gl_timeTariffInterval.length;i++)
			{
				gl_strLog = gl_strLog + " chk start:" + gl_timeTariffInterval[i].interval.start;
			}
			
			return 1;
		}
		catch (e)
		{
			gl_strLog = "Error: could not parse tariff: " + gl_strError + "Description: " + e.description;	
			return 0;
		}		
	
		gl_strLog = "Error: could not parse tariff: " + gl_strError;
		return 0;
	}	
	
	function TestWrapper()
	{
		var strResult = LoadTariff("");
	};
		
	]]></msxsl:script>
	
<!--
==========================================================================
 XSLT processing of ESPI data/ tariff file
========================================================================== 
-->	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:param name="pTariffFileName"/>
	
	<!-- if no tariff file name provided use default -->
	<xsl:variable name="TariffFileName">
		<xsl:choose>
			<xsl:when test="$pTariffFileName=''">
				<!-- default tariff file -->
				<xsl:text>D:/_project/Enernex/Source/GreenButtonTariff/TariffSample.xml</xsl:text>
				<!--<xsl:text>D:/_project/Enernex/Source/GreenButtonTariff/data/TariffSampleTEST_FIXED_TARIFF.xml</xsl:text>-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$pTariffFileName"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<!-- process nodes -->
	<xsl:template match="/">
		<xsl:text>&#13;</xsl:text>
		<xsl:text disable-output-escaping="yes">&lt;?xml-stylesheet type="text/xsl" href="GreenButtonDataStyleSheet.xslt"?&gt;</xsl:text>
		<xsl:text>&#13;</xsl:text>
		<xsl:copy-of select="comment()"/>
		<xsl:for-each select="atom:feed">
			<xsl:text>&#13;</xsl:text>
			<xsl:element name="feed" namespace="http://www.w3.org/2005/Atom">
				<!-- emit feed attributes -->
				<xsl:copy-of select="namespace::*"/>
				<xsl:copy-of select="@*"/>
				<xsl:copy-of select="atom:id"/>
				<xsl:copy-of select="atom:title"/>
				<xsl:copy-of select="atom:updated"/>
				<xsl:copy-of select="atom:link"/>
				<xsl:for-each select="atom:entry/atom:content/espi:UsagePoint">
					<xsl:variable name="UsagePointHref" select="ancestor::atom:entry/atom:link[@rel = 'self']/@href"/>
					<xsl:for-each select="/atom:feed/atom:entry/atom:content/espi:ElectricPowerUsageSummary[ancestor::atom:entry/atom:link[@rel ='up' and @href=$UsagePointHref]]">
						<xsl:call-template name="InitializeBillingInformation"/>
					</xsl:for-each>
					<!-- emit usage point -->
					<xsl:copy-of select="ancestor::atom:entry"/>
					<xsl:for-each select="/atom:feed/atom:entry/atom:content/espi:LocalTimeParameters[ancestor::atom:entry/atom:link[@rel ='up' and @href=$UsagePointHref]]">
						<!-- emit local time params -->
						<xsl:copy-of select="ancestor::atom:entry"/>
					</xsl:for-each>
					<xsl:for-each select="/atom:feed/atom:entry/atom:content/espi:MeterReading[ancestor::atom:entry/atom:link[@rel ='up' and @href=$UsagePointHref]]">
						<xsl:variable name="MeterReadingtHref" select="ancestor::atom:entry/atom:link[@rel = 'self']/@href"/>
						<!-- emit meter readings -->
						<xsl:copy-of select="ancestor::atom:entry"/>
						<xsl:for-each select="/atom:feed/atom:entry/atom:content/espi:ReadingType[ancestor::atom:entry/atom:link[@rel ='up' and @href=$MeterReadingtHref]]">
							<xsl:call-template name="InitializeReadingTypeInformation"/>
							<!-- emit reading type -->
							<xsl:copy-of select="ancestor::atom:entry"/>
						</xsl:for-each>
						<xsl:for-each select="/atom:feed/atom:entry[atom:content/espi:IntervalBlock[ancestor::atom:entry/atom:link[@rel ='up' and @href=$MeterReadingtHref]]]">
							<!-- emit interval blocks -->
							<xsl:element name="entry" namespace="http://www.w3.org/2005/Atom">
								<xsl:copy-of select="atom:id"/>
								<xsl:copy-of select="atom:link"/>
								<xsl:copy-of select="atom:title"/>
								<xsl:element name="content" namespace="http://www.w3.org/2005/Atom">
									<xsl:for-each select="atom:content/espi:IntervalBlock">
										<xsl:element name="IntervalBlock" namespace="http://naesb.org/espi">
											<xsl:copy-of select="espi:interval"/>
											<xsl:for-each select="espi:IntervalReading">
												<xsl:element name="IntervalReading" namespace="http://naesb.org/espi">
													<xsl:element name="cost" namespace="http://naesb.org/espi">
														<xsl:call-template name="CalculateIntervalReadingCost"/>
													</xsl:element>
													<xsl:copy-of select="espi:timePeriod"/>
													<xsl:copy-of select="espi:value"/>
												</xsl:element>
											</xsl:for-each>
										</xsl:element>
									</xsl:for-each>
								</xsl:element>
								<xsl:element name="published" namespace="http://www.w3.org/2005/Atom">1899-12-30T00:00:00Z</xsl:element>
								<!-- TBD -->
								<xsl:element name="updated" namespace="http://www.w3.org/2005/Atom">1899-12-30T00:00:00Z</xsl:element>
								<!-- TBD -->
							</xsl:element>
						</xsl:for-each>
					</xsl:for-each>
					<xsl:for-each select="/atom:feed/atom:entry/atom:content/espi:ElectricPowerUsageSummary[ancestor::atom:entry/atom:link[@rel ='up' and @href=$UsagePointHref]]">
						<!-- emit ElectricPowerUsageSummary -->
						<xsl:element name="entry" namespace="http://www.w3.org/2005/Atom">
							<xsl:copy-of select="atom:id"/>
							<xsl:copy-of select="atom:link"/>
							<xsl:copy-of select="atom:title"/>
							<xsl:element name="content" namespace="http://www.w3.org/2005/Atom">
								<xsl:element name="ElectricPowerUsageSummary" namespace="http://naesb.org/espi">
									<xsl:copy-of select="espi:billingPeriod"/>
									<xsl:element name="billLastPeriod" namespace="http://naesb.org/espi">
										<xsl:value-of select="user:GetBillLastPeriod()"/>
									</xsl:element>
									<xsl:element name="billToDate" namespace="http://naesb.org/espi">
										<xsl:value-of select="user:GetBillToDate()"/>
									</xsl:element>
									<xsl:element name="costAdditionalLastPeriod" namespace="http://naesb.org/espi">0</xsl:element>
									<xsl:element name="currency" namespace="http://naesb.org/espi">
										<xsl:value-of select="user:GetCurrency()"/>
									</xsl:element>
									<xsl:copy-of select="espi:currentBillingPeriodOverAllConsumption"/>
									<xsl:copy-of select="espi:qualityOfReading"/>
									<xsl:copy-of select="espi:statusTimeStamp"/>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	
<!--
==========================================================================
 Template: InitializeBillingInformation
========================================================================== 
-->
	<xsl:template name="InitializeBillingInformation">
		<xsl:variable name="billingPeriodDuration" select="espi:billingPeriod/espi:duration"/>
		<xsl:variable name="billingPeriodStart" select="espi:billingPeriod/espi:start"/>
		<xsl:variable name="billingPeriodTimeStamp" select="espi:currentBillingPeriodOverAllConsumption/espi:timeStamp"/>
		<xsl:variable name="statusTimeStamp" select="espi:statusTimeStamp"/>
		<xsl:variable name="Result1"><xsl:value-of select="user:InitializeBillingInformation(number($billingPeriodDuration),number($billingPeriodStart),number($billingPeriodTimeStamp),number($statusTimeStamp))"/></xsl:variable>
		<xsl:variable name="Result"><xsl:value-of select="user:LoadTariff(string($TariffFileName))"/></xsl:variable>
		<!-- see if failure occured loading tariff file and display log if error occurred -->
		<xsl:if test="$Result = 0 "><xsl:comment>OpenFileResults: <xsl:value-of select="user:GetLogStr()"/></xsl:comment></xsl:if>
	</xsl:template>
	
<!--
==========================================================================
 Template: InitializeReadingTypeInformation
========================================================================== 
-->	
	<xsl:template name="InitializeReadingTypeInformation">
		<xsl:variable name="powerOfTenMultiplier" select="espi:powerOfTenMultiplier"/>
		<xsl:comment>InitializeReadingTypeInformation results <xsl:value-of select="user:InitializeReadingTypeInformation(number($powerOfTenMultiplier))"/>
		</xsl:comment>
	</xsl:template>
	
<!--
==========================================================================
 Template: CalculateIntervalReadingCost
========================================================================== 
-->		
	<xsl:template name="CalculateIntervalReadingCost">
		<xsl:value-of select="user:ProcessIntervalReading(number(espi:timePeriod/espi:start),number(espi:timePeriod/espi:duration),number(espi:value))"/>
		<!--<xsl:comment><xsl:value-of select="user:GetLogStr()"/></xsl:comment><xsl:text>&#13;</xsl:text>-->
	</xsl:template>
</xsl:stylesheet>
