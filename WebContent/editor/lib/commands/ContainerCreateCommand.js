"use strict";

/*
Copyright [2014] [Diagramo]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

/* 
 * Creates a new {Container}
 * 
 * 
 * @this {ContainerCreateCommand} 
 * @constructor
 * @param {Number} x - the x coordinates
 * @param {Number} y - the x coordinates
 * @author Alex <alex@scriptoid.com>
 */

function ContainerCreateCommand(x, y, type,isNew, width, height,newId,name) {
    
    this.x = x; 
    this.y = y;
    this.width = width;
    this.height = height;
	this.type = type;
    this.firstExecute = true;
    this.isNew = isNew;
    this.name = name;
    
    /**Any sequence of many mergeable actions can be packed by the history*/
    this.mergeable = false;
    
    this.id = newId;
}

ContainerCreateCommand.prototype = {
    execute: function() {
        if(this.firstExecute){
            
//            var p1 = new Point(this.x - 50, this.y - 50);
//            var p2 = new Point(this.x + 50,this.y + 50);
			if(this.isNew){
	            if(this.type == "HSwimline"){
					var p1 = new Point(10, this.y - 80);
					var p2 = new Point(1185,this.y + 80);
	            }else if(this.type == "VSwimline"){
					var p1 = new Point(this.x - 100, 10 );
					var p2 = new Point(this.x + 100, 695);
	            }
			}else{
	            if(this.type == "HSwimline"){
					var p1 = new Point(this.x , this.y );
					var p2 = new Point(this.x +this.width, this.y+this.height);
	            }else if(this.type == "VSwimline"){
					var p1 = new Point(this.x , this.y );
					var p2 = new Point(this.x +this.width, this.y+this.height);
	            }
			}
            
            var container = new Container(this.id, p1, p2,this.type,this.name);
            container.style.lineWidth = defaultLineWidth;   // set container default line width
            
            STACK.containerAdd(container);
            
            state = STATE_CONTAINER_SELECTED;
            selectedContainerId = container.id;
            
            this.id = container.id;

            //set up it's editor
            setUpEditPanel(container);
        }
        else{ //redo
            throw "ContainerCreateCommand:execute(). Redo not implemented";
        }
    },
        
    
    undo: function() {
        //remove container
        
        //set state to NONE (?)        
        
        //set STACK.selectedContainerId to -1
    }
}

