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

figureSets["flow"] = { 
    name : 'flow',
    description : 'A tiny set of network related figures',
    figures:[
        {figureFunction: "HumanTask", image: "m_human_s.png",type:"HumanTask"},
        {figureFunction: "StartAct", image: "m_start_L.png",type:"StartAct"},    
        {figureFunction: "StopAct", image: "m_stop_L.png",type:"StopAct"},    
        {figureFunction: "ConditionAct", image: "m_condition_L.png",type:"ConditionAct"},    
        {figureFunction: "SplitAct", image: "split.png",type:"SplitAct"},    
        {figureFunction: "JoinAct", image: "join.png",type:"JoinAct"},    
        {figureFunction: "AutomaticAct", image: "m_auto_s.png",type:"AutomaticAct"},
        {figureFunction: "BlockAct", image: "m_block_s.png",type:"BlockAct"},
        {figureFunction: "SubflowAct", image: "m_subflow_s.png",type:"SubflowAct"},
        {figureFunction: "DataObject", image: "DataObject_s.png",type:"DataObject"},
        {figureFunction: "DataStore", image: "DataStore_s.png",type:"DataStore"},
    ]
}

function figure_HumanTask(x, y, figureId, status)
{
    var f = new Figure("HumanTask",figureId);
    f.style.fillStyle = FigureDefaults.fillStyle;
    f.style.strokeStyle = FigureDefaults.strokeStyle;
    
    //Image
    var url = "lib/sets/flow/m_humanTask_L.png";
    
    if(status == 1 || status ==2){
 		url = "lib/sets/flow/act_person_running.png";
    }else if(status == 3){
    	url = "lib/sets/flow/act_person_unactive.png";
    }
     
    var imageWidth = 70;
    var imageHeight = 45;

    var ifig = new ImageFrame(url, x, y, true, imageWidth, imageHeight);
    ifig.debug = true;
    f.addPrimitive(ifig);    

	f.x = x;
	f.y = y;
	f.imageWidth = imageWidth;
	f.imageHeight = imageHeight;
	f.status = status;
    
    //Text
 /*   f.properties.push(new BuilderProperty('Text', 'primitives.1.str', BuilderProperty.TYPE_TEXT));
    f.properties.push(new BuilderProperty('Text Size', 'primitives.1.size', BuilderProperty.TYPE_TEXT_FONT_SIZE));
    f.properties.push(new BuilderProperty('Font', 'primitives.1.font', BuilderProperty.TYPE_TEXT_FONT_FAMILY));
    f.properties.push(new BuilderProperty('Alignment', 'primitives.1.align', BuilderProperty.TYPE_TEXT_FONT_ALIGNMENT));
    f.properties.push(new BuilderProperty('Text Underlined', 'primitives.1.underlined', BuilderProperty.TYPE_TEXT_UNDERLINED));
    f.properties.push(new BuilderProperty('Text Color', 'primitives.1.style.fillStyle', BuilderProperty.TYPE_COLOR));
*/    
    f.properties.push(new BuilderProperty('URL', 'url', BuilderProperty.TYPE_URL));
    
    var t2 = new Text(FigureDefaults.textStr, x, y+2, FigureDefaults.textFont, FigureDefaults.textSize);
	t2.setTextStr("人工活动");
    t2.style.fillStyle = FigureDefaults.textColor;
    f.addPrimitive(t2);
    
    //Connection Points
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x + imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x - imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y - imageHeight/2), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y + imageHeight/2 ), ConnectionPoint.TYPE_FIGURE);


    f.finalise();
    return f;
}


function figure_AutomaticAct(x, y, figureId)
{
    var f = new Figure("AutomaticAct",figureId);
    f.style.fillStyle = FigureDefaults.fillStyle;
    f.style.strokeStyle = FigureDefaults.strokeStyle;
    
    //Image
    var url = "lib/sets/flow/m_automatic_L.png";
    
    var imageWidth = 70;
    var imageHeight = 45;

    var ifig = new ImageFrame(url, x, y, true, imageWidth, imageHeight);
    ifig.debug = true;
    f.addPrimitive(ifig);    
    
	f.x = x;
	f.y = y;
	f.imageWidth = imageWidth;
	f.imageHeight = imageHeight;
    
    //Text
    f.properties.push(new BuilderProperty('Text', 'primitives.1.str', BuilderProperty.TYPE_TEXT));
    f.properties.push(new BuilderProperty('Text Size', 'primitives.1.size', BuilderProperty.TYPE_TEXT_FONT_SIZE));
    f.properties.push(new BuilderProperty('Font', 'primitives.1.font', BuilderProperty.TYPE_TEXT_FONT_FAMILY));
    f.properties.push(new BuilderProperty('Alignment', 'primitives.1.align', BuilderProperty.TYPE_TEXT_FONT_ALIGNMENT));
    f.properties.push(new BuilderProperty('Text Underlined', 'primitives.1.underlined', BuilderProperty.TYPE_TEXT_UNDERLINED));
    f.properties.push(new BuilderProperty('Text Color', 'primitives.1.style.fillStyle', BuilderProperty.TYPE_COLOR));
    
    f.properties.push(new BuilderProperty('URL', 'url', BuilderProperty.TYPE_URL));
    
    var t2 = new Text(FigureDefaults.textStr, x, y+2, FigureDefaults.textFont, FigureDefaults.textSize);
	t2.setTextStr("自动活动");
    t2.style.fillStyle = FigureDefaults.textColor;
    f.addPrimitive(t2);
    
    //Connection Points
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x + imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x - imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y - imageHeight/2), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y + imageHeight/2 ), ConnectionPoint.TYPE_FIGURE);


    f.finalise();
    return f;
}

