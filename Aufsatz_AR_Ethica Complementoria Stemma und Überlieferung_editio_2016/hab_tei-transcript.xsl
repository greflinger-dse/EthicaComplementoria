<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:mets="http://www.loc.gov/METS/"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:exist="http://exist.sourceforge.net/NS/exist"
    exclude-result-prefixes="tei mets xlink exist" version="1.0">

    <!-- Einbindung der Standard-Templates und Variablen -->
    <xsl:import href="http://diglib.hab.de/rules/styles/param.xsl"/>
    <xsl:import href="http://diglib.hab.de/rules/styles/tei-phraselevel.xsl"/>


    <xsl:output encoding="UTF-8" indent="no" method="html"/>
    <xsl:param name="dir"/>
    <xsl:param name="q"/>
    <xsl:param name="qtype"/>
    <xsl:param name="distype"/>
    <xsl:param name="pvID"/>
    <xsl:param name="footerXML"/>
    <xsl:param name="footerXSL"/>
    <xsl:param name="view"/>
    <xsl:variable name="metsfile">
        <xsl:value-of select="concat('http://diglib.hab.de/', $dir, '/mets.xml')"/>
    </xsl:variable>
    <xsl:variable name="smallcase" select="'&#173;'"/>
    <xsl:variable name="uppercase" select="'-'"/>


    <xsl:template match="/">





        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <title>WDB</title>
                <link rel="stylesheet" type="text/css"
                    href="http://diglib.hab.de/ebooks/ed000532/layout/navigator23.css"/>
                <link rel="stylesheet" type="text/css" media="print"
                    href="http://diglib.hab.de/ebooks/ed000532/layout/print.css"/>
                <script src="http://diglib.hab.de/navigator.js" type="text/javascript"><noscript>please activate javascript to enable wdb functions</noscript></script>
                <!-- Steyer: Einbinden des Junicode-Schriftsatzes -->

                <style>
                    @font-face{
                        font-family: 'junicode';<!-- Herunterladen eines gleichnamigen lokalen Schriftsatzes verhindern -->
                src: local ('Ø'); 
                src: local ('Junicode');
                <!-- Einbinden -->
                src: url('http://diglib.hab.de/rules/fonts/Junicode.woff') format('woff');
                
                </style>
                <!-- Ende Ergänzung -->

            </head>

            <body>
                <!--  Dokumentkopf -->
                <div id="doc_header">
                    <!-- <div style="margin-bottom:0.2em;padding:0;letter-spacing:0.3em;">Text </div> -->
                    <hr style="margin:0;padding:0;height:1px;"/>
                    <xsl:choose>
                        <xsl:when
                            test="document($metsfile)//mets:rightsMD[@ID = document($metsfile)//mets:div[@TYPE = 'transcripton']/@ADMID]/mets:mdRef/@xlink:href">
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of
                                        select="document($metsfile)//mets:rightsMD[@ID = document($metsfile)//mets:div[@TYPE = 'transcripton']/@ADMID]/mets:mdRef/@xlink:href"
                                    />
                                </xsl:attribute> copyright </a>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="document($metsfile)//mets:rightsMD[@ID = document($metsfile)//mets:div[@TYPE = 'transcripton']/@ADMID]/mets:mdWrap/mets:xmlData"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
                <!-- Titel -->
                <div id="caption">
                    <div style="font-size:1.2em; font-weight:bold">
                        <xsl:apply-templates
                            select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type = 'main']"/>
                        <xsl:text> </xsl:text>
                    </div>
                    <div style="font-size:1.2em; font-weight:italics">
                        <xsl:apply-templates
                            select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type = 'sub']"/>
                        <xsl:text> </xsl:text>
                    </div>
                    <div>
                        <xsl:choose>
                            <xsl:when
                                test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:name/tei:forename">

                                <xsl:value-of
                                    select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:name/tei:forename"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of
                                    select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:name/tei:surname"/>
                                <xsl:text> </xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if
                                    test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:name[1]/tei:name">
                                    <xsl:text>verfasst von </xsl:text>
                                    <xsl:value-of
                                        select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:name[1]/tei:name"/>
                                    <xsl:if
                                        test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:name[2]/tei:name">
                                        <xsl:text>/ </xsl:text>
                                        <xsl:value-of
                                            select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:name[2]/tei:name"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:if>
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>

                </div>

                <!-- Inhaltsuebersicht -->
                <a href="javascript:switchlayer('headings');">
                    <div style="margin: 1em 0 1em 0;">[Inhaltsverzeichnis]</div>
                </a>
                <div id="headings"
                    style="display:none;border:1px black solid;background-color:#EEE;">
                    <ul>
                        <xsl:for-each select="/tei:TEI/tei:text/tei:body//tei:div/tei:head">
                            <li>

                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:text>#hd</xsl:text>
                                        <xsl:number level="any"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="."/>
                                </a>
                                <xsl:apply-templates select="../tei:argument/tei:p">
                                    <xsl:with-param name="caption">true</xsl:with-param>
                                </xsl:apply-templates>
                            </li>

                        </xsl:for-each>
                    </ul>

                </div>

                <xsl:choose>
                    <xsl:when
                        test="tei:TEI/tei:text/tei:body/tei:div/tei:p/tei:note[@place = 'margin-right'] | tei:TEI/tei:text/tei:body/tei:div/tei:div/tei:p/tei:note[@place = 'margin-right']">

                        <div class="content"
                            style="font-family:'junicode'; text-align:justify;  padding-left: 150px; ">
                            <!-- Haupttext -->
                            <xsl:apply-templates select="tei:TEI/tei:text"/>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="content" style="font-family:'junicode'; text-align:justify;">
                            <!-- Haupttext -->
                            <xsl:apply-templates select="tei:TEI/tei:text/tei:front"/>
                            <xsl:apply-templates select="tei:TEI/tei:text/tei:body"/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>


                <!-- Marginalien als Fussnoten ausgeben  -->

                <div style="background-color:#EEE;">
                    <xsl:if test="tei:TEI/tei:text/tei:body//tei:note[@place]">
                        <hr style="height:1px;margin:1em 0 1em; 0"/>
                        <div
                            style="font-size:13pt;
                            font-family:junicode,sans-serif;
                            color:black;
                            font-weight:600;
                            text-align:left;"
                            >Marginalien</div>
                    </xsl:if>
                    <div
                        style=" position:relative;
                        margin-left:0px;
                        margin-right:0px;
                        margin-top:0px;
                        margin-bottom:0px;
                        font-family:'junicode',sans-serif;
                        font-size:11pt;">

                        <a name="footnotes"/>
                        <xsl:choose>
                            <xsl:when test="tei:TEI/tei:text/tei:body/tei:div[@place]">
                                <!--  Wenn es einen Fussnotenbereich gibt -->
                                <xsl:apply-templates
                                    select="tei:TEI/tei:text/tei:body/tei:div[@place]"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <!--  andernfalls notes auswerten -->
                                <xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note[@place]">
                                    <div class="footnotes">
                                        <a>
                                            <xsl:attribute name="name">
                                                <xsl:text>mn</xsl:text>
                                                <xsl:number level="any" count="tei:note[@place]"
                                                  format="a"/>
                                            </xsl:attribute>
                                            <a>
                                                <xsl:attribute name="href">
                                                  <xsl:text>#mna</xsl:text>
                                                  <xsl:number level="any" count="tei:note[@place]"
                                                  format="a"/>
                                                </xsl:attribute>
                                                <span
                                                  style="font-size:9pt;vertical-align:super;color:red;">
                                                  <xsl:number level="any" count="tei:note[@place]"
                                                  format="a"/>
                                                </span>
                                            </a>
                                            <xsl:text> </xsl:text>
                                            <xsl:apply-templates/>
                                        </a>
                                    </div>

                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                </div>

                <!-- Textapparat  -->

                <div style="background-color:#EEE;">
                    <xsl:if test="tei:TEI/tei:text/tei:body//tei:note[@type = 'annotation']">
                        <hr style="height:1px;margin:1em 0 1em; 0"/>
                        <div
                            style="font-size:13pt;
                            font-family:junicode,sans-serif;
                            color:black;
                            font-weight:600;
                            text-align:left;"
                            >Textapparat</div>
                    </xsl:if>
                    <div
                        style=" position:relative;
                        margin-left:0px;
                        margin-right:0px;
                        margin-top:0px;
                        margin-bottom:0px;
                        font-family:junicode,sans-serif;
                        font-size:11pt;">

                        <xsl:choose>
                            <xsl:when test="tei:TEI/tei:text/tei:body/tei:div[@type = 'annotation']">
                                <!--  Wenn es einen Fussnotenbereich gibt -->
                                <xsl:apply-templates
                                    select="tei:TEI/tei:text/tei:body/tei:div[@type = 'annotation']"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <!--  andernfalls notes auswerten -->
                                <xsl:for-each
                                    select="tei:TEI/tei:text/tei:body//tei:note[@type = 'annotation']">
                                    <div>
                                        <a>
                                            <xsl:attribute name="name">
                                                <xsl:text>an</xsl:text>
                                                <xsl:number level="any" format="a"
                                                  count="tei:note[@type = 'annotation']"/>
                                            </xsl:attribute>
                                            <a>
                                                <xsl:attribute name="href">
                                                  <xsl:text>#ana</xsl:text>
                                                  <xsl:number level="any" format="a"
                                                  count="tei:note[@type = 'annotation']"/>
                                                </xsl:attribute>
                                                <span
                                                  style="font-size:9pt;vertical-align:super;color:blue;">
                                                  <xsl:number level="any" format="a" from="tei:div"
                                                  count="tei:note[@type = 'annotation']"/>
                                                </span>
                                            </a>
                                            <xsl:apply-templates/>
                                        </a>
                                    </div>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                </div>
                <!-- Fussnotenbereich  -->

                <!-- Kommentare -->
                <div style="background-color:#EEE;">
                    <xsl:if test="tei:TEI/tei:text/tei:body//tei:note[@type = 'footnote']">
                        <hr style="height:1px;margin:1em 0 1em; 0"/>
                        <div>
                            <head>Fußnotenapparat</head>
                        </div>
                    </xsl:if>
                    <div
                        style=" position:relative;
                        margin-left:0px;
                        margin-right:0px;
                        margin-top:0px;
                        margin-bottom:0px;
                        font-family:'junicode',sans-serif;
                        font-size:11pt;">

                        <a name="footnotes"/>
                        <xsl:choose>
                            <xsl:when test="tei:TEI/tei:text/tei:body/tei:div[@type = 'footnotes']">
                                <!--  Wenn es einen Fussnotenbereich gibt -->
                                <xsl:apply-templates
                                    select="tei:TEI/tei:text/tei:body/tei:div[@type = 'footnotes']"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <!--  andernfalls notes auswerten -->
                                <xsl:for-each select="tei:TEI//tei:note[@type = 'footnote']">
                                    <div class="footnotes">
                                        <a>
                                            <xsl:attribute name="name">
                                                <xsl:text>fn</xsl:text>
                                                <xsl:number level="any"
                                                  count="tei:note[@type = 'footnote']"/>
                                            </xsl:attribute>
                                            <a>
                                                <xsl:attribute name="href">
                                                  <xsl:text>#fna</xsl:text>
                                                  <xsl:number level="any"
                                                  count="tei:note[@type = 'footnote']"/>
                                                </xsl:attribute>
                                                <span
                                                  style="font-size:9pt;vertical-align:super;color:blue;">
                                                  <xsl:number level="any"
                                                      count="tei:note[@type = 'footnote']"/>
                                                </span>
                                            </a>
                                            <xsl:text> </xsl:text>
                                            <xsl:apply-templates/>
                                        </a>
                                    </div>

                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                </div>
                <hr style="height:1px;"/>
                <!-- Bibliographie -->
                <xsl:if test="tei:TEI/tei:text/tei:back/tei:div[@type = 'bibliography']">

                    <div
                        style="font-size:11pt;
                    font-family:junicode,sans-serif;
                    color:black;
                    background-color:#EEE;
                    text-align:left;">
                        <head>Bibliographische Angaben</head>
                        <xsl:apply-templates
                            select="tei:TEI/tei:text/tei:back/tei:div[@type = 'bibliography']"/>
                    </div>
                </xsl:if>
                <div style="margin-top:2%; position:right">
                    <a href="#" onclick="window.print(); return false"><img
                            src="http://diglib.hab.de/edoc/ed000213/icons/printer.png" hspace="10px"
                        /> Seite drucken</a>
                </div>
                <!-- footer -->
                <div id="doc_footer">
                    <xsl:choose>
                        <xsl:when
                            test="document($metsfile)//mets:rightsMD[@ID = document($metsfile)//mets:div/@ADMID]/mets:mdRef/@xlink:href">
                            <xsl:choose>
                                <xsl:when
                                    test="document($metsfile)//mets:rightsMD[@ID = document($metsfile)//mets:div[@type = 'bibliography']/@ADMID]/mets:mdRef/@xlink:href">
                                    <b>
                                        <xsl:text>© </xsl:text>
                                        <xsl:for-each
                                            select="document($metsfile)//mods:mods/mods:name">
                                            <xsl:if test="position() > 1">
                                                <xsl:text>, </xsl:text>
                                            </xsl:if>
                                            <xsl:value-of select="mods:displayForm"/>
                                        </xsl:for-each>
                                    </b>
                                </xsl:when>
                            </xsl:choose>
                            <div>
                                <div>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of
                                                select="document($metsfile)//mets:rightsMD[@ID = document($metsfile)//mets:div/@ADMID]/mets:mdRef/@xlink:href"
                                            />
                                        </xsl:attribute>

                                    </a>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of
                                                select="document($metsfile)//mets:rightsMD[@ID = document($metsfile)//mets:div/@ADMID]/mets:mdRef/@xlink:href"
                                            />
                                        </xsl:attribute>
                                        <img src="http://diglib.hab.de/images/cc-by-sa.png"
                                            alt="image CC BY-SA licence" width="50px" align="right"
                                            hspace="10px"/>
                                    </a>


                                </div>


                            </div>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="document($metsfile)//mets:rightsMD[@ID = document($metsfile)//mets:div/@ADMID]/mets:mdWrap/mets:xmlData"/>
                            <div>
                                <a href="#" onclick="window.print(); return false"><img
                                        src="http://diglib.hab.de/edoc/ed000213/icons/printer.png"/>
                                    Seite drucken</a>
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
                <div style="margin-top:5%">
                    <xsl:call-template name="footer">
                        <xsl:with-param name="footerXML">
                            <xsl:value-of select="$footerXML"/>
                        </xsl:with-param>
                        <xsl:with-param name="footerXSL">
                            <xsl:value-of select="$footerXSL"/>
                        </xsl:with-param>

                    </xsl:call-template>
                </div>
                <!-- Ende main -->
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:body | tei:front">
        <xsl:apply-templates/>
    </xsl:template>

    <!--header-->
    <!-- editor, contributer etc. -->
    <xsl:template match="tei:respStmt">
        <xsl:if test="position() != 1">
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:text> </xsl:text>
        <xsl:value-of select="tei:resp"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="tei:name"/>
    </xsl:template>

    <!-- Front -->

    <xsl:template match="tei:titlePage">
        <p class="content">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:title[@ref]">
        <span style="font-style:italic;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:docTitle">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:byline">
        <p class="content">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:imprimatur">
        <p class="content">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:docDate">
        <p class="content">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:docAuthor">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:epigraph">
        <p class="content">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:titlePart">
        <p class="content">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


    <!--body-->
    <!-- main distribution-->
    <xsl:template
        match="tei:div[not(@type = 'footnotes')] | tei:div1[not(@type = 'footnotes')] | tei:div2[not(@type = 'footnotes')] | tei:div3[not(@type = 'footnotes')]">
        <a>
            <xsl:attribute name="name">
                <xsl:text>div</xsl:text>
                <xsl:number level="any"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
        <xsl:if test="@xml:id[starts-with(., 'org') or starts-with(., 'ue')]">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <div>
            <xsl:if test="@type = 'abstract'">
                <xsl:attribute name="style">font-size:smaller;</xsl:attribute>
            </xsl:if>
            <p>
                <xsl:apply-templates/>
            </p>
        </div>
    </xsl:template>

    <!--    Ueberschriften-->

    <xsl:template match="tei:head">

        <xsl:if test="@xml:id[starts-with(., 'org') or starts-with(., 'ue')]">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <a>
            <xsl:attribute name="name">
                <xsl:text>hd</xsl:text>
                <xsl:number level="any"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
        <h2 style="background-color:#EEE;padding:0.3em;margin-top:1em;position:relative;width:100%;">
            <div style="position:relative;width:90%;">
                <xsl:apply-templates/>
            </div>
            <div style="position:absolute;right:1.5em;top:0.2em;font-weight:900;">
                <a href="#">↑</a>
            </div>
        </h2>
    </xsl:template>

    <!-- dictonary entries -->
    <xsl:template match="tei:orth">
        <br/>
        <span class="lemma">
            <a>
                <xsl:attribute name="name">
                    <xsl:text>orth</xsl:text>
                    <xsl:number level="any"/>
                </xsl:attribute>
            </a>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- pysical pages     -->
    <xsl:template match="tei:pb">
        <!--    <div class="pagebreak">
            <br/>
            <xsl:text> || Seitenzahl der gedruckten Ausgabe: </xsl:text>
         <xsl:value-of select="@n"/>
            <br/>
        </div> -->
    </xsl:template>

    <xsl:template match="tei:linkGrp">
        <xsl:choose>
            <xsl:when test="@type = 'quote'"> </xsl:when>
        </xsl:choose>

    </xsl:template>

    <!--    Links -->
    <xsl:template match="tei:ref">
        <xsl:param name="caption"/>
        <xsl:choose>
            <xsl:when test="@type = 'footnote' and $caption != 'true'">
                <a>
                    <xsl:attribute name="name">
                        <xsl:text>fna</xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="@target"/>
                        </xsl:attribute>
                        <span style="font-size:9pt;vertical-align:super;color:blue;"><xsl:value-of select="."/>
                        </span>
                    </a>
                </a>
            </xsl:when>
            <xsl:when test="@type = 'bibliography'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation('ebooks/ed000532','register/register-bibl.xml','show_bibl.xsl','</xsl:text>
                        <xsl:value-of select="substring(@target, 2)"/>
                        <xsl:text>',300,500);</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="class">
                        <xsl:text>biblio</xsl:text>
                        <xsl:text> </xsl:text>
                    </xsl:attribute>

                    <xsl:attribute name="title">
                        <xsl:value-of
                            select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl/tei:bibl[@xml:id = substring(current()/@ref, 2)]"/>
                        <xsl:text> </xsl:text>
                        <xsl:if
                            test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl/tei:bibl[@xml:id = substring(current()/@ref, 2)]/tei:nameLink">
                            <xsl:text> </xsl:text>
                            <xsl:value-of
                                select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl/tei:bibl[@xml:id = substring(current()/@ref, 2)]/tei:nameLink"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@type = 'bibl'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation('ebooks/ed000532','register/register-bibl.xml','show_bibl.xsl','</xsl:text>
                        <xsl:value-of select="substring(@target, 2)"/>
                        <xsl:text>',300,500);</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="class">
                        <xsl:text>biblio</xsl:text>
                        <xsl:text> </xsl:text>
                    </xsl:attribute>

                    <xsl:attribute name="title">
                        <xsl:value-of
                            select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl/tei:bibl[@xml:id = substring(current()/@ref, 2)]"/>
                        <xsl:text> </xsl:text>
                        <xsl:if
                            test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl/tei:bibl[@xml:id = substring(current()/@ref, 2)]/tei:nameLink">
                            <xsl:text> </xsl:text>
                            <xsl:value-of
                                select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl/tei:bibl[@xml:id = substring(current()/@ref, 2)]/tei:nameLink"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
          <xsl:when test="@type= 'intern'">
              <a>
                  <xsl:attribute name="href">
                      <xsl:value-of select="@target"/>
                  </xsl:attribute>
                  <xsl:attribute name="target">_self</xsl:attribute>
                  <xsl:apply-templates/>
              </a>
          </xsl:when>
            <xsl:when test="@type = 'vd17'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>https://gso.gbv.de/DB=1.28/CMD?ACT=SRCHA&amp;IKT=8002&amp;TRM=%27</xsl:text>
                        <xsl:value-of select="substring-after(., 'VD17 ')"/>
                        <xsl:text>%27</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:attribute name="title">
                        <xsl:text>Link zum VD17</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:when test="@type = 'vd18'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>https://gso.gbv.de/DB=1.65/SET=5/TTL=1/CMD?ACT=SRCHA&amp;IKT=8002&amp;SRT=YOP&amp;TRM=</xsl:text>
                        <xsl:value-of select="substring-after(., 'VD18 ')"/>
                        <xsl:text>&amp;ADI_MAT=B&amp;MATCFILTER=Y&amp;MATCSET=Y&amp;ADI_MAT=T&amp;REC=*</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:attribute name="title">
                        <xsl:text>Link zum VD18</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:otherwise>
        </xsl:choose>


    </xsl:template>



    <xsl:template match="tei:ptr">
        <xsl:apply-templates/>
        <xsl:choose>
            <xsl:when test="@type = 'google_books'"> [<a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation_html('</xsl:text><xsl:value-of
                            select="$dir"/><xsl:text>','</xsl:text><xsl:value-of select="@target"
                        /><xsl:text>',400,600)</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Google Books</xsl:text></a>] </xsl:when>
            <xsl:when test="starts-with(@target, 'http://')"> [<a>
                    <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:text>Link</xsl:text>
                </a>] </xsl:when>
            <xsl:when test="@type = 'opac'"> [<a href="{normalize-space(concat($opac,@cRef))}"
                    target="_blank">Nachweis im OPAC</a>] </xsl:when>
            <xsl:when test="@type = 'gbv'"> [<a href="{normalize-space(concat($gbv,@cRef))}"
                    target="_blank">Nachweis im GBV</a>] </xsl:when>
            <xsl:when test="@type = 'GettyThesaurus'"> [<a
                    href="{normalize-space(concat($GettyThesaurus,(substring-after(@target, '#TGN_'))))}"
                    target="_blank">TGN</a>] </xsl:when>
        </xsl:choose>
    </xsl:template>





    <xsl:template match="tei:bibl[parent::tei:listBibl]">

        <li class="list_bibliography">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
            </a>

            <xsl:apply-templates/>
        </li>


    </xsl:template>

    <xsl:template match="tei:bibl[@type = 'short']"> </xsl:template>


    <!-- footnotes, annotations -->

    <xsl:template match="tei:note">

        <xsl:param name="caption"/>
        <!--  zwei Typen: entweder Fussnoten am Text- oder Seitenende in einem besonderen Abschnitt oder in den Text integriert -->
        <xsl:choose>
            <xsl:when test="parent::tei:div[@type = 'footnotes']">
                <!--   Fussnoten am Text- oder Seitenende -->
                <div class="footnotes">
                    <a>
                        <xsl:attribute name="name">
                            <xsl:text>fn</xsl:text>
                            <xsl:value-of select="@n"/>
                        </xsl:attribute>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:text>#fna</xsl:text>
                                <xsl:value-of select="@n"/>
                            </xsl:attribute>
                            <span
                                style="font-size:9pt;vertical-align:super;color:blue;margin-right:0.3em;">
                                <xsl:value-of select="@n"/>
                            </span>
                        </a>
                    </a>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="$caption = 'true'">
                <!-- keine Anzeige -->
            </xsl:when>
            <xsl:when test="@type = 'footnoteX'">
                <!--  noch in Bearbeitung, nicht anzeigen -->
            </xsl:when>
            <xsl:when test="@type = 'footnote'">
                <a>
                    <xsl:attribute name="name">
                        <xsl:text>fna</xsl:text>
                        <xsl:number level="any" count="tei:note[@type = 'footnote']"/>
                    </xsl:attribute>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>#fn</xsl:text>
                            <xsl:number level="any" count="tei:note[@type = 'footnote']"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:copy-of select="normalize-space(.)"/>
                        </xsl:attribute><span style="font-size:9pt;vertical-align:super;color:blue; line-height:0;"><xsl:number level="any" count="tei:note[@type = 'footnote']"/></span></a>
                </a>
            </xsl:when>

            <xsl:when test="@place">
                <div
                    style=" width: 120px;
                    font-size: 8pt;
                    display: block;
                    float: left;
                    margin: 0px 10px 0px -130px;
                    line-height:1.2;
                    ">

                    <a>
                        <xsl:attribute name="name">
                            <xsl:text>mna</xsl:text>
                            <xsl:number level="any" format="a" count="tei:note[@place]"/>
                        </xsl:attribute>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:text>#mn</xsl:text>
                                <xsl:number level="any" count="tei:note[@place]" format="a"/>
                            </xsl:attribute>
                            <xsl:attribute name="title">
                                <xsl:copy-of select="normalize-space(.)"/>
                            </xsl:attribute>
                            <span style="font-size:9pt;vertical-align:super;color:red;">
                                <xsl:number level="any" format="a" count="tei:note[@place]"/>
                            </span>
                            <xsl:if test="@place = 'margin-right'">

                                <xsl:text> Marginalie am rechten Rand</xsl:text>
                            </xsl:if>
                            <xsl:if test="@place = 'margin-left'">

                                <xsl:text> Marginalie am linken Rand</xsl:text>
                            </xsl:if>
                        </a>
                    </a>
                </div>
            </xsl:when>
            <xsl:when test="@type = 'annotation'">
                <!--  in Text integriert, nur Verweis , Fussnotenabschnitt mit foreach generiert -->
                <a>
                    <xsl:attribute name="name">
                        <xsl:text>ana</xsl:text>
                        <xsl:number level="any" format="a" count="tei:note[@type = 'annotation']"/>
                    </xsl:attribute>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>#an</xsl:text>
                            <xsl:number level="any" format="a"
                                count="tei:note[@type = 'annotation']"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:copy-of select="normalize-space(.)"/>
                        </xsl:attribute>
                        <span style="font-size:9pt;vertical-align:super;color:blue; line-height:0;">

                            <xsl:number level="any" format="a" from="tei:div"
                                count="tei:note[@type = 'annotation']"/>
                        </span>
                    </a>
                </a>
            </xsl:when>

            <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>
        <xsl:text> </xsl:text>

    </xsl:template>



    <!-- drama    -->
    <xsl:template match="tei:castList">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:castitem">
        <dl>
            <xsl:apply-templates/>
        </dl>
    </xsl:template>

    <xsl:template match="tei:role">
        <dt>
            <xsl:apply-templates/>
        </dt>
    </xsl:template>

    <xsl:template match="tei:roleDesc">
        <dd>
            <xsl:apply-templates/>
        </dd>
    </xsl:template>

    <xsl:template match="tei:set">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:stage">
        <xsl:if test="@xml:id[starts-with(., 'org') or starts-with(., 'ue')]">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <p>
            <i>
                <xsl:apply-templates/>
            </i>
        </p>
    </xsl:template>

    <xsl:template match="tei:sp">
        <xsl:if test="@xml:id[starts-with(., 'org') or starts-with(., 'ue')]">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:speaker">
        <xsl:if test="@xml:id[starts-with(., 'org') or starts-with(., 'ue')]">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <p style="font-variant:small-caps;text-align:center;">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- hier erst mal aus    -->
    <xsl:template match="tei:ab"/>




    <!-- closer -->
    <xsl:template match="tei:closer">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- closer -->
    <xsl:template match="tei:opener">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- closer -->
    <xsl:template match="tei:salute">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Namen -->
    <xsl:template match="tei:name">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Datum -->
    <xsl:template match="tei:dateline">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:date">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- index  erst mal auslassen-->
    <xsl:template match="tei:index"> </xsl:template>

    <!--  Anker fuer Spruenge im Text -->
    <xsl:template match="tei:anchor">
        <a>
            <xsl:attribute name="name">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
    </xsl:template>
    <!-- lokal ################################################################################################  -->



    <!-- entitaeten -->


    <!--  Textkritik -->

    <xsl:template match="tei:app">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:rdg">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:l">
        <xsl:if test="@xml:id">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <br/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:cit">

        <span
            style="display:block; margin-left:20%; margin-right:20%; padding-top:25%, padding-bottom:25%">
            <br/>
            <xsl:apply-templates/>

        </span>
        <br/>
    </xsl:template>

    <xsl:template match="tei:table">
        <table style="text-align: left;">
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="tei:row">
        <xsl:choose>


            <xsl:when test="@role = 'label'">
                <tr>
                    <xsl:for-each select="tei:cell">
                        <th style="font-weight:bold; valign:top">
                            <xsl:apply-templates/>
                        </th>
                    </xsl:for-each>
                </tr>
            </xsl:when>
            <xsl:otherwise>
                <tr style="padding-left:10px">
                    <xsl:apply-templates/>
                </tr>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:cell">
        <th style="border-bottom: 1px solid #ddd; font-weight:normal">
            <xsl:apply-templates/>
        </th>
    </xsl:template>

    <xsl:template match="tei:quote | tei:q">
        <xsl:if test="@xml:id[starts-with(., 'org') or starts-with(., 'ue')]">
            <a>
                <xsl:attribute name="name"><xsl:value-of select="@xml:id"/></xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if> &#8222;<xsl:apply-templates/>&#8220;</xsl:template>

    <xsl:template match="tei:hi | tei:emph | tei:rs/tei:hi">
        <xsl:if test="@xml:id[starts-with(., 'org') or starts-with(., 'ue')]">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="@rend = 'italics' or @rend = 'italic'">
                <span style="font-style:italic;">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend = 'oesup'">
                <span>&#58948;</span>
            </xsl:when>
            <xsl:when test="@rend = 'uesup'">
                <span>u&#x0364;</span>
            </xsl:when>
            <xsl:when test="@rend = 'margin-right'">
                <span style="margin-left: 50%">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend = 'bold'">
                <span style="font-weight:bold;">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend = 'smallCaps' or @rend = 'small-caps'">
                <span style="font-variant:small-caps;">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend = 'spaced'">
                <span style="letter-spacing:0.2em;">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend = 'center'">
                <span style="text-align:center;">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend = 'initiale'">
                <span style="font-weight:bold;">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend = 'sup'">
                <span style="vertical-align:super; font-size: .83em;">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend = 'dagger'">
                <span style="font-family:arial;">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>

            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="tei:lb">
        <xsl:if test="not(@rend) or @rend != 'trennstrich'">

            <xsl:text> </xsl:text>
        </xsl:if>
        <br/>
    </xsl:template>

    <!--   <xsl:template match="tei:lb">
        <xsl:choose>
            <xsl:when test="$lokal != 'orig'">
                <xsl:if test="parent::tei:w and not(preceding-sibling::tei:fw or preceding-sibling::tei:pb)">
                    <xsl:text>-</xsl:text>
                </xsl:if> 
                <br/>
            </xsl:when>
            <xsl:when test="parent::tei:w">
                <xsl:text>|</xsl:text>
            </xsl:when>
            <xsl:when test="position()=1 and (parent::tei:hi or parent::tei:head or parent::tei:p or parent::tei:item)">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="preceding-sibling::tei:pb">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@n">
                <span style="position:relative;left:-0.5em;margin-left:2px;font-size:small;">(<xsl:value-of select="@n"/>)</span></xsl:when>
            <xsl:otherwise>
                <xsl:text>| </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>-->


    <xsl:template match="tei:lb">
        <xsl:choose>
            <xsl:when test="$view != 'orig'">
                <xsl:choose>
                    <xsl:when test="parent::tei:w">
                        <xsl:text>-</xsl:text>
                        <br/>
                    </xsl:when>
                    <xsl:when test="@type = 'hy'">
                        <xsl:text>-</xsl:text>
                        <br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <br/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="@n">
                        <span style="position:relative;left:-0.5em;margin-left:2px;font-size:small;"
                                >(<xsl:value-of select="@n"/>)</span>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$view != 'orig'">
                        <xsl:choose>
                            <xsl:when test="parent::tei:w">
                                <xsl:text>|</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates/>



    </xsl:template>

    <xsl:template match="tei:p | tei:seg | tei:lg">
        <xsl:if test="@xml:id[starts-with(., 'org') or starts-with(., 'ue')]">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <xsl:apply-templates/>
        <br/>
        <br/>
    </xsl:template>

    <xsl:template match="exist:match">

        <xsl:variable name="divNo">
            <xsl:number count="tei:div" level="any"/>
        </xsl:variable>

        <xsl:variable name="hitNo">
            <xsl:number level="multiple"/>
        </xsl:variable>

        <xsl:variable name="hitNoAll">
            <xsl:number level="any"/>
        </xsl:variable>
        <a>
            <xsl:attribute name="name">
                <xsl:text>hit</xsl:text>
                <xsl:value-of select="$divNo"/>
                <xsl:text>_</xsl:text>
                <xsl:value-of select="$hitNo"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
        <a>
            <xsl:attribute name="name">
                <xsl:text>hit</xsl:text>
                <xsl:value-of select="$hitNoAll"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
        <span style="background-color:yellow;">
            <xsl:apply-templates/>
        </span>
        <xsl:if test="$hitNoAll &gt; 1">
            <!--<p><xsl:value-of select="count(//exist:match)"/> _<xsl:value-of select="$hitNo"/></p>-->
            <xsl:text> [</xsl:text>
            <a style="font-weight:900;font-size:larger;">
                <xsl:attribute name="href">
                    <xsl:text>#hit</xsl:text>
                    <xsl:value-of select="$hitNoAll - 1"/>
                </xsl:attribute>
                <xsl:attribute name="title">
                    <xsl:text>voriger Treffer</xsl:text>
                </xsl:attribute>
                <xsl:text>←</xsl:text>
            </a>
            <xsl:text>]</xsl:text>
        </xsl:if>
        <xsl:if test="$hitNoAll &lt; count(//exist:match)">
            <!--<p><xsl:value-of select="count(//exist:match)"/> _<xsl:value-of select="$hitNo"/></p>-->
            <xsl:text> [</xsl:text>
            <a style="font-weight:900;font-size:larger;">
                <xsl:attribute name="href">
                    <xsl:text>#hit</xsl:text>
                    <xsl:value-of select="$hitNoAll + 1"/>
                </xsl:attribute>
                <xsl:attribute name="title">
                    <xsl:text>nächster Treffer</xsl:text>
                </xsl:attribute>
                <xsl:text>→</xsl:text>
            </a>
            <xsl:text>]</xsl:text>
        </xsl:if>
    </xsl:template>

    <!--  fuer Spruenge zu den Begriffen -->
    <!-- <xsl:template match="tei:term">
           <a>
               <xsl:attribute name="name">
                   <xsl:value-of select="concat('term_',substring(@target,2))"/>
                </xsl:attribute>
               <xsl:text> </xsl:text>
           </a>
            <xsl:apply-templates/>
            </xsl:template>-->

    <xsl:template match="tei:term">
        <xsl:choose>
            <xsl:when test="@target = concat('#', $q)">
                <xsl:variable name="hitNo">
                    <xsl:number level="any" count="tei:term[@target = concat('#', $q)]"/>
                </xsl:variable>
                <a>
                    <xsl:attribute name="name">
                        <xsl:text>hit</xsl:text>
                        <xsl:value-of select="$hitNo"/>
                    </xsl:attribute>
                    <xsl:text> </xsl:text>
                </a>
                <span style="background-color:yellow;">
                    <xsl:apply-templates/>
                </span>
                <xsl:if test="$hitNo &gt; 1">
                    <!--<p><xsl:value-of select="count(//exist:match)"/> _<xsl:value-of select="$hitNo"/></p>-->
                    <xsl:text> [</xsl:text>
                    <a style="font-weight:900;font-size:larger;">
                        <xsl:attribute name="href">
                            <xsl:text>#hit</xsl:text>
                            <xsl:value-of select="$hitNo - 1"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:text>voriger Treffer</xsl:text>
                        </xsl:attribute>
                        <xsl:text>←</xsl:text>
                    </a>
                    <xsl:text>]</xsl:text>
                </xsl:if>
                <xsl:if test="$hitNo &lt; count(//tei:term[@target = concat('#', $q)])">
                    <!--<p><xsl:value-of select="count(//exist:match)"/> _<xsl:value-of select="$hitNo"/></p>-->
                    <xsl:text> [</xsl:text>
                    <a style="font-weight:900;font-size:larger;">
                        <xsl:attribute name="href">
                            <xsl:text>#hit</xsl:text>
                            <xsl:value-of select="$hitNo + 1"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:text>nächster Treffer</xsl:text>
                        </xsl:attribute>
                        <xsl:text>→</xsl:text>
                    </a>
                    <xsl:text>]</xsl:text>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:rs">
        <xsl:choose>
            <xsl:when test="@ref = concat('#', $q)">
                <xsl:variable name="hitNo">
                    <xsl:number level="any" count="tei:rs[@ref = concat('#', $q)]"/>
                </xsl:variable>
                <a>
                    <xsl:attribute name="name">
                        <xsl:text>hit</xsl:text>
                        <xsl:value-of select="$hitNo"/>
                    </xsl:attribute>
                    <xsl:text> </xsl:text>
                </a>
                <span style="background-color:yellow;">
                    <xsl:choose>
                        <xsl:when
                            test="@type = 'person' or @type = 'author' or @type = 'place' or @type = 'event' or @type = 'org'">
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:text>javascript:show_annotation('</xsl:text>
                                    <xsl:value-of select="$server"/>
                                    <xsl:value-of select="$dir"/>
                                    <xsl:text>','tei-introduction.xml','http://diglib.hab.de/</xsl:text>
                                    <xsl:value-of select="$dir"/>
                                    <xsl:text>/show_person.xsl','</xsl:text>
                                    <xsl:value-of select="substring(@ref, 2)"/>
                                    <xsl:text>',400,600)</xsl:text>
                                </xsl:attribute>
                                <xsl:apply-templates/>
                            </a>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
                <xsl:if test="$hitNo &gt; 1">
                    <xsl:text> [</xsl:text>
                    <a style="font-weight:900;font-size:larger;">
                        <xsl:attribute name="href">
                            <xsl:text>#hit</xsl:text>
                            <xsl:value-of select="$hitNo - 1"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:text>voriger Treffer</xsl:text>
                        </xsl:attribute>
                        <xsl:text>←</xsl:text>
                    </a>
                    <xsl:text>]</xsl:text>
                </xsl:if>
                <xsl:if test="$hitNo &lt; count(//tei:rs[@ref = concat('#', $q)])">
                    <xsl:text> [</xsl:text>
                    <a style="font-weight:900;font-size:larger;">
                        <xsl:attribute name="href">
                            <xsl:text>#hit</xsl:text>
                            <xsl:value-of select="$hitNo + 1"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:text>nächster Treffer</xsl:text>
                        </xsl:attribute>
                        <xsl:text>→</xsl:text>
                    </a>
                    <xsl:text>]</xsl:text>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@type = 'person' or @type = 'author' or @type = 'org'">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:text>javascript:show_annotation('</xsl:text>
                                <xsl:value-of select="$dir"/>
                                <xsl:text>','tei-introduction.xml','http://diglib.hab.de/</xsl:text>
                                <xsl:value-of select="$dir"/>
                                <xsl:text>/show_person.xsl','</xsl:text>
                                <xsl:value-of select="substring(@ref, 2)"/>
                                <xsl:text>',300,500)</xsl:text>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </a>
                    </xsl:when>
                    <xsl:when test="@type = 'place'">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:text>javascript:show_annotation('</xsl:text>
                                <xsl:value-of select="$dir"/>
                                <xsl:text>','tei-introduction.xml','http://diglib.hab.de/</xsl:text>
                                <xsl:value-of select="$dir"/>
                                <xsl:text>/show_place.xsl','</xsl:text>
                                <xsl:value-of select="substring(@ref, 2)"/>
                                <xsl:text>',300,500)</xsl:text>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </a>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>


    </xsl:template>

    <xsl:template match="tei:rs">
        <xsl:choose>

            <xsl:when test="@type = 'person'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation('ebooks/ed000532','register/register-person.xml','show_person.xsl','</xsl:text>
                        <xsl:value-of select="substring(@ref, 2)"/>
                        <xsl:text>',400,800);</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                        <xsl:value-of
                            select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:persName/tei:forename"/>
                        <xsl:text> </xsl:text>
                        <xsl:if
                            test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:persName/tei:nameLink">
                            <xsl:value-of
                                select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:persName/tei:nameLink"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:value-of
                            select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:persName/tei:surname"/>
                        <xsl:if
                            test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:birth or /tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:death">
                            <xsl:text> (</xsl:text>
                        </xsl:if>
                        <xsl:if
                            test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:birth">
                            <xsl:value-of
                                select="normalize-space(/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:birth/text())"
                            />
                        </xsl:if>
                        <xsl:if
                            test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:birth or /tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:death">
                            <xsl:text> - </xsl:text>
                        </xsl:if>
                        <xsl:if
                            test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:death">
                            <xsl:value-of
                                select="normalize-space(/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:death/text())"
                            />
                        </xsl:if>
                        <xsl:if
                            test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:birth or /tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:person[@xml:id = substring(current()/@ref, 2)]/tei:death">
                            <xsl:text>)</xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                    <xsl:apply-templates/>

                </a>
            </xsl:when>
            <xsl:when test="@type = 'org'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation('ebooks/ed000532','register/register-person.xml','show_person.xsl','</xsl:text>
                        <xsl:value-of select="substring(@ref, 2)"/>
                        <xsl:text>',300,500);</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                        <xsl:value-of
                            select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:org[@xml:id = substring(current()/@ref, 2)]/tei:orgName/tei:name"/>
                        <xsl:text> </xsl:text>
                        <xsl:if
                            test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:org[@xml:id = substring(current()/@ref, 2)]/tei:orgName/tei:name/tei:nameLink">
                            <xsl:value-of
                                select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:org[@xml:id = substring(current()/@ref, 2)]/tei:orgName/tei:name/tei:nameLink"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:value-of
                            select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson/tei:org[@xml:id = substring(current()/@ref, 2)]/tei:orgName/tei:name"
                        />
                    </xsl:attribute>
                    <xsl:apply-templates/>

                </a>
            </xsl:when>
            <xsl:when test="@type = 'work'">
                <q>
                    <a href="{@ref}">
                        <xsl:apply-templates/>
                    </a>
                </q>
            </xsl:when>
            <xsl:when test="@type = 'place'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation('ebooks/ed000532','register/register-place.xml','show_place.xsl','</xsl:text>
                        <xsl:value-of select="substring(@ref, 2)"/>
                        <xsl:text>',300,500);</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                        <xsl:value-of
                            select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPlace/tei:place[@xml:id = substring(current()/@ref, 2)]/tei:placeName"/>
                        <xsl:text> </xsl:text>
                        <xsl:if
                            test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPlace/tei:place[@xml:id = substring(current()/@ref, 2)]/tei:placeName/tei:nameLink">
                            <xsl:text> </xsl:text>
                            <xsl:value-of
                                select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPlace/tei:place[@xml:id = substring(current()/@ref, 2)]/tei:placeName/tei:nameLink"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>

            <xsl:when test="@type = 'event'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation('ebooks/ed000532','register/register-event.xml','show_event.xsl','</xsl:text>
                        <xsl:value-of select="substring(@ref, 2)"/>
                        <xsl:text>',300,500);</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                        <xsl:value-of
                            select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listEvent/tei:event[@xml:id = substring(current()/@ref, 2)]/tei:label"/>
                        <xsl:text> </xsl:text>
                        <xsl:if
                            test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listEvent/tei:event[@xml:id = substring(current()/@ref, 2)]/tei:label/tei:nameLink">
                            <xsl:text> </xsl:text>
                            <xsl:value-of
                                select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listEvent/tei:event[@xml:id = substring(current()/@ref, 2)]/tei:label/tei:nameLink"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>


            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>


    <xsl:template match="tei:graphic">
        <div style="position:relative;">
            <div>
                <a>
                    <xsl:attribute name="name">
                        <xsl:text>img</xsl:text>
                        <xsl:number level="any"/>
                    </xsl:attribute>
                    <xsl:text></xsl:text>
                </a>
                <img border="0">
                    <xsl:attribute name="src">
                        <xsl:text>http://diglib.hab.de/ebooks/ed000738/</xsl:text>
                        <xsl:value-of select="substring-after(@url, '../')"/>
                    </xsl:attribute>
                    <xsl:if test="@width">
                        <xsl:attribute name="width">
                            <xsl:value-of select="@width"/>
                        </xsl:attribute>
                    </xsl:if>
                </img>

            </div>
        </div>

    </xsl:template>
    <xsl:template match="tei:bibl/tei:ref">
        <xsl:choose>

            <xsl:when test="@type = 'bibliography'">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>javascript:show_annotation('ebooks/ed000532','register/register-bibl.xml','show_bibl.xsl','</xsl:text>
                        <xsl:value-of select="substring(@target, 2)"/>
                        <xsl:text>',300,500);</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="class">
                        <xsl:text>bibl</xsl:text>
                        <xsl:text> </xsl:text>
                    </xsl:attribute>

                    <xsl:attribute name="title">
                        <xsl:value-of
                            select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl/tei:bibl[@xml:id = substring(current()/@ref, 2)]"/>
                        <xsl:text> </xsl:text>
                        <xsl:if
                            test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl/tei:bibl[@xml:id = substring(current()/@ref, 2)]/tei:nameLink">
                            <xsl:text> </xsl:text>
                            <xsl:value-of
                                select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl/tei:bibl[@xml:id = substring(current()/@ref, 2)]/tei:nameLink"/>
                            <xsl:text> </xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </a>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
