(function(){var a=Handlebars.template,b=Handlebars.templates=Handlebars.templates||{};b.app=a(function(a,b,c,d,e){c=c||a.helpers;var f="",g,h=this,i="function",j=c.helperMissing,k=void 0,l=this.escapeExpression;return f+="<p>",g=c.album||b.album,g=g.artist,typeof g===i?g=g.call(b,{hash:{}}):g===k&&(g=j.call(b,"album.artist",{hash:{}})),f+=l(g)+" — <strong>",g=c.album||b.album,g=g.name,typeof g===i?g=g.call(b,{hash:{}}):g===k&&(g=j.call(b,"album.name",{hash:{}})),f+=l(g)+"</strong> (",g=c.album||b.album,g=g.released,typeof g===i?g=g.call(b,{hash:{}}):g===k&&(g=j.call(b,"album.released",{hash:{}})),f+=l(g)+")</p>",f})})()