function figure_SubflowAct(x, y, figureId, status)
{
    var f = new Figure("SubflowAct",figureId);
    f.style.fillStyle = FigureDefaults.fillStyle;
    f.style.strokeStyle = FigureDefaults.strokeStyle;
    
    //Image
    var url = "lib/sets/flow/m_subflow_L.png";
    
    var imageWidth = 70;
    var imageHeight = 45;

    var ifig = new ImageFrame(url, x, y, true, imageWidth, imageHeight);
    ifig.debug = true;
    f.addPrimitive(ifig);    
    
	f.x = x;
	f.y = y;
	f.imageWidth = imageWidth;
	f.imageHeight = imageHeight;
    
    //Text
    f.properties.push(new BuilderProperty('Text', 'primitives.1.str', BuilderProperty.TYPE_TEXT));
    f.properties.push(new BuilderProperty('Text Size', 'primitives.1.size', BuilderProperty.TYPE_TEXT_FONT_SIZE));
    f.properties.push(new BuilderProperty('Font', 'primitives.1.font', BuilderProperty.TYPE_TEXT_FONT_FAMILY));
    f.properties.push(new BuilderProperty('Alignment', 'primitives.1.align', BuilderProperty.TYPE_TEXT_FONT_ALIGNMENT));
    f.properties.push(new BuilderProperty('Text Underlined', 'primitives.1.underlined', BuilderProperty.TYPE_TEXT_UNDERLINED));
    f.properties.push(new BuilderProperty('Text Color', 'primitives.1.style.fillStyle', BuilderProperty.TYPE_COLOR));
    
    f.properties.push(new BuilderProperty('URL', 'url', BuilderProperty.TYPE_URL));
    
    var t2 = new Text(FigureDefaults.textStr, x, y+2, FigureDefaults.textFont, FigureDefaults.textSize);
	t2.setTextStr("外部子流程");
    t2.style.fillStyle = FigureDefaults.textColor;
    f.addPrimitive(t2);
    
    //Connection Points
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x + imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x - imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y - imageHeight/2), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y + imageHeight/2 ), ConnectionPoint.TYPE_FIGURE);


    f.finalise();
    return f;
}

function figure_BlockAct(x, y, figureId, status)
{
    var f = new Figure("BlockAct",figureId);
    f.style.fillStyle = FigureDefaults.fillStyle;
    f.style.strokeStyle = FigureDefaults.strokeStyle;
    
    //Image
    var url = "lib/sets/flow/m_block_L.png";
    
    var imageWidth = 70;
    var imageHeight = 45;

    var ifig = new ImageFrame(url, x, y, true, imageWidth, imageHeight);
    ifig.debug = true;
    f.addPrimitive(ifig);    
    
	f.x = x;
	f.y = y;
	f.imageWidth = imageWidth;
	f.imageHeight = imageHeight;
    
    //Text
    f.properties.push(new BuilderProperty('Text', 'primitives.1.str', BuilderProperty.TYPE_TEXT));
    f.properties.push(new BuilderProperty('Text Size', 'primitives.1.size', BuilderProperty.TYPE_TEXT_FONT_SIZE));
    f.properties.push(new BuilderProperty('Font', 'primitives.1.font', BuilderProperty.TYPE_TEXT_FONT_FAMILY));
    f.properties.push(new BuilderProperty('Alignment', 'primitives.1.align', BuilderProperty.TYPE_TEXT_FONT_ALIGNMENT));
    f.properties.push(new BuilderProperty('Text Underlined', 'primitives.1.underlined', BuilderProperty.TYPE_TEXT_UNDERLINED));
    f.properties.push(new BuilderProperty('Text Color', 'primitives.1.style.fillStyle', BuilderProperty.TYPE_COLOR));
    
    f.properties.push(new BuilderProperty('URL', 'url', BuilderProperty.TYPE_URL));
    
    var t2 = new Text(FigureDefaults.textStr, x, y+2, FigureDefaults.textFont, FigureDefaults.textSize);
	t2.setTextStr("内部子流程");
    t2.style.fillStyle = FigureDefaults.textColor;
    f.addPrimitive(t2);
    
    //Connection Points
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x + imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x - imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y - imageHeight/2), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y + imageHeight/2 ), ConnectionPoint.TYPE_FIGURE);


    f.finalise();
    return f;
}

