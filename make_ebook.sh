#!/bin/bash

height=2550 #3840 for kindle fire
width=1650 #2400 for kindle fire

### make xhtml files
rm -f $PWD/OEBPS/world_ebook-page*.xhtml
ls $PWD/OEBPS/*.jpg | while read file; do
cat > $PWD/OEBPS/world_ebook-page$(echo ${file} | grep -Eo "[[:digit:]]+").xhtml <<- EOM
<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops">
  <head>
    <meta name="viewport" content="width=${width}, height=${height}"/>
    <title>GClub World Atlas</title>
    <link href="style.css" type="text/css" rel="stylesheet"/>
  </head>
  <body>
    <div class="page">
      <img class="country" src="$(basename ${file})" alt="$(basename ${file%.*})"/>
    </div>
  </body>
</html>
EOM
done

### make style.css
cat > $PWD/OEBPS/style.css <<- EOM
body{height:${height}; width:${width}; margin:0; padding:0; text-align:center}
img{position:absolute; margin:0; padding:0; z-index:0;}
a{color:black !important; cursor:pointer; text-decoration:none;}
a:hover{color:#333;}
h1{font-size:16pt;}
li{font-size:16pt;}
ul{list-style:none;}
EOM

### make mimetype
printf "application/epub+zip" > $PWD/mimetype

### make container.xml file
cat > $PWD/META-INF/container.xml <<- EOM
<?xml version="1.0"?>
<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
  <rootfiles>
    <rootfile full-path="OEBPS/content.opf"
     media-type="application/oebps-package+xml"/>
  </rootfiles>
</container>
EOM

### make opf file
cat > $PWD/OEBPS/content.opf <<- EOM
<?xml version="1.0" encoding="UTF-8"?>
<package xmlns="http://www.idpf.org/2007/opf" version="3.0" xml:lang="en" prefix="rendition: http://www.idpf.org/vocab/rendition/#" unique-identifier="BookId">
  <metadata xmlns:opf="http://www.idpf.org/2007/opf" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/">
    <dc:identifier id="BookId">978-1-7773458-1-5</dc:identifier>
    <dc:title>GClub World Atlas</dc:title>
    <dc:language>en</dc:language>
    <meta property="dcterms:modified">2020-09-19T00:00:00Z</meta>
    <meta property="rendition:layout">pre-paginated</meta>
    <meta property="rendition:orientation">portrait</meta>
    <meta name="original-resolution" content="${width}x${height}"/>
  </metadata>
  <manifest>
    <item id="stylesheet" href="style.css" media-type="text/css"/>
    <item id="nav-html" href="nav.xhtml" properties="nav" media-type="application/xhtml+xml"/>
EOM
ls $PWD/OEBPS/*.xhtml | grep -v ".*nav.xhtml" | xargs -n1 basename | while read page; do
  echo '    <item id="'${page%.*}'-xhtml" href="'${page}'" media-type="application/xhtml+xml"/>' >> $PWD/OEBPS/content.opf
done
ls $PWD/OEBPS/*.xhtml | grep -v ".*nav.xhtml" | xargs -n1 basename | while read page; do
  echo '    <item id="'${page%.*}'-img" href="'${page%.*}'.jpg" media-type="image/jpeg"/>' >> $PWD/OEBPS/content.opf
done
cat >> $PWD/OEBPS/content.opf <<- EOM
    <item id="ncx" href="toc.ncx" media-type="application/x-dtbncx+xml"/>
  </manifest>
  <spine toc="ncx">
    <itemref idref="nav-html" properties="page-spread-left"/>
EOM
counter=1
ls $PWD/OEBPS/*.xhtml | grep -v ".*nav.xhtml" | xargs -n1 basename | while read page; do
  if [ $((counter%2)) -eq 0 ]
    then
      echo '    <itemref idref="'${page%.*}'-xhtml" properties="page-spread-left"/>' >> $PWD/OEBPS/content.opf
    else
      echo '    <itemref idref="'${page%.*}'-xhtml" properties="page-spread-right"/>' >> $PWD/OEBPS/content.opf
  fi
  ((counter=counter+1))
done
cat >> $PWD/OEBPS/content.opf <<- EOM
  </spine>
</package>
EOM

### make nav.xhtml -- customize list
cat > $PWD/OEBPS/nav.xhtml <<- EOM
<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops">
  <head>
    <title>GClub World Atlas</title>
    <meta name="viewport" content="width=${width}, height=${height}"/>
    <link href="style.css" type="text/css" rel="stylesheet"/>
  </head>
  <body>
    <section class="frontmatter TableOfContents" epub:type="frontmatter toc">
      <header><h1>Table of Contents</h1></header>
      <nav xmlns:epub="http://www.idpf.org/2007/ops" epub:type="toc" id="toc">
        <ul>
          <li><a href="world_ebook-page003.xhtml">North America</a></li>
          <li><a href="world_ebook-page035.xhtml">South America</a></li>
          <li><a href="world_ebook-page055.xhtml">Europe</a></li>
          <li><a href="world_ebook-page086.xhtml">Africa</a></li>
          <li><a href="world_ebook-page107.xhtml">Asia</a></li>
          <li><a href="world_ebook-page189.xhtml">Oceania</a></li>
          <li><a href="world_ebook-page194.xhtml">Country Guide</a></li>
        </ul>
      </nav>
      <nav epub:type="page-list" hidden="">
        <ul>
EOM
counter=1
ls $PWD/OEBPS/*.xhtml | grep -v ".*nav.xhtml" | xargs -n1 basename | while read page; do
  echo '          <li><a href="'${page}'">'${counter}'</a></li>' >> $PWD/OEBPS/nav.xhtml
  ((counter=counter+1))
done
cat >> $PWD/OEBPS/nav.xhtml <<- EOM
        </ul>
      </nav>
    </section>
  </body>
</html>
EOM

### make toc.ncx -- customize list
cat > $PWD/OEBPS/toc.ncx <<- EOM
<?xml version="1.0" encoding="utf-8"?>
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1">
  <head>
    <meta name="dtb:uid" content="978-1-7773458-1-5"/>
    <meta name="dtb:depth" content="1"/>
    <meta name="dtb:totalPageCount" content="0"/>
    <meta name="dtb:maxPageNumber" content="0"/>
  </head>
  <docTitle><text>GClub World Atlas</text></docTitle>
  <docAuthor><text>Kim, Steven</text></docAuthor>
  <navMap>
    <navPoint class="chapter" id="chapter1" playOrder="1">
      <navLabel><text>North America</text></navLabel>
      <content src="world_ebook-page003.xhtml"/>
    </navPoint>
    <navPoint class="chapter" id="chapter2" playOrder="2">
      <navLabel><text>South America</text></navLabel>
      <content src="world_ebook-page035.xhtml"/>
    </navPoint>
    <navPoint class="chapter" id="chapter3" playOrder="3">
      <navLabel><text>Europe</text></navLabel>
      <content src="world_ebook-page055.xhtml"/>
    </navPoint>
    <navPoint class="chapter" id="chapter4" playOrder="4">
      <navLabel><text>Africa</text></navLabel>
      <content src="world_ebook-page086.xhtml"/>
    </navPoint>
    <navPoint class="chapter" id="chapter5" playOrder="5">
      <navLabel><text>Asia</text></navLabel>
      <content src="world_ebook-page107.xhtml"/>
    </navPoint>
    <navPoint class="chapter" id="chapter6" playOrder="6">
      <navLabel><text>Oceania</text></navLabel>
      <content src="world_ebook-page189.xhtml"/>
    </navPoint>
    <navPoint class="chapter" id="chapter7" playOrder="7">
      <navLabel><text>Country Guide</text></navLabel>
      <content src="world_ebook-page194.xhtml"/>
    </navPoint>
  </navMap>
</ncx>
EOM

### make epub (zip)
zip -X0 world_ebook.epub mimetype
zip -Xr world_ebook.epub OEBPS/ META-INF/
