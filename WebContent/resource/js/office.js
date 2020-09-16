var isCtpTop = true;
function StringBuffer() {
    this._strings_ = new Array()
}
StringBuffer.prototype.append = function(A) {
    if (A) {
        if (A instanceof Array) {
            this._strings_ = this._strings_.concat(A)
        } else {
            this._strings_[this._strings_.length] = A
        }
    }
    return this
};
StringBuffer.prototype.reset = function(A) {
    this.clear();
    this.append(A)
};
StringBuffer.prototype.clear = function() {
    this._strings_ = new Array()
};
StringBuffer.prototype.isBlank = function() {
    return this._strings_.length == 0
};
StringBuffer.prototype.toString = function(A) {
    A = A == null ? "": A;
    if (this._strings_.length == 0) {
        return ""
    }
    return this._strings_.join(A)
};
String.prototype.getBytesLength = function() {
    var A = this.match(/[^\x00-\xff]/ig);
    return this.length + (A == null ? 0 : A.length)
};
String.prototype.getLimitLength = function(C, F) {
    if (!C || C < 0) {
        return this
    }
    var A = this.getBytesLength();
    if (A <= C) {
        return this
    }
    F = F == null ? "..": F;
    C = C - F.length;
    var B = 0;
    var D = "";
    for (var E = 0; E < this.length; E++) {
        if (this.charCodeAt(E) > 255) {
            B += 2
        } else {
            B++
        }
        D += this.charAt(E);
        if (B >= C) {
            return D + F
        }
    }
    return this
};
String.prototype.escapeHTML = function(B, A) {
    try {
        return escapeStringToHTML(this, B, A)
    } catch(C) {}
    return this
};
String.prototype.escapeJavascript = function() {
    return escapeStringToJavascript(this)
};
String.prototype.escapeSpace = function() {
    return this.replace(/ /g, "&nbsp;")
};
String.prototype.escapeSameWidthSpace = function() {
    return this.replace(/ /g, "&nbsp;&nbsp;")
};
String.prototype.escapeXML = function() {
    return this.replace(/\&/g, "&amp;").replace(/\</g, "&lt;").replace(/\>/g, "&gt;").replace(/\"/g, "&quot;")
};
String.prototype.escapeQuot = function() {
    return this.replace(/\'/g, "&#039;").replace(/"/g, "&#034;")
};
String.prototype.startsWith = function(A) {
    return this.indexOf(A) == 0
};
String.prototype.endsWith = function(A) {
    var B = this.indexOf(A);
    return B > -1 && B == this.length - A.length
};
String.prototype.trim = function() {
    var C = this.toCharArray();
    var A = 0;
    var D = C.length;
    for (var B = 0; B < C.length; B++) {
        var E = C[B];
        if (E == " ") {
            A++
        } else {
            break
        }
    }
    if (A == this.length) {
        return ""
    }
    for (var B = C.length; B > 0; B--) {
        var E = C[B - 1];
        if (E == " ") {
            D--
        } else {
            break
        }
    }
    return this.substring(A, D)
};
String.prototype.toCharArray = function() {
    var B = [];
    for (var A = 0; A < this.length; A++) {
        B[A] = this.charAt(A)
    }
    return B
};
function ArrayList() {
    this.instance = new Array()
}
ArrayList.prototype.size = function() {
    return this.instance.length
};
ArrayList.prototype.add = function(A) {
    this.instance[this.instance.length] = A
};
ArrayList.prototype.addSingle = function(A) {
    if (!this.contains(A)) {
        this.instance[this.instance.length] = A
    }
};
ArrayList.prototype.addAt = function(A, B) {
    if (A >= this.size() || A < 0 || this.isEmpty()) {
        this.add(B);
        return
    }
    this.instance.splice(A, 0, B)
};
ArrayList.prototype.addAll = function(A) {
    if (!A || A.length < 1) {
        return
    }
    this.instance = this.instance.concat(A)
};
ArrayList.prototype.addList = function(A) {
    if (A && A instanceof ArrayList && !A.isEmpty()) {
        this.instance = this.instance.concat(A.instance)
    }
};
ArrayList.prototype.get = function(A) {
    if (this.isEmpty()) {
        return null
    }
    if (A > this.size()) {
        return null
    }
    return this.instance[A]
};
ArrayList.prototype.getLast = function() {
    if (this.size() < 1) {
        return null
    }
    return this.instance[this.size() - 1]
};
ArrayList.prototype.set = function(B, C) {
    if (B >= this.size()) {
        throw "IndexOutOfBoundException : Index " + B + ", Size " + this.size()
    }
    var A = this.instance[B];
    this.instance[B] = C;
    return A
};
ArrayList.prototype.removeElementAt = function(A) {
    if (A > this.size() || A < 0) {
        return
    }
    this.instance.splice(A, 1)
};
ArrayList.prototype.remove = function(B) {
    var A = this.indexOf(B);
    this.removeElementAt(A)
};
ArrayList.prototype.contains = function(A, B) {
    return this.indexOf(A, B) > -1
};
ArrayList.prototype.indexOf = function(C, D) {
    for (var A = 0; A < this.size(); A++) {
        var B = this.instance[A];
        if (B == C) {
            return A
        } else {
            if (D != null && B != null && C != null && B[D] == C[D]) {
                return A
            }
        }
    }
    return - 1
};
ArrayList.prototype.lastIndexOf = function(C, D) {
    for (var A = this.size() - 1; A >= 0; A--) {
        var B = this.instance[A];
        if (B == C) {
            return A
        } else {
            if (D != null && B != null && C != null && B[D] == C[D]) {
                return A
            }
        }
    }
    return - 1
};
ArrayList.prototype.subList = function(B, D) {
    if (B < 0) {
        B = 0
    }
    if (D > this.size()) {
        D = this.size()
    }
    var C = this.instance.slice(B, D);
    var A = new ArrayList();
    A.addAll(C);
    return A
};
ArrayList.prototype.toArray = function() {
    return this.instance
};
ArrayList.prototype.isEmpty = function() {
    return this.size() == 0
};
ArrayList.prototype.clear = function() {
    this.instance = new Array()
};
ArrayList.prototype.toString = function(A) {
    A = A || ", ";
    return this.instance.join(A)
};
function Properties(A) {
    this.instanceKeys = new ArrayList();
    this.instance = {};
    if (A) {
        this.instance = A;
        for (var B in A) {
            this.instanceKeys.add(B)
        }
    }
}
Properties.prototype.size = function() {
    return this.instanceKeys.size()
};
Properties.prototype.get = function(B, A) {
    if (B == null) {
        return null
    }
    var C = this.instance[B];
    if (C == null && A != null) {
        return A
    }
    return C
};
Properties.prototype.remove = function(A) {
    if (A == null) {
        return null
    }
    this.instanceKeys.remove(A);
    delete this.instance[A]
};
Properties.prototype.put = function(A, B) {
    if (A == null) {
        return null
    }
    if (this.instance[A] == null) {
        this.instanceKeys.add(A)
    }
    this.instance[A] = B
};
Properties.prototype.putRef = function(A, B) {
    if (A == null) {
        return null
    }
    this.instanceKeys.add(A);
    this.instance[A] = B
};
Properties.prototype.getMultilevel = function(D, B) {
    if (D == null) {
        return null
    }
    var C = D.split(".");
    function A(I, G, F) {
        try {
            if (I == null || (typeof I != "object")) {
                return null
            }
            var J = I.get(G[F]);
            if (F < G.length - 1) {
                J = A(J, G, F + 1)
            }
            return J
        } catch(H) {}
        return null
    }
    var E = A(this, C, 0);
    return E == null ? B: E
};
Properties.prototype.containsKey = function(A) {
    if (A == null) {
        return false
    }
    return this.instance[A] != null
};
Properties.prototype.keys = function() {
    return this.instanceKeys
};
Properties.prototype.values = function() {
    var D = new ArrayList();
    for (var B = 0; B < this.instanceKeys.size(); B++) {
        var A = this.instanceKeys.get(B);
        if (A) {
            var C = this.instance[A];
            D.add(C)
        }
    }
    return D
};
Properties.prototype.isEmpty = function() {
    return this.instanceKeys.isEmpty()
};
Properties.prototype.clear = function() {
    this.instanceKeys.clear();
    this.instance = {}
};
Properties.prototype.swap = function(C, B) {
    if (!C || !B || C == B) {
        return
    }
    var E = -1;
    var D = -1;
    for (var A = 0; A < this.instanceKeys.instance.length; A++) {
        if (this.instanceKeys.instance[A] == C) {
            E = A
        } else {
            if (this.instanceKeys.instance[A] == B) {
                D = A
            }
        }
    }
    this.instanceKeys.instance[E] = B;
    this.instanceKeys.instance[D] = C
};
Properties.prototype.entrySet = function() {
    var A = [];
    for (var C = 0; C < this.instanceKeys.size(); C++) {
        var B = this.instanceKeys.get(C);
        var D = this.instance[B];
        if (!B) {
            continue
        }
        var E = new Object();
        E.key = B;
        E.value = D;
        A[A.length] = E
    }
    return A
};
Properties.prototype.toString = function() {
    var C = "";
    for (var B = 0; B < this.instanceKeys.size(); B++) {
        var A = this.instanceKeys.get(B);
        C += A + "=" + this.instance[A] + "\n"
    }
    return C
};
Properties.prototype.toStringTokenizer = function(E, D) {
    E = E == null ? ";": E;
    D = D == null ? "=": D;
    var F = "";
    for (var B = 0; B < this.instanceKeys.size(); B++) {
        var A = this.instanceKeys.get(B);
        var C = this.instance[A];
        if (!A) {
            continue
        }
        if (B > 0) {
            F += E
        }
        F += A + D + C
    }
    return F
};
Properties.prototype.toQueryString = function() {
    if (this.size() < 1) {
        return ""
    }
    var D = "";
    for (var B = 0; B < this.instanceKeys.size(); B++) {
        var A = this.instanceKeys.get(B);
        var C = this.instance[A];
        if (!A) {
            continue
        }
        if (B > 0) {
            D += "&"
        }
        if (typeof C == "object") {} else {
            D += A + "=" + encodeURIat(C)
        }
    }
    return D
};
function StringBuffer() {
    this._strings_ = new Array()
}
StringBuffer.prototype.append = function(A) {
    if (A) {
        if (A instanceof Array) {
            this._strings_ = this._strings_.concat(A)
        } else {
            this._strings_[this._strings_.length] = A
        }
    }
    return this
};
StringBuffer.prototype.reset = function(A) {
    this.clear();
    this.append(A)
};
StringBuffer.prototype.clear = function() {
    this._strings_ = new Array()
};
StringBuffer.prototype.isBlank = function() {
    return this._strings_.length == 0
};
StringBuffer.prototype.toString = function(A) {
    A = A == null ? "": A;
    if (this._strings_.length == 0) {
        return ""
    }
    return this._strings_.join(A)
};
String.prototype.getBytesLength = function() {
    var A = this.match(/[^\x00-\xff]/ig);
    return this.length + (A == null ? 0 : A.length)
};
String.prototype.getLimitLength = function(C, F) {
    if (!C || C < 0) {
        return this
    }
    var A = this.getBytesLength();
    if (A <= C) {
        return this
    }
    F = F == null ? "..": F;
    C = C - F.length;
    var B = 0;
    var D = "";
    for (var E = 0; E < this.length; E++) {
        if (this.charCodeAt(E) > 255) {
            B += 2
        } else {
            B++
        }
        D += this.charAt(E);
        if (B >= C) {
            return D + F
        }
    }
    return this
};
String.prototype.escapeHTML = function(B, A) {
    try {
        return escapeStringToHTML(this, B, A)
    } catch(C) {}
    return this
};
String.prototype.escapeJavascript = function() {
    return escapeStringToJavascript(this)
};
String.prototype.escapeSpace = function() {
    return this.replace(/ /g, "&nbsp;")
};
String.prototype.escapeSameWidthSpace = function() {
    return this.replace(/ /g, "&nbsp;&nbsp;")
};
String.prototype.escapeXML = function() {
    return this.replace(/\&/g, "&amp;").replace(/\</g, "&lt;").replace(/\>/g, "&gt;").replace(/\"/g, "&quot;")
};
String.prototype.escapeQuot = function() {
    return this.replace(/\'/g, "&#039;").replace(/"/g, "&#034;")
};
String.prototype.startsWith = function(A) {
    return this.indexOf(A) == 0
};
String.prototype.endsWith = function(A) {
    var B = this.indexOf(A);
    return B > -1 && B == this.length - A.length
};
String.prototype.trim = function() {
    var C = this.toCharArray();
    var A = 0;
    var D = C.length;
    for (var B = 0; B < C.length; B++) {
        var E = C[B];
        if (E == " ") {
            A++
        } else {
            break
        }
    }
    if (A == this.length) {
        return ""
    }
    for (var B = C.length; B > 0; B--) {
        var E = C[B - 1];
        if (E == " ") {
            D--
        } else {
            break
        }
    }
    return this.substring(A, D)
};
String.prototype.toCharArray = function() {
    var B = [];
    for (var A = 0; A < this.length; A++) {
        B[A] = this.charAt(A)
    }
    return B
};
function ArrayList() {
    this.instance = new Array()
}
ArrayList.prototype.size = function() {
    return this.instance.length
};
ArrayList.prototype.add = function(A) {
    this.instance[this.instance.length] = A
};
ArrayList.prototype.addSingle = function(A) {
    if (!this.contains(A)) {
        this.instance[this.instance.length] = A
    }
};
ArrayList.prototype.addAt = function(A, B) {
    if (A >= this.size() || A < 0 || this.isEmpty()) {
        this.add(B);
        return
    }
    this.instance.splice(A, 0, B)
};
ArrayList.prototype.addAll = function(A) {
    if (!A || A.length < 1) {
        return
    }
    this.instance = this.instance.concat(A)
};
ArrayList.prototype.addList = function(A) {
    if (A && A instanceof ArrayList && !A.isEmpty()) {
        this.instance = this.instance.concat(A.instance)
    }
};
ArrayList.prototype.get = function(A) {
    if (this.isEmpty()) {
        return null
    }
    if (A > this.size()) {
        return null
    }
    return this.instance[A]
};
ArrayList.prototype.getLast = function() {
    if (this.size() < 1) {
        return null
    }
    return this.instance[this.size() - 1]
};
ArrayList.prototype.set = function(B, C) {
    if (B >= this.size()) {
        throw "IndexOutOfBoundException : Index " + B + ", Size " + this.size()
    }
    var A = this.instance[B];
    this.instance[B] = C;
    return A
};
ArrayList.prototype.removeElementAt = function(A) {
    if (A > this.size() || A < 0) {
        return
    }
    this.instance.splice(A, 1)
};
ArrayList.prototype.remove = function(B) {
    var A = this.indexOf(B);
    this.removeElementAt(A)
};
ArrayList.prototype.contains = function(A, B) {
    return this.indexOf(A, B) > -1
};
ArrayList.prototype.indexOf = function(C, D) {
    for (var A = 0; A < this.size(); A++) {
        var B = this.instance[A];
        if (B == C) {
            return A
        } else {
            if (D != null && B != null && C != null && B[D] == C[D]) {
                return A
            }
        }
    }
    return - 1
};
ArrayList.prototype.lastIndexOf = function(C, D) {
    for (var A = this.size() - 1; A >= 0; A--) {
        var B = this.instance[A];
        if (B == C) {
            return A
        } else {
            if (D != null && B != null && C != null && B[D] == C[D]) {
                return A
            }
        }
    }
    return - 1
};
ArrayList.prototype.subList = function(B, D) {
    if (B < 0) {
        B = 0
    }
    if (D > this.size()) {
        D = this.size()
    }
    var C = this.instance.slice(B, D);
    var A = new ArrayList();
    A.addAll(C);
    return A
};
ArrayList.prototype.toArray = function() {
    return this.instance
};
ArrayList.prototype.isEmpty = function() {
    return this.size() == 0
};
ArrayList.prototype.clear = function() {
    this.instance = new Array()
};
ArrayList.prototype.toString = function(A) {
    A = A || ", ";
    return this.instance.join(A)
};
function Properties(A) {
    this.instanceKeys = new ArrayList();
    this.instance = {};
    if (A) {
        this.instance = A;
        for (var B in A) {
            this.instanceKeys.add(B)
        }
    }
}
Properties.prototype.size = function() {
    return this.instanceKeys.size()
};
Properties.prototype.get = function(B, A) {
    if (B == null) {
        return null
    }
    var C = this.instance[B];
    if (C == null && A != null) {
        return A
    }
    return C
};
Properties.prototype.remove = function(A) {
    if (A == null) {
        return null
    }
    this.instanceKeys.remove(A);
    delete this.instance[A]
};
Properties.prototype.put = function(A, B) {
    if (A == null) {
        return null
    }
    if (this.instance[A] == null) {
        this.instanceKeys.add(A)
    }
    this.instance[A] = B
};
Properties.prototype.putRef = function(A, B) {
    if (A == null) {
        return null
    }
    this.instanceKeys.add(A);
    this.instance[A] = B
};
Properties.prototype.getMultilevel = function(D, B) {
    if (D == null) {
        return null
    }
    var C = D.split(".");
    function A(I, G, F) {
        try {
            if (I == null || (typeof I != "object")) {
                return null
            }
            var J = I.get(G[F]);
            if (F < G.length - 1) {
                J = A(J, G, F + 1)
            }
            return J
        } catch(H) {}
        return null
    }
    var E = A(this, C, 0);
    return E == null ? B: E
};
Properties.prototype.containsKey = function(A) {
    if (A == null) {
        return false
    }
    return this.instance[A] != null
};
Properties.prototype.keys = function() {
    return this.instanceKeys
};
Properties.prototype.values = function() {
    var D = new ArrayList();
    for (var B = 0; B < this.instanceKeys.size(); B++) {
        var A = this.instanceKeys.get(B);
        if (A) {
            var C = this.instance[A];
            D.add(C)
        }
    }
    return D
};
Properties.prototype.isEmpty = function() {
    return this.instanceKeys.isEmpty()
};
Properties.prototype.clear = function() {
    this.instanceKeys.clear();
    this.instance = {}
};
Properties.prototype.swap = function(C, B) {
    if (!C || !B || C == B) {
        return
    }
    var E = -1;
    var D = -1;
    for (var A = 0; A < this.instanceKeys.instance.length; A++) {
        if (this.instanceKeys.instance[A] == C) {
            E = A
        } else {
            if (this.instanceKeys.instance[A] == B) {
                D = A
            }
        }
    }
    this.instanceKeys.instance[E] = B;
    this.instanceKeys.instance[D] = C
};
Properties.prototype.entrySet = function() {
    var A = [];
    for (var C = 0; C < this.instanceKeys.size(); C++) {
        var B = this.instanceKeys.get(C);
        var D = this.instance[B];
        if (!B) {
            continue
        }
        var E = new Object();
        E.key = B;
        E.value = D;
        A[A.length] = E
    }
    return A
};
Properties.prototype.toString = function() {
    var C = "";
    for (var B = 0; B < this.instanceKeys.size(); B++) {
        var A = this.instanceKeys.get(B);
        C += A + "=" + this.instance[A] + "\n"
    }
    return C
};
Properties.prototype.toStringTokenizer = function(E, D) {
    E = E == null ? ";": E;
    D = D == null ? "=": D;
    var F = "";
    for (var B = 0; B < this.instanceKeys.size(); B++) {
        var A = this.instanceKeys.get(B);
        var C = this.instance[A];
        if (!A) {
            continue
        }
        if (B > 0) {
            F += E
        }
        F += A + D + C
    }
    return F
};
Properties.prototype.toQueryString = function() {
    if (this.size() < 1) {
        return ""
    }
    var D = "";
    for (var B = 0; B < this.instanceKeys.size(); B++) {
        var A = this.instanceKeys.get(B);
        var C = this.instance[A];
        if (!A) {
            continue
        }
        if (B > 0) {
            D += "&"
        }
        if (typeof C == "object") {} else {
            D += A + "=" + encodeURIat(C)
        }
    }
    return D
};

var _windowsMap = new Properties();

//function getA8ParentWindow(D){var A=D;for(var B=0;B<20;B++){if(typeof A.isCtpTop!="undefined"&&A.isCtpTop){return A}else{A=A.parent}}
function getA8Top() {
    try {
        var A = getA8ParentWindow(window);
        if (A) {
            return A
        } else {
            return top
        }
    } catch(B) {
        return top
    }
}
var G;
function openCtpWindow(D) {
    C = D.datagrid;
    B = D.title;
    G = PREopenCtpWindow(D);
    if(!G){
    	Matrix.warn("弹出式窗口被浏览器阻止,请设置浏览器始终允许弹出式窗口!");
    	return;
    }else if(G == 1 || G == 2){
    	return;
    }
    if (B && B != null && B != '' && B != 'undefined') setTimeout("G.document.title=\"" + B + "\"", 6000);
    if (C != null && C != "") {
        if (G.addEventListener) {
            G.addEventListener('unload',
            function() {
                Matrix.refreshDataGridData(C);
            },
            false);
        } else if (G.attachEvent) {
            G.attachEvent('onunload',
            function() {
                Matrix.refreshDataGridData(C);
            });
        } else {
            G["onunload"] = function() {
                Matrix.refreshDataGridData(C);
            };
        }
    }
}

function PREopenCtpWindow(D) {

    var O, T, R, M, L, J, Z, H, A, C;
    this.windowArgs = D;
    this.workSpaceTop = 130;
    this.workSpaceLeft = 0;
    this.workSpaceWidth = parseInt(screen.width) - this.workSpaceLeft;
    this.workSpaceheight = parseInt(screen.height) - 50 - this.workSpaceTop;
    this.settings = {
        dialog_type: "open",
        resizable: "yes",
        scrollbars: "yes"
    };
    O = D.html;
    H = D.url;
    A = D.dialogType || this.settings.dialog_type;

    if (A == "modal") {
        T = D.width || 320;
        R = D.height || 200;
        T = parseInt(T);
        R = parseInt(R);
        M = D.left || parseInt(screen.width / 2) - (T / 2);
        L = D.top || parseInt(screen.height / 2) - (R / 2)
    } else {
        if (D.workSpace) {
            T = this.workSpaceWidth;
            R = this.workSpaceheight;
            M = this.workSpaceLeft;
            L = this.workSpaceTop
        } else {
            if (D.workSpaceRight) {
                T = this.workSpaceWidth - 130;
                R = this.workSpaceheight;
                M = 140;
                L = this.workSpaceTop
            } else {
                T = D.width || (this.workSpaceWidth - 20);
                R = D.height || (this.workSpaceheight + this.workSpaceTop);
                M = D.left || 0;
                L = D.top || 0
            }
        }
    }
    J = D.resizable || this.settings.resizable;
    Z = D.scrollbars || this.settings.scrollbars;
    if (O) {
        var G = window.open("", "ctpPopup" + new Date().getTime(), "top=" + L + ",left=" + M + ",scrollbars=" + Z + ",dialog=yes,minimizable=" + J + ",modal=yes,width=" + T + ",height=" + R + ",resizable=" + J);
        if (G == null) {
            return
        }
        G.document.write(O);
        G.document.close();
        G.resizeTo(T, R);
        G.focus();
        return G
    } else {
        if (A == "modal") {
            var I = "resizable:" + J + ";scroll:" + Z + ";status:no;help:no;dialogWidth:" + T + "px;dialogHeight:" + R + "px;";
            if (D.workSpace || D.workSpaceRight || (D.left && D.top)) {
                I += "dialogTop:" + L + "px;dialogLeft:" + M + "px;"
            } else {
                var F = (parseInt(getA8Top().document.body.offsetWidth) - T) / 2;
                var Q = (parseInt(getA8Top().document.body.offsetHeight) - R) / 2;
                if (F == null || Q == null || F < 0 || Q < 0) {
                    F = 200;
                    Q = 200
                }
                I += this.isMSIE ? "center:yes;": "dialogTop:" + Q + "px;dialogLeft:" + F + "px;"
            }
            if (H.indexOf("?") != -1) {
                H += "&"
            } else {
                H += "?"
            }
            H += "_isModalDialog=true";
            var K = window.showModalDialog(H, window, I);
            var Y = null;
            if (this.ModalDialogResultValue == undefined) {
                Y = K
            } else {
                Y = this.ModalDialogResultValue;
                this.ModalDialogResultValue = undefined
            }
            return Y
        } else {
            var K = null;
            var W = (J == "yes") ? "no": "yes";
            var E = D.id;
            if (E == undefined) {
                E = H
            }
            var U = getA8Top()._windowsMap;
            if (U) {
                for (var S = 0; S < U.keys().size(); S++) {
                    var P = U.keys().get(S);
                    try {
                        var B = U.get(P);
                        var N = B.document;
                        if (N) {
                            var a = parseInt(N.body.clientHeight);
                            if (a == 0) {
                                U.remove(P);
                                S--
                            }
                        } else {
                            U.remove(P);
                            S--
                        }
                    } catch(X) {
                        U.remove(P);
                        S--
                    }
                }
                if (U.size() == 10) {
                    alert("弹窗超过最大限制");
                    G = 1;
                    return G
                }
                var V = U.get(E);
                if (V) {
                    try {
                        var N = V.document;
                        alert("页面已打开");
                        G = 2;
                        V.focus();
                        return G
                    } catch(X) {
                        U.remove(E)
                    }
                }
            }
            R -= 25;
            debugger;
            G = window.open(H, "ctpPopup" + new Date().getTime(), "top=" + L + ",left=" + M + ",scrollbars=" + Z + ",dialog=" + W + ",minimizable=" + J + ",modal=" + W + ",width=" + T + ",height=" + R + ",resizable=" + J);
            if (G == null) {
                return
            }
            G.focus();
            
            //G.ctpWinBackParam=D.ctpWinBackParam;
            if (U) {
                U.putRef(E, G)
            }
            
            if(opener){
                if(opener.top.getWindow){
                     opener.top.getWindow(G);
                }
            }else if(top){
                if(top.getWindow){
                    top.getWindow(G);
                }
            }
            return G
        }
    }
}