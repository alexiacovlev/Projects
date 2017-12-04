<%@ Control Language="C#" %>
<style type="text/css">
	div.app-admin-menu span {
		display:block;
		background-image: url(/ASP.Net/System/Images/admin_menu_btn.png);background-position:0px 0px;
		text-align:center;
		border-bottom:solid 1px #135f8c;
		border-right:solid 1px #135f8c;
		border-top:solid 1px #3da6e4;
		border-left:solid 1px #3da6e4;
		color:#FFF;
		line-height:18px;
	}
	
	div.app-admin-menu a {
		position:absolute;
		text-decoration:none;outline:0;
		width:150px;
		display:inline-block;cursor:pointer;
		box-shadow:1px 1px 5px #333333;-webkit-box-shadow:2px 2px 3px #383838;-moz-box-shadow:2px 2px 3px #383838;
		
		border:solid 1px #97d0f1;border-radius:3px;-webkit-border-radius:3px;moz-border-radius:3px;
	}
	div.app-admin-menu a:hover span {
		background-position:0px 21px;
		border-color:transparent;
		color:#000000;
	}
	div.app-admin-menu a:active {
		background-position:0px 42px;
		color:#012036;
	}
	
</style>
<script type="text/javascript">
	AX.AppAdminMenu = function($panel,$bg) {
		this.$panel = $panel;
		this.$bg = $bg;

		this.$menu = $("div.app-admin-menu", $panel);
		this.$bg.preventSelection();
		this.mas = this.$menu.children();
		this.count = this.mas.length;

		this.Show= function(e, show_bg) {
			var o = e.target;
			this.top = $(o).offset().top + 35;

			this.$panel.show();
			if (show_bg) this.$bg.show().css('opacity', 0).animate({ 'opacity': 0.5 }, 'fast');
			this.$menu.css({ 'top': this.top });

			for (var i = 0; i < this.count; i++) {
				var o = this.mas[i];
				var $o = $(o);
				if (!o.left) {
					o.left = $o.css('left');
					o.top = parseInt($o.css('top'));
				}
				//$o.css({ 'left': -200 }).delay(100 * i).animate({ 'left': o.left, 'top': o.top + 35 }, 200);
				$o.css({ 'left': -200 }).delay(100 * i).animate({ 'left': o.left }, 200);
			}
		}

		this.onclick = function(e) {
			var href= window.location.href;
			if (href.indexOf('/') != 0) AX.menu_location_href= href;
			var o = e.target;
			if (o.tagName == "SPAN") o= o.parentNode;
			if (o.tagName == "A") {
				this.$panel.hide();this.$bg.hide();
				var cmd = o.getAttribute("cmd");
				var data = o.getAttribute("data");
				var wnd_size = o.getAttribute("wnd_size");
				var title = $(o).text();
				this.OpenWindow(cmd, data, title, wnd_size);
			} else {
				this.Close();
			}
		}

		this.Close = function() {
			for (var i = 0; i < this.count; i++) {
				$(this.mas[i]).delay(50 * (this.count - i)).animate({ 'left': -200 }, 100);
			}
			this._clicked = null;
			var $p = this.$panel;
			var $bg = this.$bg;
			window.setTimeout(function() { $p.hide();$bg.hide() }, 500);
		}

		this.OpenWindow = function(cmd, data, title, wnd_size) {
			/*
			var wnd = new AX.Window(true);
			var onload= null;

			if (cmd == "QuickAdd") {
				onload= function() { new Portal.QuickAddDialog(wnd.$content, "", "", wnd); };
			} else {
				//onload= function() { new Portal.QuickAddDialog(wnd); };
			}
			
			var control= cmd+".ascx";
			var resources= ["/ASP.Net/WebAdmin/admin_styles.css","/ASP.Net/WebAdmin/admin_utils.js","/ASP.Net/WebAdmin/AppManager/Portal.AppManager.js"];

			
			wnd.setBackground("#898a8b");
			wnd.setHeader(title);
			wnd.parseSize(wnd_size);
			wnd.loadASCX("/ASP.Net/WebAdmin/AppManager/"+control, resources, onload);
			wnd.show();
			*/
		}

		this.$panel.addHandler('click', this.onclick, this);
		this.$bg.addHandler('click', this.Close, this);
	}</script>
<div class="app-admin-menu" style="position:absolute;width:320px;height:200px;z-index:1001;">
	<a style="left:150px;top:0px;"	href="#/TAB-NEW"					><span>Add Empty Tab</span></a>
	<a style="left:138px;top:30px;" href="#/TAB-NEW-HTML"			><span>Add Html Tab</span></a>
	<a style="left:115px;top:60px;" href="#/TAB-NEW-PROFILE"	><span>Add Navigator Tab</span></a>
	<a style="left:89px;top:90px;"	href="#/TAB-CONTENT"			><span>Modify Content</span></a>
	<a style="left:50px;top:120px;" href="#/APP-EDIT"					><span>Reorganize Tabs</span></a>
	<a style="left:10px;top:150px;" href="#/APP-SETTINGS"			><span>Application Settings</span></a>
</div>