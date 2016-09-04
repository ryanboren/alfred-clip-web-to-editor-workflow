# Clip web page to editor

This Alfred workflow clips the selected text, url, and title from the web page in the active browser window to your preferred editing app.

Set the editorapp workflow environment variable to the name of your preferred editor application. The default is Ulysses.

Edit template.txt to customize the format of the web clip.

* {title} will be replaced with the title of the web page.
* {url} will be replaced with the url/link.
* {selection} will be replaced with the selected text, if any.

The default template uses Markdown syntax.

```
# {title}

> {selection}

Source: [{title}]({url})
```