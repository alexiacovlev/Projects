FM.NavCount=function(b){this.profile=b;this.profileName=b.$cmdBar.attr("profile");this.timerID=null;var a=b.$tabs.attr("rs");this.refreshSec=(a!=""&&a!="0")?parseInt(a):0;this._onload=$createDelegate(this.service_onload,this);this._start=$createDelegate(this.Start,this)};FM.NavCount.prototype={dispose:function(){this.clearTimer()},Prepare:function(a){if($.browser.msie&&$.browser.version<=8){this.Enabled=false;return}this.nodes=a.counting_nodes;if(!this.nodes){this.nodes=[];var e=a.getElementsByTagName("A");var f,d,b;for(var c=0;c<e.length;c++){f=e[c];d=f.getAttribute("ac");if(d==null){continue}f.initCount=-1;f.count=-1;f.n=f.getAttribute("n");f.d=f.getAttribute("data");f.play=f.getAttribute("ac_s")=="1";f.ac=d;f.l=f.firstChild.nextSibling;f.txt=f.l.textContent;this.nodes.push(f)}a.counting_nodes=this.nodes}else{for(var c=0;c<this.nodes.length;c++){this.nodes[c].initCount=-1;this.nodes[c].changed=false}}this.Enabled=(this.nodes.length>0);this.inProgress=false;this.Start()},Start:function(){if(!this.Enabled||this.inProgress){return}this.inProgress=true;this.audio=false;this.index=-1;this.clearTimer();this._sel=this.profile._node[0];this.input=this.profile.inputParameters;this.groupName=this.profile.groupName;this.ProcessNextNode()},Done:function(){this.inProgress=false;window.status="done";window.status="";if(this._needToPlayAudio){FM.NavCount.Audio_Play();this._needToPlayAudio=false}if(this.refreshSec>0&&this.timerID==null){if(App.isLocked){return}this.timerID=window.setTimeout(this._start,this.refreshSec*1000)}},clearTimer:function(){if(this.timerID!=null){window.clearTimeout(this.timerID);this.timerID=null}},Stop:function(){this.nodes=null;this._current=null;this.clearTimer()},ProcessNextNode:function(){if(!this.nodes){return}this.index++;if(this.index<this.nodes.length){var c=this.nodes[this.index];this._current=c;var b=c.n;var a=this.input;if(c.d){a+=(a!=""?",":"")+c.d}window.status="Request records count for folder '"+b+"' ...";c.l.textContent=c.txt+" (..)";var d='{"p":"'+this.profileName+'","g":"'+this.groupName+'","f":"'+b+'","input":"'+a+'"}';fmExecuteService("DataViewer/Profile/CountService.asmx/Get",d,this._onload)}else{this.Done()}},service_onload:function(c){var b=this._current;if(b){if(b.initCount==-1||b==this._sel){b.initCount=c.d}var a=c.d-b.initCount;this._current=null;if(a!=0&&b.count!=c.d&&b.play){this._needToPlayAudio=true}b.count=c.d;b.l.textContent=b.txt+" ("+b.count+")"+(a!=0?(" "+(a>0?"+":"")+a):(b.changed?" *":""));if(a!=0){b.changed=true}this.ProcessNextNode()}},resetNode:function(a){a.changed=false;a.initCount=a.count;a.l.textContent=a.txt+" ("+a.count+")"}};FM.NavCount.Audio_Play=function(){var b=FM.NavCount.audio;if(!b){b=FM.NavCount.audio=document.createElement("audio");b.setAttribute("src","/ASP.Net/FM/DataViewer/Profile/sound.mp3");b.setAttribute("autoplay","autoplay")}else{b.play()}};FM.NavCount.Init=function(a){if(!a._counting){a._counting=new FM.NavCount(a)}a._counting.Prepare(a.$tree[0])};