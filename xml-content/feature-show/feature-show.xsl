<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template match="feature">
        <html>
            <head>
                <title>Energiewerke Mittelland Reloaded</title>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>


                <!-- title and nav  -->
                <h1>Feature Show</h1>
                <small>
                    <a href="index.xml">Home</a>
                </small>

                <div class="content">

                    <p>
                        <i>Let's access some data</i>
                    </p>


                    <!-- load data from DB and render  -->
                    <div>
                        <h2>our energie plants:</h2>
                        <ul>

                        <xsl:apply-templates
                                select="document('../solar-database/database.xml')/solarEnergyData/provider"
                        >
                        </xsl:apply-templates>
                        </ul>
                    </div>
                </div>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="provider">
        <li>
            <xsl:value-of select="name/text()"/>
        </li>
    </xsl:template>

</xsl:stylesheet>
