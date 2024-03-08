<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template match="feature">
        <html>
            <head>
                <title>Solar Array Foundation</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.9.3/css/bulma.min.css"/>
                <style>
                    .box.has-shadow {
                        box-shadow: 0 2px 3px rgba(10, 10, 10, 0.1), 0 0 0 1px rgba(10, 10, 10, 0.1);
                        position: relative;
                        padding-top: 50px;
                    }

                    .vertical-fade-separator {
                        background: linear-gradient(to bottom, rgba(255, 255, 255, 0) 0%, rgba(10, 10, 10, 0.15) 50%, rgba(255, 255, 255, 0) 100%);
                        position: absolute;
                        top: 0;
                        bottom: 0;
                        right: 50%;
                        width: 1px;
                        height: 100%;
                    }
                </style>
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
        <div class="box has-shadow">
            <h2 class="title is-4"><xsl:value-of select="name"/></h2>
            <div class="columns">
                <div class="column is-half">
                    <xsl:call-template name="graph">
                        <xsl:with-param name="entries" select="productionData/productionEntry"/>
                    </xsl:call-template>
                </div>
                <div class="column is-half">
                    <div class="vertical-fade-separator"></div>
                    <xsl:call-template name="table">
                        <xsl:with-param name="entries" select="productionData/productionEntry"/>
                    </xsl:call-template>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="table">
        <table border="1">
            <tr>
              <th>Date</th>
              <th>Volume</th>
            </tr>
            <xsl:for-each select="productionData/productionEntry">
              <tr>
                <td><xsl:value-of select="@date"/></td>
                <td><xsl:value-of select="@volume"/></td>
              </tr>
            </xsl:for-each>
          </table>
    </xsl:template>

    <xsl:template name="graph">
        <svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="400" height="240" viewBox="0 0 1000 600">
            <xsl:variable name="maxVolume" select="1000"/>
            <xsl:variable name="maxHeight" select="400"/>
            <xsl:variable name="scalingFactor" select="$maxHeight div $maxVolume"/>
            
            <rect width="100%" height="100%" fill="white" />
            <line x1="100" y1="550" x2="1000" y2="550" stroke="black" stroke-width="2"/>
            <line x1="100" y1="550" x2="100" y2="50" stroke="black" stroke-width="2"/>
            
            <text x="550" y="580" font-family="Arial" font-size="24" text-anchor="middle">Date</text>
            <text x="20" y="260" font-family="Arial" font-size="24" transform="rotate(270 70,300)">Volume</text>
            
            <text x="90" y="550" font-family="Arial" font-size="24" text-anchor="end">0</text>
            <line x1="95" y1="550" x2="105" y2="550" stroke="black" stroke-width="1"/>
            
            <text x="90" y="450" font-family="Arial" font-size="24" text-anchor="end">250</text>
            <line x1="95" y1="450" x2="105" y2="450" stroke="black" stroke-width="1"/>
            
            <text x="90" y="350" font-family="Arial" font-size="24" text-anchor="end">500</text>
            <line x1="95" y1="350" x2="105" y2="350" stroke="black" stroke-width="1"/>
            
            <text x="90" y="250" font-family="Arial" font-size="24" text-anchor="end">750</text>
            <line x1="95" y1="250" x2="105" y2="250" stroke="black" stroke-width="1"/>
            
            <text x="90" y="150" font-family="Arial" font-size="24" text-anchor="end">1000</text>
            <line x1="95" y1="150" x2="105" y2="150" stroke="black" stroke-width="1"/>
            
            <xsl:for-each select="productionData/productionEntry">
                <xsl:sort select="@date" order="ascending"/>
                <xsl:variable name="xPos" select="position() * 150 + 100"/> 
                <text x="{$xPos}" y="570" font-family="Arial" font-size="24" text-anchor="middle">
                    <xsl:value-of select="@date"/>
                </text>
            </xsl:for-each>
            
            <xsl:for-each select="productionData/productionEntry">
                <xsl:sort select="@date" order="ascending"/>    
                <xsl:variable name="x" select="position() * 150 + 100"/> 
                <xsl:variable name="y" select="550 - (@volume * $scalingFactor)"/>
                <circle cx="{$x}" cy="{$y}" r="5" fill="red"/>
                <xsl:if test="position() > 1">
                    <xsl:variable name="prevVolume" select="preceding-sibling::productionEntry[1]/@volume"/>
                    <xsl:variable name="prevY" select="550 - ($prevVolume * $scalingFactor)"/>
                    <line x1="{$x - 150}" y1="{$prevY}" x2="{$x}" y2="{$y}" stroke="blue" stroke-width="2"/>
                </xsl:if>
            </xsl:for-each>
        </svg>
    </xsl:template>

</xsl:stylesheet>
