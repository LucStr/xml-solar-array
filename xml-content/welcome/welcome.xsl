<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template match="menu">
        <html>
            <head>
                <title>Solar Array Foundation</title>
                <!-- Include Bulma CSS -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.9.3/css/bulma.min.css"/>
            </head>
            <body>

                <section class="section">
                    <div class="container">
                        <!-- title -->
                        <h1 class="title">Solar Array Foundation</h1>
                        <p class="subtitle">
                            <i>Auf dieser Plattform können verschiedene Werte von Solar energie proviern erfasst werden.</i>
                        </p>

                        <!-- render menu nav with Bulma styling -->
                        <nav class="panel">
                            <p class="panel-heading">
                                Navigation
                            </p>
                            <ul>
                                <xsl:apply-templates select="item">
                                    <xsl:sort select="index" data-type="text" order="ascending"/>
                                </xsl:apply-templates>
                            </ul>
                        </nav>
                        <hr />
                        <a class="button is-link" href="solar-database/database.xml" target="_blank">
                            Show Database
                        </a>
                    </div>
                </section>

            </body>
        </html>
    </xsl:template>

    <!-- single menu item with Bulma styling -->
    <xsl:template match="item">
        <li>
            <a class="panel-block">
                <xsl:attribute name="href">
                    <xsl:value-of select="link"/>
                </xsl:attribute>
                <xsl:value-of select="text"/>
            </a>
        </li>
    </xsl:template>

</xsl:stylesheet>
