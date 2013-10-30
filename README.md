# laadur (CLI)
[![Gem Version](https://badge.fury.io/rb/laadur.png)](http://badge.fury.io/rb/laadur)[![Code Climate](https://codeclimate.com/github/rozzy/laadur.png)](https://codeclimate.com/github/rozzy/laadur)  
**[Gem on Rubygems](https://rubygems.org/gems/laadur)**
## Intro
When you are doing routine work, you may need a tool which will simplify your workflow.  
So became **laadur**.

Laadur creates a folder in your homepath (/Users/{user}/.laadur) and keeps there your templates.  
**Now it works via CLI. So, it can't be required in your project or smth else. Yet.**

## Using
[Installation](#installation)  
[Managing](#managing)  
[Search](#search)  
[Targetting](#targetting)  
[Multiloading](#multiloading)  
[Debugging](#debugging)  

#### Installation
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
![Folder structure example](http://d1zjcuqflbd5k.cloudfront.net/files/acc_127427/Rqjt?response-content-disposition=inline;%20filename=Screen%20Shot%202013-10-29%20at%2012.24.34%20PM.png;%20filename*=UTF-8%27%27Screen%20Shot%202013-10-29%20at%2012.24.34%20PM.png&Expires=1383042517&Signature=Gun9Ejh5oAcvkZMFclne-84ATu4xa9Pu1Yh4tJOnCKBw8pOTYfD2pCHMfEr7uDMDFuIxaHBt15WlcDnMjHhZeA1MNHnlK2D1dDqSldgWf7YOpgYe3ImiM3q8XiDdukyLxjpcE-kaSxkBu5kuZxAU5fuk4pTOv4o8V8WEzavhjsI_&Key-Pair-Id=APKAJTEIOJM3LSMN33SA)  
Here you go.  
Now you can get this templates from wherever you are.

Simply use:
```sh
[ ~ ]: cd blog
[ ~/blog ]: laadur -l bootstrap
```
It will load the content of `bootstrap` folder to your present working directory (pwd).  

#### Managing
You can remotely get access to some laadur data.  
Get laadur folder path: `laadur --folder`.  
Get list of all templates: `laadur --list`.  
And remove certain template: `laadur -r bootstrap`.   

#### Search
Laadur can load several templates, using regular expression.
```sh
[ ~/blog ]: laadur --list
There are 4 templates:
├ jquery
├ jquery-mobile
├ sass-mixins
└ sass-mixins-mobile
[ ~/blog ]: laadur -s *-mobile
jquery-mobile loaded!
sass-mixins-mobile loaded!
```
You can also load all templates using `--all`.

#### Targetting
By default laadur loads files to your pwd.  
If you wanna change destination folder, use `-t`/`--target`.  
##### _In version 1.0 you should specify **target** before specifying template!_
Look:
```sh
[ ~ ]: cd blog
[ ~/blog ]: laadur -t assets -l bootstrap
```
Laadur will copy the content from `.laadur/bootstrap` and paste it to the `~/blog/assets` folder. If folder doesn't exist, it will create it for you. 
If you need to choose destination folder not from pwd, you can set `--home` option, and laadur will search target folder from your home directory. 
For example:
```sh
[ ~/blog/assets/img/png/16x16 ]: laadur --home -t blog/assets -l bootstrap
```

#### Multiloading
Multiloading is disabled in the actual version, but you still can use it but in a little different way.
```sh
[ ~/blog ]: laadur -l bootstrap/css -l bootstrap/js
```

#### Debugging
If you are not sure, you can first check, where your files will be loaded to:
```sh
[ ~/blog ]: laadur --home -t another/path --prt
```
It will acts as you're going to copy.  
But `--prt` option will simply print destination path instead of copying files. 
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
