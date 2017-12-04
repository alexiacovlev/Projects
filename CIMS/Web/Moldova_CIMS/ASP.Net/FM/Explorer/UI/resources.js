function ResourceLabel(a,b){this.Title=a;this.ResourceKey=(b!=null)?b:""}function _getTitle(a){return a.getAttribute("title")}function _getLocalizedLabel(a){if(a==null){return new ResourceLabel("","")}else{return new ResourceLabel(a.getAttribute("title"),a.getAttribute("reskey"))}}function _setLocalizedLabel(c,b,a){if(b==null){return}if(a!=null){c=getNodeOrCreate(c.ownerDocument,c,a)}c.setAttribute("title",b.Title);if(b.ResourceKey!=""){c.setAttribute("reskey",b.ResourceKey)}else{c.removeAttribute("reskey")}}function _setLocalizedTitle(a,b){a.setAttribute("title",b)}function ResourceLabel_Load(a){if(a!=null){frmDialog.Title.value=a.Title;frmDialog.Title.defaultValue=a.Title}if(a!=null&&a.ResourceKey!=""){frmDialog.ResKey.value=a.ResourceKey;frmDialog.ResKey.defaultValue=a.ResourceKey}else{frmDialog.ResKey.value="[auto]";frmDialog.ResKey.defaultValue="[auto]";frmDialog.ResKey.disabled=true;frmDialog.ResKeyEnabled.checked=false}frmDialog.Title.focus()}function ResourceLabel_Save(){var b=frmDialog.Title.value=Trim(frmDialog.Title.value);if(b.indexOf('"')>-1||b.indexOf("'")>-1||b.indexOf("\\")>-1||b.indexOf("&")>-1||b.indexOf("|")>-1||b.indexOf("<")>-1){alert("The title cannot contain any of the following characters: \" ' \\ & | <");frmDialog.Title.select();return null}var a=new ResourceLabel(b,"");if(frmDialog.ResKey.value!=""&&frmDialog.ResKey.value!="[auto]"){a.ResourceKey=frmDialog.ResKey.value}return a};