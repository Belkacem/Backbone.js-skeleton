# Backbone.js [tiny] skeleton app 
### Written in CoffeeScript

#### Included libs:
Zepto (works fine with jQuery too, just using Zepto more atm)<br>
Handlebars (mustache style templates)<br>
Underscore<br>
Backbone <br>

*The libs are included as submodules too, for conveience, keeping up with the latest*

**Base collection and views class for backbone**<br>
In js/models.coffee & js/views.coffee

**Pre-rendered Handlbars templates**<br>
The templates are pre-rendered and exposed through the global object <code>Handlebars.templates.filname</code> (excluding .hb/.handlebars)<br>
Because of this we only need to include the Handlebars.vm file, and not the entire runtime.

**A handful Handlebars template helper functions**<br>
Chillin in js/app.coffee

Compiler for coffee-script and handlebars<br>
Static node.js file-server<br>

**To start the static server, and start watching for script and template changes**

    bin/backplate --- starts the compilers
    bin/backplate -s -p 8888 --- compilers with sever and optional port

Be sure to run <code>npm install</code> first, to fetch the dependencies.