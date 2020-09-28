# images-to-ebook

## Introduction

These files are used to make the ebook (epub3) version of GClub World Atlas. Each page of the book is exported as an image in Scribus then inserted into epub structured documents via the make_ebook script.

## Files

[make_ebook.sh](https://github.com/geographyclub/images-to-ebook/blob/master/make_ebook.sh) -- creates the xhtml, navigation and other files.

[mimetype](https://github.com/geographyclub/images-to-ebook/blob/master/mimetype) -- identifies this as an epub document.

[OEBPS/content.opf](https://github.com/geographyclub/images-to-ebook/blob/master/OEBPS/content.opf) -- metadata.

[OEBPS/nav.xhtml](https://github.com/geographyclub/images-to-ebook/blob/master/OEBPS/nav.xhtml) -- navigation document.

[OEBPS/style.css](https://github.com/geographyclub/images-to-ebook/blob/master/OEBPS/style.css) -- stylesheet.

[OEBPS/toc.ncx](https://github.com/geographyclub/images-to-ebook/blob/master/OEBPS/toc.ncx) -- navigation document.

[META-INF/container.xml](https://github.com/geographyclub/images-to-ebook/blob/master/META-INF/container.xml) -- points to content file.

