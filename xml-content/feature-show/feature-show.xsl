<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template match="feature">
        <html>
            <head>
                <title>Solar Array Foundation</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.9.3/css/bulma.min.css"/>
            </head>
            <body>

                <section class="section">
                    <div class="container">
                        <h1 class="title">Feature Show</h1>
                        <small>
                            <a class="button is-small" href="index.xml">Home</a>
                        </small>

                        <div class="content">
                            <p class="subtitle">
                                <i>Let's access some data</i>
                            </p>

                            <div>
                                <h2 class="is-size-4">Our energy plants:</h2>
                                
                                <xsl:apply-templates select="document('../solar-database/database.xml')/solarEnergyData/provider">
                                </xsl:apply-templates>
                            
                            </div>
                        </div>
                    </div>
                </section>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="provider">
        <div>
            <h2><xsl:value-of select="name"/></h2>
            <svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="400" height="240" viewBox="0 0 1000 600">

                <xsl:variable name="maxVolume" select="1000"/>
                <xsl:variable name="maxHeight" select="400"/>
                <xsl:variable name="scalingFactor" select="$maxHeight div $maxVolume"/>


                <rect width="100%" height="100%" fill="white" />
                <line x1="50" y1="550" x2="950" y2="550" stroke="black" stroke-width="2"/>
                <line x1="50" y1="550" x2="50" y2="50" stroke="black" stroke-width="2"/>
                <text x="500" y="580" font-family="Arial" font-size="12" text-anchor="middle">Date</text>
                <text x="20" y="300" font-family="Arial" font-size="12" transform="rotate(270 20,300)">Volume</text>

                <!-- Define the graph's axes -->
                <line x1="50" y1="550" x2="950" y2="550" stroke="black" stroke-width="2"/>
                <line x1="50" y1="550" x2="50" y2="50" stroke="black" stroke-width="2"/>

                <!-- Hardcoded Y-axis labels and tick marks -->
                <text x="40" y="550" font-family="Arial" font-size="12" text-anchor="end">0</text>
                <line x1="45" y1="550" x2="55" y2="550" stroke="black" stroke-width="1"/>

                <text x="40" y="450" font-family="Arial" font-size="12" text-anchor="end">250</text>
                <line x1="45" y1="450" x2="55" y2="450" stroke="black" stroke-width="1"/>

                <text x="40" y="350" font-family="Arial" font-size="12" text-anchor="end">500</text>
                <line x1="45" y1="350" x2="55" y2="350" stroke="black" stroke-width="1"/>

                <text x="40" y="250" font-family="Arial" font-size="12" text-anchor="end">750</text>
                <line x1="45" y1="250" x2="55" y2="250" stroke="black" stroke-width="1"/>

                <text x="40" y="150" font-family="Arial" font-size="12" text-anchor="end">1000</text>
                <line x1="45" y1="150" x2="55" y2="150" stroke="black" stroke-width="1"/>

                <!-- X and Y axis labels -->
                <text x="500" y="580" font-family="Arial" font-size="12" text-anchor="middle">Date</text>
                <text x="20" y="300" font-family="Arial" font-size="12" transform="rotate(270 20,300)">Volume</text>

                <xsl:for-each select="productionData/productionEntry">
                    <xsl:sort select="@date" order="ascending"/>
                    <xsl:variable name="xPos" select="position() * 150 + 50"/>
                    <text x="{$xPos}" y="570" font-family="Arial" font-size="12" text-anchor="middle">
                        <xsl:value-of select="@date"/>
                    </text>
                </xsl:for-each>

                <xsl:for-each select="productionData/productionEntry">
                    <xsl:sort select="@date" order="ascending"/>    
                    <xsl:variable name="x" select="position() * 150 + 50"/>
                    <xsl:variable name="y" select="550 - (@volume * $scalingFactor)"/>
                    <circle cx="{$x}" cy="{$y}" r="5" fill="red"/>
                    <xsl:if test="position() > 1">
                        <xsl:variable name="prevVolume" select="preceding-sibling::productionEntry[1]/@volume"/>
                        <xsl:variable name="prevY" select="550 - ($prevVolume * $scalingFactor)"/>
                        <line x1="{$x - 150}" y1="{$prevY}" x2="{$x}" y2="{$y}" stroke="blue" stroke-width="2"/>
                    </xsl:if>
                </xsl:for-each>
            </svg>
        </div>
    </xsl:template>
</xsl:stylesheet>
