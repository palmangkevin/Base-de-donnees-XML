<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output name="my-xhtml-output" method="html"
        indent="yes"
        encoding="UTF-8"
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    
   
    <!-- Kevin P. Kombate (p1080477) && Abdramane Diasso (p1128102) -->
    
    
    <xsl:template match="/">
        
        <!-- C'est ici qu'on met les bornes de prix minimales et maximales voulues -->
        <xsl:param name="min" select="0"/>
        <xsl:param name="max" select="1000"/>
        
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <title>Informations - Livres</title>
                    <link rel="stylesheet" type="text/css" href="style1.css"/>
                    
                </head>
                <body>
                    <div id="pageContent">
                        <h1>Livres et leurs Auteurs</h1>
                        <h1>Kevin P. Kombate et Abdramane Diasso</h1>
                        <xsl:for-each select="//livre">
                            <xsl:sort select="@auteurs"/>
                            <xsl:if test="prix/valeur &gt;= $min">
                                <xsl:if test="prix/valeur &lt;= $max">
                                    <xsl:variable name="auteursID" select="@auteurs"/>
                                    <div class="livres">
                                        <div class="livreInfo">
                                            <h2><xsl:value-of select="titre"/></h2>
                                            <ul>
                                                <li><strong>Langue: </strong><xsl:value-of select="@langue"/></li>
                                                <li><strong>Prix: </strong> <xsl:value-of select="concat(prix/valeur, ' ', prix/@monnaie)"/></li>
                                                <li><strong>Date de publication: </strong><xsl:value-of select="annee"/></li>
                                                <xsl:if test="commentaire">
                                                    <li><strong>Commentaire: </strong><xsl:value-of select="commentaire"/></li>
                                                </xsl:if>
                                            </ul>
                                        </div>
                                        <xsl:if test="couverture">
                                            <div class="livreImage">
                                                <img alt="Couverture du livre">
                                                    <xsl:attribute name="src">
                                                        <xsl:value-of select="couverture"/>
                                                    </xsl:attribute>
                                                </img>
                                            </div>
                                        </xsl:if>
 
                                        <div class="auteur">
                                        <h4>Auteurs :</h4>
                                        <xsl:for-each select="//auteur">
                                            <xsl:sort order="descending" select="nom"/>
                                            <xsl:if test="contains($auteursID, @ident)">
                                                <p><xsl:value-of select="concat(prenom,' ',nom)"/></p>
                                            </xsl:if>
                                        </xsl:for-each>
                                        </div>
                                                           
                                    </div>
                                </xsl:if>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </body>
            </html>
        
    </xsl:template>
    
</xsl:stylesheet>