# laadur

## Intro
When you are doing routine work, you may need a tool which will simplify your workflow.  
So became **laadur**.

Laadur creates a folder in your homepath (/Users/{user}/.laadur) and keeps there your templates.  
**It works via CLI. So, it can't be required in your project or smth else.**  

## Using
Before using, install it:
```sh
gem install laadur
```
So, now you are ready.  
To create your first template, you can use
```sh
laadur -o
```
which will open your **laadur** folder with finder.  

Simply create several folders there with some content.
For example, folders like:
* .laadur
  * js-files
    * jquery.js
    * jquery.min.js
    * jquery.easing.js
    * jquery.mobile.js
  * sass-snippets
    * grid.sass
    * typography.sass
    * mixins.sass
  * twitter-bootstrap
    * css
      * bootstrap-responsive.css
      * bootstrap-responsive.min.css
      * bootstrap.css
      * bootstrap.min.css
    * img
      * glyphicons-halflings-white.png
      * glyphicons-halflings.png
    * js
      * bootstrap.js
      * bootstrap.min.js

Here you go.  
Now you can get this templates from wherever you are.

Simply use:
```
laadur -l twitter-bootstrap
```

### Options
```
-v, --version                    show version
-h, --help                       help window
    --docs                       open github documentation page

-o, --open                       open laadur folder with Finder.app
    --list                       list all templates
    --folder                     print folder path

-t, --target <path>              specify target folder for copying template files (also see --home)
    --home                       use home folder as root for target option (pwd by default)
    --pwd                        return back home as pwd (useful with multiloading)
    --prt                        print target path (where files will be copied)

-s, --search <expr>              search templates with regex
    --all                        load all templates

-l, --load <template>            load template from repository
                                 you may not specify this flag
-r, --remove <template>          remove a certain template
```