function figure_DataObject(x, y, figureId, status)
{
    var f = new Figure("DataObject",figureId);
    f.style.fillStyle = FigureDefaults.fillStyle;
    f.style.strokeStyle = FigureDefaults.strokeStyle;
    
    //Image
    var url = "lib/sets/flow/DataObject.png";
    
    var imageWidth = 70;
    var imageHeight = 45;

    var ifig = new ImageFrame(url, x, y, true, imageWidth, imageHeight);
    ifig.debug = true;
    f.addPrimitive(ifig);    
    
	f.x = x;
	f.y = y;
	f.imageWidth = imageWidth;
	f.imageHeight = imageHeight;
    
    //Text
    f.properties.push(new BuilderProperty('Text', 'primitives.1.str', BuilderProperty.TYPE_TEXT));
    f.properties.push(new BuilderProperty('Text Size', 'primitives.1.size', BuilderProperty.TYPE_TEXT_FONT_SIZE));
    f.properties.push(new BuilderProperty('Font', 'primitives.1.font', BuilderProperty.TYPE_TEXT_FONT_FAMILY));
    f.properties.push(new BuilderProperty('Alignment', 'primitives.1.align', BuilderProperty.TYPE_TEXT_FONT_ALIGNMENT));
    f.properties.push(new BuilderProperty('Text Underlined', 'primitives.1.underlined', BuilderProperty.TYPE_TEXT_UNDERLINED));
    f.properties.push(new BuilderProperty('Text Color', 'primitives.1.style.fillStyle', BuilderProperty.TYPE_COLOR));
    
    f.properties.push(new BuilderProperty('URL', 'url', BuilderProperty.TYPE_URL));
    
    var t2 = new Text(FigureDefaults.textStr, x, y+2, FigureDefaults.textFont, FigureDefaults.textSize);
	t2.setTextStr("DataObjct");
    t2.style.fillStyle = FigureDefaults.textColor;
    f.addPrimitive(t2);
    
    //Connection Points
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x + imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x - imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y - imageHeight/2), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y + imageHeight/2 ), ConnectionPoint.TYPE_FIGURE);


    f.finalise();
    return f;
}


function figure_DataStore(x, y, figureId, status)
{
    var f = new Figure("DataStore",figureId);
    f.style.fillStyle = FigureDefaults.fillStyle;
    f.style.strokeStyle = FigureDefaults.strokeStyle;
    
    //Image
    var url = "lib/sets/flow/DataStore.png";
    
    var imageWidth = 70;
    var imageHeight = 45;

    var ifig = new ImageFrame(url, x, y, true, imageWidth, imageHeight);
    ifig.debug = true;
    f.addPrimitive(ifig);    
    
    //Text
    f.properties.push(new BuilderProperty('Text', 'primitives.1.str', BuilderProperty.TYPE_TEXT));
    f.properties.push(new BuilderProperty('Text Size', 'primitives.1.size', BuilderProperty.TYPE_TEXT_FONT_SIZE));
    f.properties.push(new BuilderProperty('Font', 'primitives.1.font', BuilderProperty.TYPE_TEXT_FONT_FAMILY));
    f.properties.push(new BuilderProperty('Alignment', 'primitives.1.align', BuilderProperty.TYPE_TEXT_FONT_ALIGNMENT));
    f.properties.push(new BuilderProperty('Text Underlined', 'primitives.1.underlined', BuilderProperty.TYPE_TEXT_UNDERLINED));
    f.properties.push(new BuilderProperty('Text Color', 'primitives.1.style.fillStyle', BuilderProperty.TYPE_COLOR));
    
    f.properties.push(new BuilderProperty('URL', 'url', BuilderProperty.TYPE_URL));
    
    var t2 = new Text(FigureDefaults.textStr, x, y+2, FigureDefaults.textFont, FigureDefaults.textSize);
	t2.setTextStr("DataStore");
    t2.style.fillStyle = FigureDefaults.textColor;
    f.addPrimitive(t2);
    
	f.x = x;
	f.y = y;
	f.imageWidth = imageWidth;
	f.imageHeight = imageHeight;
    
    //Connection Points
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x + imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x - imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y - imageHeight/2), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y + imageHeight/2 ), ConnectionPoint.TYPE_FIGURE);


    f.finalise();
    return f;
}


