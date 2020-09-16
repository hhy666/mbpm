<!doctype html>

<title>CodeMirror: XML Autocomplete Demo</title>
<meta charset="utf-8"/>

<link rel="stylesheet" href="<%=request.getContextPath() %>/xmleditor/lib/codemirror.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/xmleditor/addon/hint/show-hint.css">
<script src="<%=request.getContextPath() %>/xmleditor/lib/codemirror.js"></script>
<script src="<%=request.getContextPath() %>/xmleditor/addon/hint/show-hint.js"></script>
<script src="<%=request.getContextPath() %>/xmleditor/addon/hint/xml-hint.js"></script>
<script src="<%=request.getContextPath() %>/xmleditor/mode/xml/xml.js"></script>
<form><textarea id="code" name="code"><!-- write some xml below -->
</textarea></form>
    <script>
      var dummy = {
        attrs: {
          
          description: null
        },
        children: []
      };

      var tags = {
        "table": ["table"],
        "!attrs": {
          id: null,
          name: null,
		  style:null,
		  styleClass:null
        },
        table: {
          attrs: {
            lang: ["en", "de", "fr", "nl"],
            freeform: null
          },
          children: ["tr", "td"]
        },

        table: dummy, tr: dummy, td: dummy
      };

      function completeAfter(cm, pred) {
        var cur = cm.getCursor();
        if (!pred || pred()) setTimeout(function() {
          if (!cm.state.completionActive)
            cm.showHint({completeSingle: false});
        }, 100);
        return CodeMirror.Pass;
      }

      function completeIfAfterLt(cm) {
        return completeAfter(cm, function() {
          var cur = cm.getCursor();
          return cm.getRange(CodeMirror.Pos(cur.line, cur.ch - 1), cur) == "<";
        });
      }

      function completeIfInTag(cm) {
        return completeAfter(cm, function() {
          var tok = cm.getTokenAt(cm.getCursor());
          if (tok.type == "string" && (!/['"]/.test(tok.string.charAt(tok.string.length - 1)) || tok.string.length == 1)) return false;
          var inner = CodeMirror.innerMode(cm.getMode(), tok.state).state;
          return inner.tagName;
        });
      }

      var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
        mode: "xml",
        lineNumbers: true,
        extraKeys: {
          "'<'": completeAfter,
          "'/'": completeIfAfterLt,
          "' '": completeIfInTag,
          "'='": completeIfInTag,
          "Ctrl-Space": "autocomplete"
        },
        hintOptions: {schemaInfo: tags}
      });
    </script>
