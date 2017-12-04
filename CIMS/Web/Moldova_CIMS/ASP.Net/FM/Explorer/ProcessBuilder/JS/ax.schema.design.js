// Process Builder Client Script Library
// Alfa-XP, Michael Isipciuc, 2016.
//
FMS.DesignerItem=function(d,c,a,e){this.schema=d;this.box=c;this.index=a;this.xn=e;FMS.CreateUIActivity(this);this.portsBusy=[];for(var b=0;b<this.ports.length;b++){this.portsBusy.push(false)}this.freePortIndexes=[];this.connectionsIn=[];this.connectionsOut=[];this.initText()};FMS.DesignerItem.prototype={initText:function(){this.text_width=null;if(!this.box.text){this.lines=null;return}var d=this.box.w;var j=this.box.h;if(d<=80){this.text_x=this.box.text_x;this.text_y=this.box.text_y;this.lines=null;this.text_width=this.box.text.length*6.5;return}this.text_x=this.box.cx;this.text_y=this.box.cy+4;var g=this.box.text;var b=20;if(g.length<=b){this.lines=[g]}else{this.lines=[];var f=g.split(" ");var c=g="";var a=f.length;for(var e=0;e<a;e++){if(g.length>0){g+=" "}g+=f[e];if(g.length>b){this.lines.push(c);g=c=f[e];if(this.lines.length==4){break}}else{c=g}if(e==a-1){this.lines.push(c)}}this.text_y-=this.lines.length/2*8;if(this.lines.length>2){this.text_y-=6}if(this.lines.length>3){this.text_y-=5}}},drawText:function(){if(!this.box.text){return}var b=this.schema.context;b.font="10pt Tahoma";b.fillStyle="#000000";if(this.lines){b.textAlign="center";for(var a=0;a<this.lines.length;a++){b.fillText(this.lines[a],this.box.x+this.text_x,this.box.y+this.text_y+a*18)}}else{b.textAlign="left";b.fillText(this.box.text,this.box.x+this.text_x,this.box.y+this.text_y)}},addConnection:function(a,b,c){if(this.index==b&&a==c){return}var e={sourcePort:a,targetIndex:b,targetPort:c};var d=new FMS.ConnectionLine(this,e);this.connectionsOut.push(d);this.resetConnections();this.changed=true},deleteConnections:function(){for(var a=0;a<this.connectionsOut.length;a++){this.connectionsOut[a].clearTarget()}this.connectionsOut=[];for(var a=0;a<this.connectionsIn.length;a++){this.connectionsIn[a].clearSource()}this.connectionsIn=[]},draw:function(b){this.ui.draw(this.schema.context,this.box,b);for(var a=0;a<this.connectionsOut.length;a++){this.connectionsOut[a].drawIcons()}this.drawText()},drawSelectionRect:function(b){var e=this.schema.context;e.setLineDash([4,3]);e.lineWidth=1;e.drawRect(this.box.x-6.5,this.box.y-6.5,this.box.w+14,this.box.h+14,null,"red");if(b){var c=this.box.x+this.box.cx;var f=this.box.y+this.box.cy;var a=this.box.x+this.text_x;var d=this.box.y+this.text_y-2;e.setLineDash([1,2]);e.drawLine(c,f,a,d,"red")}e.setLineDash([])},drawPorts:function(c){var b=this.schema.context;if(c){if(this.connectionsIn.length>=this.maxIn){return}}else{if(this.connectionsOut.length>=this.maxOut){return}}b.lineWidth=1;for(var a=0;a<this.ports.length;a++){var d=this.ports[a];if(this.portsBusy[a]){continue}b.drawRect(this.box.x+d.x-3.5,this.box.y+d.y-3.5,7,7,"#c8d2ea","#4b4ca5")}},drawActivePort:function(b){var a=this.schema.context;a.drawRect(this.box.x+b.x-4,this.box.y+b.y-4,8,8,"red",null)},move:function(b,a){this.box.x+=b;this.box.y+=a;this.resetConnections();this.changed=true},resetConnections:function(){for(var a=0;a<this.connectionsOut.length;a++){this.connectionsOut[a].reset()}for(var a=0;a<this.connectionsIn.length;a++){this.connectionsIn[a].reset();this.connectionsIn[a].sourceItem.changed=true}},lockPort:function(b){var a=this.ports[b];this.portsBusy[b]=true;return a},releasePort:function(a){this.portsBusy[a.i]=false},detectPort:function(g,e){var j=5;var d=this.box.x;var c=this.box.y;for(var b=0;b<this.ports.length;b++){var a=this.ports[b];var h=d+a.x;var f=c+a.y;if(g>=h-j&&g<=h+j&&e>=f-j&&e<=f+j){if(this.portsBusy[b]){return null}return a}}return null},highliteConnections:function(a){for(var b=0;b<this.connectionsOut.length;b++){this.connectionsOut[b].draw(false,a,"#FF0000")}for(var b=0;b<this.connectionsIn.length;b++){this.connectionsIn[b].draw(false,a,"#FF0000")}},isLabelClicked:function(a,f){if(!this.text_width){return false}var c=this.box.x+this.text_x-3;var e=this.box.y+this.text_y-12;var b=this.text_width+6;var d=15;return(a>=c&&a<=c+b&&f>=e&&f<=e+d)},moveLabel:function(b,a){this.text_x=this.box.text_x=this.text_x+b;this.text_y=this.box.text_y=this.text_y+a;this.changed=true},allowOutConn:function(){return(this.connectionsOut.length<this.maxOut)},getCenterPort:function(a){return(this.ports.length==12)?a*3+1:a}};FMS.ConnectionLine=function(a,b){this.item=a;this.sourceItem=a;this.schema=a.schema;this.isauto=true;if(b){this.targetItem=this.schema.items[b.targetIndex];this.targetItem.connectionsIn.push(this);this.sourcePort=this.sourceItem.lockPort(b.sourcePort);this.targetPort=this.targetItem.lockPort(b.targetPort);this.title_x=b.title_x||0;this.title_y=b.title_y||0;this.setTitle(b.title);this.type=b.type;this.istimeout=(b.type=="timeout");this.action=b.action?b.action:null;this.level=b.level||0;if(b.points){this.deserializePoints(b.points)}else{this.reset();a.changed=true}}else{this.targetItem=null;this.setTitle(null);this.points=[]}};FMS.ConnectionLine.prototype={reset:function(){this.points=this.autoCreatePoints()},setTitle:function(a){this.title=a;if(this.title){this.title_width=(a.length>3)?6.15*a.length+3:20}else{this.title_width=0}},clearSource:function(){this.sourceItem.changed=true;var a=this.sourceItem.connectionsOut.indexOf(this);this.sourceItem.connectionsOut.splice(a,1);this.sourceItem.releasePort(this.sourcePort)},clearTarget:function(){var a=this.targetItem.connectionsIn.indexOf(this);this.targetItem.connectionsIn.splice(a,1);this.targetItem.releasePort(this.targetPort)},getMarginPoint:function(d,b,a){var c;switch(d){case 0:c={x:b.x,y:b.y-a};break;case 1:c={x:b.x+a,y:b.y};break;case 2:c={x:b.x,y:b.y+a};break;case 3:c={x:b.x-a,y:b.y};break}return c},autoCreatePoints:function(){var m=this.sourceItem;var b=this.targetItem;var a=this.sourcePort;var d=this.targetPort;var n={x:m.box.x+a.x,y:m.box.y+a.y};var i={x:b.box.x+d.x,y:b.box.y+d.y};this.p_start=n;var h=a.pos;var g=d.pos;var l=this.getMarginPoint(h,n,12);var k=this.getMarginPoint(g,i,18);var j=[];j.push(this.getMarginPoint(h,n,3));j.push(l);if(k.x!=l.x){var e=(k.x>l.x);var c=2;if(k.y>l.y){switch(h){case 0:c=-1;if(g==2){c=3}break;case 1:if(g==0){c=e?-1:2}else{if(g==1){c=e?-1:1}else{if(g==2){c=1}else{if(g==3){c=e?3:2}}}}break;case 2:if(g==1){c=e?2:1}else{if(g==2){c=1}else{if(g==3){c=e?1:2}}}break;case 3:if(g==0){c=e?1:-1}else{if(g==1){c=e?2:1}else{if(g==2){c=1}else{if(g==3){c=e?1:-1}}}}break}}else{if(k.y<l.y){if(g==0){c=3}switch(h){case 0:c=1;if(g==1&&e){c=2}else{if(g==2){c=2}else{if(g==3&&!e){c=2}}}break;case 1:if(g==0){c=1}else{if(g==1){c=e?-1:1}else{if(g==2){c=e?-1:2}else{if(g==3){c=e?3:2}}}}break;case 2:c=-1;if(g==0){c=3}break;case 3:if(g==0){c=1}else{if(g==1){c=e?2:3}else{if(g==2){c=e?2:-1}else{if(g==3){c=e?1:-1}}}}break}}}switch(c){case -1:l={x:k.x,y:l.y};j.push(l);break;case 1:l={x:l.x,y:k.y};j.push(l);break;case 2:var f=l.y+Math.round((k.y-l.y)/2.4);l={x:l.x,y:f};j.push(l);l={x:k.x,y:f};j.push(l);break;case 3:l={x:l.x+Math.round((k.x-l.x)/2.4),y:l.y};j.push(l);l={x:l.x,y:k.y};j.push(l);break}}j.push(k);j.push(this.getMarginPoint(g,i,8));return j},draw:function(g,k,j,o){var r=this.points;var d=this.schema.context;if(g){d.setLineDash([8,4])}var f=FMS.levels[this.level];if(g){f="#636cad"}else{if(k){f=j?j:"#333333"}}d.strokeStyle=f;d.lineWidth=2;d.beginPath();var s=r[0];d.moveTo(s.x,s.y);for(var h=1;h<r.length;h++){var q=r[h];d.lineTo(q.x,q.y);d.stroke()}var c=r[r.length-1];var e=FMS.arrows[this.targetPort.pos];d.beginPath();d.moveTo(c.x+e[0],c.y+e[1]);d.lineTo(c.x+e[2],c.y+e[3]);d.lineTo(c.x+e[4],c.y+e[5]);d.closePath();d.fillStyle=f;d.fill();if(g){d.setLineDash([]);var b=this.sourceItem.box.x+this.sourcePort.x;var n=this.sourceItem.box.y+this.sourcePort.y;var a=this.targetItem.box.x+this.targetPort.x;var l=this.targetItem.box.y+this.targetPort.y;d.lineWidth=1;d.drawRect(b-4.5,n-4.5,10,10,"#e7e7e7","#1e90ff");d.drawRect(a-4.5,l-4.5,10,10,"#e7e7e7","#1e90ff")}if(this.title){d.font="10pt Calibri";d.textAlign="left";d.fillStyle=o?"red":"#808080";d.fillText(this.title,s.x+this.title_x,s.y+this.title_y+10);if(o){this.drawLableLine()}}},drawShadow:function(){var c=this.points;var b=this.schema.context;b.strokeStyle="#dce2e8";b.lineWidth=2;b.beginPath();var e=c[0];b.moveTo(e.x+5,e.y+5);for(var a=1;a<c.length;a++){var d=c[a];b.lineTo(d.x+5,d.y+5);b.stroke()}},drawIcons:function(){if(this.istimeout){this.schema.context.drawImage(FMS.Image.ico_clock,this.p_start.x-8,this.p_start.y-8,16,16)}else{if(this.action){this.schema.context.drawImage(FMS.Image.ico_action,this.p_start.x-5,this.p_start.y-5,10,10)}}},drawSelected:function(a){this.draw(true,false,null,a)},containsPixel:function(f,e){var k=5;var j=null;for(var b=0;b<this.points.length;b++){var a=this.points[b];var d=f>=a.x-k&&f<=a.x+k;var c=e>=a.y-k&&e<=a.y+k;if(d||c){if(d&&c){return true}if(!j){j=[]}j.push(a)}}if(j&&j.length>1){var h=j[0];for(var b=1;b<j.length;b++){var g=j[b];if(g.x==h.x){var d=f>=g.x-k&&f<=g.x+k;if(d&&(e>g.y&&e<h.y||e>h.y&&e<g.y)){return true}}else{var c=e>=g.y-k&&e<=g.y+k;if(c&&(f>g.x&&f<h.x||f>h.x&&f<g.x)){return true}}}}return false},isPortClicked:function(a,g){var c=5;var d=this.sourceItem.box.x+this.sourcePort.x;var f=this.sourceItem.box.y+this.sourcePort.y;var b=this.targetItem.box.x+this.targetPort.x;var e=this.targetItem.box.y+this.targetPort.y;if(a>=d-c&&a<=d+c&&g>=f-c&&g<=f+c){this.dragMode=1;this.dragFixPoint={x:b,y:e};this.dragOldPoint={x:d,y:f};return true}if(a>=b-c&&a<=b+c&&g>=e-c&&g<=e+c){this.dragMode=2;this.dragFixPoint={x:d,y:f};this.dragOldPoint={x:b,y:e};return true}return false},reconnect:function(a,c){this.sourceItem.changed=true;var b=this.sourceItem.connectionsOut.indexOf(this);var e={sourcePort:this.sourcePort.i,targetIndex:a,targetPort:c,title:this.title,title_x:this.title_x,title_y:this.title_y,type:this.type,action:this.action,level:this.level};var f=this.sourceItem;if(this.dragMode==1){if(this.sourceItem.index==a&&this.sourcePort.i==c){return null}e.sourcePort=c;e.targetIndex=this.targetItem.index;e.targetPort=this.targetPort.i;if(this.sourceItem.index!=a){f=this.schema.items[a];e.action=null}}else{if(this.targetItem.index==a&&this.targetPort.i==c){return null}}this.clearSource();this.clearTarget();var d=new FMS.ConnectionLine(f,e);f.connectionsOut.splice(b,0,d);f.resetConnections();return d},isTitleClicked:function(a,f){if(!this.title){return false}var c=this.sourceItem.box.x+this.sourcePort.x+this.title_x-3.5;var e=this.sourceItem.box.y+this.sourcePort.y+this.title_y-2.5;var b=this.title_width+6;var d=15;return(a>=c&&a<=c+b&&f>=e&&f<=e+d)},moveLabel:function(b,a){this.sourceItem.changed=true;this.title_x+=b;this.title_y+=a},drawLableLine:function(){var d=this.points[0];var a=this.sourceItem.box.x+this.sourcePort.x+this.title_x+2;var c=this.sourceItem.box.y+this.sourcePort.y+this.title_y+7;var b=this.schema.context;b.setLineDash([1,2]);b.lineWidth=1;b.drawLine(d.x,d.y,a,c,"red");b.setLineDash([])},deserializePoints:function(c){this.points=[];var b=c.split(";");if(b.length>0){var d=b[0].split(":");this.p_start={x:parseInt(d[0]),y:parseInt(d[1])};for(var a=1;a<b.length;a++){d=b[a].split(":");this.points.push({x:parseInt(d[0]),y:parseInt(d[1])})}}},serializePoints:function(){if(this.points.length==0){return""}var b=this.p_start.x+":"+this.p_start.y;for(var a=0;a<this.points.length;a++){b+=";"+this.points[a].x+":"+this.points[a].y}return b}};FMS.ConnectionLine.drawNew=function(g){var d=g.context;var f=g.selectedItem.box;var h=g.selectedPort;var b=f.x+h.x;var e=f.y+h.y;var a=g.mouseX;var c=g.mouseY;g.selectedItem.drawActivePort(h);d.beginPath();d.moveTo(b,e);d.lineTo(a,c);d.strokeStyle="#636cad";d.setLineDash([5,4]);d.lineWidth=2;d.stroke();d.closePath();d.setLineDash([]);d.drawRect(a-4,c-4,8,8,"#4b4ca5",null)};FMS.ConnectionLine.drawModified=function(f){var d=f.context;var g=f.dragConn.dragFixPoint;var b=g.x;var e=g.y;var a=f.mouseX;var c=f.mouseY;var h=f.dragConn.dragOldPoint;d.lineWidth=1;d.drawRect(h.x-3.5,h.y-3.5,7,7,"#FFFFFF","#4b4ca5");d.beginPath();d.moveTo(b,e);d.lineTo(a,c);d.strokeStyle="#636cad";d.setLineDash([5,4]);d.lineWidth=2;d.stroke();d.closePath();d.setLineDash([]);d.drawRect(b-5,e-5,10,10,"#4b4ca5",null);d.drawRect(a-4,c-4,8,8,"#4b4ca5",null)};FMS.DrawPanels=function(f){var d=f.context;var g=0;d.strokeStyle="#94b0cd";d.fillStyle="#FFFFFF";d.lineWidth=1;var b=f.panels;for(var c=0;c<b.length;c++){var a=b[c];var e=a.height-2;d.beginPath();d.roundRect(0,g+0.5,f.canvasWidth,e,{upperLeft:6,lowerLeft:6},true,true);d.moveTo(25+0.5,g);d.lineTo(25+0.5,g+e);d.stroke();d.closePath();g=a.bottomY=g+a.height+2}d.save();d.rotate(-0.5*Math.PI);d.font="10pt Arial";d.fillStyle="#000000";d.textAlign="left";for(var c=0;c<b.length;c++){var a=b[c];d.fillText(a.title,-a.bottomY+8,18)}d.restore()};FMS.zoom=function(c,a){if(c.frameElement){if(a==0){if(c.scale<1){c.scale=1}else{var d=0.75;var b=c.frameElement.parentNode.offsetWidth;if(b<c.canvasWidth){d=Math.round(100*b/c.canvasWidth)/100}c.scale=d}}var d=c.scale+a;if(d<0.5){d=0.5}if(d>1){d=1}c.scale=d;c.frameElement.style.cssText="width:"+c.canvasWidth+"px;height:"+c.canvasHeight+"px;-ms-zoom: "+c.scale+";-ms-transform-origin: 0 0; -webkit-transform:scale("+c.scale+");-webkit-transform-origin: 0 0; -moz-transform: scale("+c.scale+");-moz-transform-origin: 0 0;";$($(c.designer.zoomPanel).children()[1]).text(""+Math.round(100*d)+"%")}};FMS.SchemaPanel=function(a){this.xn=a;this.title=a.getAttribute("title");this.height=parseInt(a.getAttribute("height"))};FMS.CreateSchemaBox=function(a){return{name:a.getAttribute("name"),text:a.getAttribute("title"),text_x:parseInt(a.getAttribute("textLeft")||"0"),text_y:parseInt(a.getAttribute("textTop")||"0"),type:a.getAttribute("type"),x:parseInt(a.getAttribute("left")),y:parseInt(a.getAttribute("top")),handler:a.getAttribute("ui")}};FMS.CreateSchemaConnections=function(n,e){var o=n.xn.childNodes;for(var g=0;g<o.length;g++){var h=o[g];if(h.nodeName=="connection"){var m=h.getAttribute("sink");var b=e[m];if(!b){continue}var c=h.getAttribute("port");if(!c){return[]}var d=parseInt(c);var j=parseInt(h.getAttribute("sinkPort"));var a={sourcePort:d,targetIndex:b,targetPort:j,type:h.getAttribute("type"),action:h.getAttribute("action"),points:h.getAttribute("points")};var k=h.getAttribute("title");if(k){a.title=k;a.title_x=parseInt(h.getAttribute("textLeft"));a.title_y=parseInt(h.getAttribute("textTop"))}var f=h.getAttribute("level");if(f){a.level=parseInt(f)}n.connectionsOut.push(new FMS.ConnectionLine(n,a))}}};insertToArray=function(b,a,c){b.splice(a,0,c)};FMS.levels=["#888888","#2cc937","#009cf0","#a9ac64","#af6361"];FMS.arrows=[[+4,-3,0,+5,-4,-3],[+5,+4,-3,0,+5,-4],[+4,+3,0,-5,-4,+3],[-3,+4,+5,0,-3,-4],];