<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet version="1.0" exclude-result-prefixes="atom" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"></xsl:output>
	<xsl:param name="FileName" select="'D:\_project\NIST\NISTGreenButton\Source\GreenButtonTestPlan\TestResults\TEST_D_D1_BAD.xml'"></xsl:param>
		<xsl:template match="/">
		<xsl:variable name="MainDocRoot" select="anElement"></xsl:variable>
		
	<xsl:element name="anElement">
			<xsl:for-each select="/anElement/assert">
					<xsl:sort select="@TestID"></xsl:sort>
				<!--<xsl:copy-of select="."/>-->
					<xsl:element name="assert">
						<xsl:attribute name="TestID"><xsl:value-of select="@TestID"></xsl:value-of></xsl:attribute> 
						
						<xsl:element name="role"><xsl:value-of select="role"></xsl:value-of></xsl:element>
						<xsl:element name="TestName"><xsl:value-of select="TestName"></xsl:value-of></xsl:element>
						<xsl:element name="Report"><xsl:value-of select="Report"></xsl:value-of></xsl:element>
						<xsl:element name="diagnostics"><xsl:value-of select="diagnostics"></xsl:value-of></xsl:element>
						
							
				<xsl:element name="Occurances">	
							
							
						<xsl:if test="document($FileName)/anElement/assert[@TestID = current()/@TestID]">
								<xsl:element name="Occurance">
									<xsl:value-of select="$FileName"></xsl:value-of>
								</xsl:element>
							</xsl:if><xsl:for-each select="Occurances/Occurance">
								
							<xsl:if test=". != 'NONE'">
									<xsl:element name="Occurance">
										<xsl:value-of select="."></xsl:value-of>
									</xsl:element>
								</xsl:if></xsl:for-each></xsl:element></xsl:element>
			</xsl:for-each>
			
		<xsl:for-each select="document($FileName)/anElement/assert">
				
			<xsl:if test="count($MainDocRoot/assert[@TestID = current()/@TestID])=0">
					<!--<xsl:copy-of select="current()"/>-->
					<xsl:element name="assert">
						<xsl:attribute name="TestID"><xsl:value-of select="@TestID"></xsl:value-of></xsl:attribute> 
						
						<xsl:element name="role"><xsl:value-of select="role"></xsl:value-of></xsl:element>
						<xsl:element name="TestName"><xsl:value-of select="TestName"></xsl:value-of></xsl:element>
						<xsl:element name="Report"><xsl:value-of select="Report"></xsl:value-of></xsl:element>
						<xsl:element name="diagnostics"><xsl:value-of select="diagnostics"></xsl:value-of></xsl:element>

						
					<xsl:element name="Occurances">
							<xsl:element name="Occurance">
								<xsl:value-of select="$FileName"></xsl:value-of>
							</xsl:element>
						</xsl:element></xsl:element>
				</xsl:if></xsl:for-each></xsl:element></xsl:template>
	
	
</xsl:stylesheet>