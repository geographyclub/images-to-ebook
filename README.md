# images-to-ebook

## Introduction

This script is used to make the ebook (epub) version of GClub World Atlas. Each page is exported as an image then built into epub structured documents.

## Files

[make_ebook.sh](https://github.com/geographyclub/images-to-ebook/blob/master/make_ebook.sh) -- creates the xhtml, navigation and other files.

[mimetype](https://github.com/geographyclub/images-to-ebook/blob/master/mimetype) -- identifies this as an epub document.

[OEBPS/content.opf](https://github.com/geographyclub/images-to-ebook/OEBPS/blob/master/content.opf) -- metadata.

[OEBPS/nav.xhtml](https://github.com/geographyclub/images-to-ebook/OEBPS/blob/master/nav.xhtml) -- navigation document.

[OEBPS/style.css](https://github.com/geographyclub/images-to-ebook/OEBPS/blob/master/style.css) -- stylesheet.

[OEBPS/toc.ncx](https://github.com/geographyclub/images-to-ebook/OEBPS/blob/master/toc.ncx) -- navigation document.

[META-INF/container.xml](https://github.com/geographyclub/images-to-ebook/META-INF/blob/master/container.xml) -- points to content.opf.