function figure_StartAct(x, y, figureId, status)
{
    var f = new Figure("StartAct",figureId);


    f.style.fillStyle = FigureDefaults.fillStyle;
    f.style.strokeStyle = FigureDefaults.strokeStyle;
    
    //Image
    var url = "lib/sets/flow/m_start_L.png";
    
    var imageWidth = 32;
    var imageHeight = 32;

    var ifig = new ImageFrame(url, x, y, true, imageWidth, imageHeight);
    ifig.debug = true;
    f.addPrimitive(ifig);    
    
    f.properties.push(new BuilderProperty('URL', 'url', BuilderProperty.TYPE_URL));
    
	f.x = x;
	f.y = y;
	f.imageWidth = imageWidth;
	f.imageHeight = imageHeight;
    
    //Connection Points
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x + imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x - imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y - imageHeight/2), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y + imageHeight/2 ), ConnectionPoint.TYPE_FIGURE);


    f.finalise();
    return f;
}

function figure_StopAct(x, y, figureId, status)
{
    var f = new Figure("StopAct",figureId);

    f.style.fillStyle = FigureDefaults.fillStyle;
    f.style.strokeStyle = FigureDefaults.strokeStyle;
    
    //Image
    var url = "lib/sets/flow/m_stop_L.png";
    
    var imageWidth = 32;
    var imageHeight = 32;

    var ifig = new ImageFrame(url, x, y, true, imageWidth, imageHeight);
    ifig.debug = true;
    f.addPrimitive(ifig);    
    
    f.properties.push(new BuilderProperty('URL', 'url', BuilderProperty.TYPE_URL));
    
	f.x = x;
	f.y = y;
	f.imageWidth = imageWidth;
	f.imageHeight = imageHeight;
    
    //Connection Points
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x + imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x - imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y - imageHeight/2), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y + imageHeight/2 ), ConnectionPoint.TYPE_FIGURE);


    f.finalise();
    return f;
}

function figure_ConditionAct(x, y, figureId, status)
{
    var f = new Figure("ConditionAct",figureId);

    f.style.fillStyle = FigureDefaults.fillStyle;
    f.style.strokeStyle = FigureDefaults.strokeStyle;
    
    //Image
    var url = "lib/sets/flow/m_condition_L.png";
    
    var imageWidth = 32;
    var imageHeight = 32;

    var ifig = new ImageFrame(url, x, y, true, imageWidth, imageHeight);
    ifig.debug = true;
    f.addPrimitive(ifig);    
    
    f.properties.push(new BuilderProperty('URL', 'url', BuilderProperty.TYPE_URL));
    
	f.x = x;
	f.y = y;
	f.imageWidth = imageWidth;
	f.imageHeight = imageHeight;
    
    //Connection Points
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x + imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x - imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y - imageHeight/2), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y + imageHeight/2 ), ConnectionPoint.TYPE_FIGURE);


    f.finalise();
    return f;
}

function figure_SplitAct(x, y, figureId, status)
{
    var f = new Figure("SplitAct",figureId);
    
    f.style.fillStyle = FigureDefaults.fillStyle;
    f.style.strokeStyle = FigureDefaults.strokeStyle;
    
    //Image
    var url = "lib/sets/flow/split.png";
    
    var imageWidth = 32;
    var imageHeight = 32;

    var ifig = new ImageFrame(url, x, y, true, imageWidth, imageHeight);
    ifig.debug = true;
    f.addPrimitive(ifig);    
    
    f.properties.push(new BuilderProperty('URL', 'url', BuilderProperty.TYPE_URL));
    
	f.x = x;
	f.y = y;
	f.imageWidth = imageWidth;
	f.imageHeight = imageHeight;
    
    //Connection Points
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x + imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x - imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y - imageHeight/2), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y + imageHeight/2 ), ConnectionPoint.TYPE_FIGURE);


    f.finalise();
    return f;
}

function figure_JoinAct(x, y, figureId, status)
{
    var f = new Figure("JoinAct",figureId);

    f.style.fillStyle = FigureDefaults.fillStyle;
    f.style.strokeStyle = FigureDefaults.strokeStyle;
    
    //Image
    var url = "lib/sets/flow/join.png";
    
    var imageWidth = 32;
    var imageHeight = 32;

    var ifig = new ImageFrame(url, x, y, true, imageWidth, imageHeight);
    ifig.debug = true;
    f.addPrimitive(ifig);    
    
    f.properties.push(new BuilderProperty('URL', 'url', BuilderProperty.TYPE_URL));
    
	f.x = x;
	f.y = y;
	f.imageWidth = imageWidth;
	f.imageHeight = imageHeight;
    
    //Connection Points
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x + imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x - imageWidth/2, y), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y - imageHeight/2), ConnectionPoint.TYPE_FIGURE);
    CONNECTOR_MANAGER.connectionPointCreate(f.id, new Point(x, y + imageHeight/2 ), ConnectionPoint.TYPE_FIGURE);


    f.finalise();
    return f;
}

