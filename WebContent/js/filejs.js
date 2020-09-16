var EmptyArrayList=new ArrayList();function ArrayList(){this.instance=new Array()}ArrayList.prototype.size=function(){return this.instance.length};ArrayList.prototype.add=function(A){this.instance[this.instance.length]=A};ArrayList.prototype.addSingle=function(A){if(!this.contains(A)){this.instance[this.instance.length]=A}};ArrayList.prototype.addAt=function(A,B){if(A>=this.size()||A<0||this.isEmpty()){this.add(B);return }this.instance.splice(A,0,B)};ArrayList.prototype.addAll=function(A){if(!A||A.length<1){return }this.instance=this.instance.concat(A)};ArrayList.prototype.addList=function(A){if(A&&A instanceof ArrayList&&!A.isEmpty()){this.instance=this.instance.concat(A.instance)}};ArrayList.prototype.get=function(A){if(this.isEmpty()){return null}if(A>this.size()){return null}return this.instance[A]};ArrayList.prototype.getLast=function(){if(this.size()<1){return null}return this.instance[this.size()-1]};ArrayList.prototype.set=function(B,D){if(B>=this.size()){throw"IndexOutOfBoundException : Index "+B+", Size "+this.size()}var A=this.instance[B];this.instance[B]=D;return A};ArrayList.prototype.removeElementAt=function(A){if(A>this.size()||A<0){return }this.instance.splice(A,1)};ArrayList.prototype.remove=function(B){var A=this.indexOf(B);this.removeElementAt(A)};ArrayList.prototype.contains=function(A,B){return this.indexOf(A,B)>-1};ArrayList.prototype.indexOf=function(D,E){for(var A=0;A<this.size();A++){var B=this.instance[A];if(B==D){return A}else{if(E!=null&&B!=null&&D!=null&&B[E]==D[E]){return A}}}return -1};ArrayList.prototype.lastIndexOf=function(D,E){for(var A=this.size()-1;A>=0;A--){var B=this.instance[A];if(B==D){return A}else{if(E!=null&&B!=null&&D!=null&&B[E]==D[E]){return A}}}return -1};ArrayList.prototype.subList=function(B,E){if(B<0){B=0}if(E>this.size()){E=this.size()}var D=this.instance.slice(B,E);var A=new ArrayList();A.addAll(D);return A};ArrayList.prototype.toArray=function(){return this.instance};ArrayList.prototype.isEmpty=function(){return this.size()==0};ArrayList.prototype.clear=function(){this.instance=new Array()};ArrayList.prototype.toString=function(A){A=A||", ";return this.instance.join(A)};
function Properties(A){this.instanceKeys=new ArrayList();this.instance={};if(A){this.instance=A;for(var B in A){this.instanceKeys.add(B)}}}Properties.prototype.size=function(){return this.instanceKeys.size()};Properties.prototype.get=function(B,A){if(B==null){return null}var D=this.instance[B];if(D==null&&A!=null){return A}return D};Properties.prototype.remove=function(A){if(A==null){return null}this.instanceKeys.remove(A);delete this.instance[A]};Properties.prototype.put=function(A,B){if(A==null){return null}if(this.instance[A]==null){this.instanceKeys.add(A)}this.instance[A]=B};Properties.prototype.putRef=function(A,B){if(A==null){return null}this.instanceKeys.add(A);this.instance[A]=B};Properties.prototype.getMultilevel=function(E,B){if(E==null){return null}var D=E.split(".");function A(J,H,G){try{if(J==null||(typeof J!="object")){return null}var K=J.get(H[G]);if(G<H.length-1){K=A(K,H,G+1)}return K}catch(I){}return null}var F=A(this,D,0);return F==null?B:F};Properties.prototype.containsKey=function(A){if(A==null){return false}return this.instance[A]!=null};Properties.prototype.keys=function(){return this.instanceKeys};Properties.prototype.values=function(){var E=new ArrayList();for(var B=0;B<this.instanceKeys.size();B++){var A=this.instanceKeys.get(B);if(A){var D=this.instance[A];E.add(D)}}return E};Properties.prototype.isEmpty=function(){return this.instanceKeys.isEmpty()};Properties.prototype.clear=function(){this.instanceKeys.clear();this.instance={}};
//校验文件大小
function validateFileSize(target, vId, maxSize){
	 var fileSize = 0;
        var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
        if (isIE && !target.files) {
            var filePath = target.value;
            var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
            if (!fileSystem.FileExists(filePath)) {
                var file = document.getElementById(vId);
                file.outerHTML = file.outerHTML;
                return false;
            }
            var file = fileSystem.GetFile(filePath);
            fileSize = file.Size;
        } else {
            fileSize = target.files[0].size;
        }
        var size = fileSize / (1024 * 1024);
        if (size > maxSize) {
            alert("附件大小不能大于"+maxSize+"M!");
                var file = document.getElementById(vId);
                file.outerHTML = file.outerHTML;
            return false;
        }
        if (size <= 0) {
            alert("附件大小不能为0M！");
            var file = document.getElementById(vId);
            file.outerHTML = file.outerHTML;
            return false;
        }
        return true;
	}