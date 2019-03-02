<?xml version="1.0" encoding="UTF-8"?>

<!-- Kevin P. Kombate (p1080477) && Abdramane Diasso (p1128102) -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output name="my-xhtml-output" method="html"
        indent="yes"
        encoding="UTF-8"
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:param name="auteur" select="'default'"></xsl:param>  
    <xsl:template match="/">
            <html>
                <head>
                    <title>Classement des auteurs</title>
                    <link rel="stylesheet" type="text/css" href="style.css"/>
                </head>
                <body>
                    <div id="pageContent">
                        <xsl:choose>
                            <xsl:when test="$auteur='default'">
                                <xsl:call-template name="noInput"></xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:call-template name="withInput"></xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                </body>
            </html>
        
    </xsl:template>
    
    <xsl:template name="noInput">
        <h1>Classement des auteurs</h1>
        <h1>Kevin P. Kombate et Abdramane Diasso</h1>
        <xsl:for-each select="//auteur">
            <xsl:call-template name="content"></xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="withInput">
        <h1>Classement des auteurs</h1>
        <h1>Kevin P. Kombate et Abdramane Diasso</h1>
        <xsl:for-each select="//auteur[nom=$auteur]">
            <xsl:call-template name="content"></xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="content">
        <xsl:variable name="auteurID" select="@ident"/>
        <div class="auteur">
            <h2><xsl:value-of select=" prenom "/><xsl:value-of select=" nom "/></h2>
            <div class="auteurInfo">
                <ul>
                    <li><strong>Nom :</strong><xsl:value-of select="nom"/></li>
                    <li><strong>Prenom :</strong><xsl:value-of select="prenom"/></li>
                    <li><strong>Pays d'origine :</strong><xsl:value-of select="pays"/></li>
                    <xsl:if test="commentaire">
                        <li><strong>Commentaire :</strong><xsl:value-of select="commentaire"/></li>
                    </xsl:if>
                </ul>
            </div>
            <xsl:if test="photo">
                <div class="auteurPhoto">
                    <img alt="Photo de l'auteur">
                        <xsl:attribute name="src">
                            <xsl:value-of select="photo"/>
                        </xsl:attribute>
                    </img>
                </div>
            </xsl:if>
            <div class="livres">
                <h2>Oeuvres de <xsl:value-of select="nom"/></h2>
                
                <xsl:for-each select="//livre">
                    <xsl:sort select="prix/valeur"/>
                    <xsl:for-each select="@auteurs">
                        <xsl:if test="contains(., $auteurID)">
                            <xsl:apply-templates select="ancestor::livre"></xsl:apply-templates>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:for-each>      
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="livre">
        <div class="separateur"></div>
        <h3><xsl:value-of select="titre"/></h3>
        <div class="livreInfo">
            <ul>
                <li><strong>Langue: </strong><xsl:value-of select="@langue"/></li>
                <li><strong>Prix: </strong> <xsl:value-of select="concat(prix/valeur, ' ', prix/@monnaie)"/></li>
                <li><strong>Date de publication: </strong> <xsl:value-of select="annee"/></li>
                
            </ul>
        </div>
    </xsl:template>
</xsl:stylesheet>