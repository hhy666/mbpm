scheduler.__recurring_template = '<div class="dhx_form_repeat"> <form> <div class="dhx_repeat_left"> <label><input class="dhx_repeat_radio" type="radio" name="repeat" value="day" />按天</label><br /> <label><input class="dhx_repeat_radio" type="radio" name="repeat" value="week"/>按周</label><br /> <label><input class="dhx_repeat_radio" type="radio" name="repeat" value="month" checked />按月</label><br /> <label><input class="dhx_repeat_radio" type="radio" name="repeat" value="year" />按年</label> </div> <div class="dhx_repeat_divider"></div> <div class="dhx_repeat_center"> <div style="display:none;" id="dhx_repeat_day"> <label><input class="dhx_repeat_radio" type="radio" name="day_type" value="d"/>每</label><input class="dhx_repeat_text" type="text" name="day_count" value="1" />天<br /> <label><input class="dhx_repeat_radio" type="radio" name="day_type" checked value="w"/>每个工作日</label> </div> <div style="display:none;" id="dhx_repeat_week"> 重复 每<input class="dhx_repeat_text" type="text" name="week_count" value="1" />星期的:<br /> <table class="dhx_repeat_days"> <tr> <td> <label><input class="dhx_repeat_checkbox" type="checkbox" name="week_day" value="1" />星期一</label><br /> <label><input class="dhx_repeat_checkbox" type="checkbox" name="week_day" value="4" />星期四</label> </td> <td> <label><input class="dhx_repeat_checkbox" type="checkbox" name="week_day" value="2" />星期二</label><br /> <label><input class="dhx_repeat_checkbox" type="checkbox" name="week_day" value="5" />星期五</label> </td> <td> <label><input class="dhx_repeat_checkbox" type="checkbox" name="week_day" value="3" />星期三</label><br /> <label><input class="dhx_repeat_checkbox" type="checkbox" name="week_day" value="6" />星期六</label> </td> <td> <label><input class="dhx_repeat_checkbox" type="checkbox" name="week_day" value="0" />星期日</label><br /><br /> </td> </tr> </table> </div> <div id="dhx_repeat_month"> <label><input class="dhx_repeat_radio" type="radio" name="month_type" value="d"/>重复</label><input class="dhx_repeat_text" type="text" name="month_day" value="1" />日 每<input class="dhx_repeat_text" type="text" name="month_count" value="1" />月<br /> <label><input class="dhx_repeat_radio" type="radio" name="month_type" checked value="w"/>在</label><input class="dhx_repeat_text" type="text" name="month_week2" value="1" /><select name="month_day2"><option value="1" selected >星期一<option value="2">星期二<option value="3">星期三<option value="4">星期四<option value="5">星期五<option value="6">星期六<option value="0">星期日</select>每<input class="dhx_repeat_text" type="text" name="month_count2" value="1" />月<br /> </div> <div style="display:none;" id="dhx_repeat_year"> <label><input class="dhx_repeat_radio" type="radio" name="year_type" value="d"/>每</label><input class="dhx_repeat_text" type="text" name="year_day" value="1" />日<select name="year_month"><option value="0" selected >一月<option value="1">二月<option value="2">三月<option value="3">四月<option value="4">五月<option value="5">六月<option value="6">七月<option value="7">八月<option value="8">九月<option value="9">十月<option value="10">十一月<option value="11">十二月</select>月<br /> <label><input class="dhx_repeat_radio" type="radio" name="year_type" checked value="w"/>在</label><input class="dhx_repeat_text" type="text" name="year_week2" value="1" /><select name="year_day2"><option value="1" selected >星期一<option value="2">星期二<option value="3">星期三<option value="4">星期四<option value="5">星期五<option value="6">星期六<option value="7">星期日</select>的<select name="year_month2"><option value="0" selected >一月<option value="1">二月<option value="2">三月<option value="3">四月<option value="4">五月<option value="5">六月<option value="6">七月<option value="7">八月<option value="8">九月<option value="9">十月<option value="10">十一月<option value="11">十二月</select><br /> </div> </div> <div class="dhx_repeat_divider"></div> <div class="dhx_repeat_right"> <label><input class="dhx_repeat_radio" type="radio" name="end" checked/>无结束日期</label><br /> <label><input class="dhx_repeat_radio" type="radio" name="end" />重复</label><input class="dhx_repeat_text" type="text" name="occurences_count" value="1" />次结束<br /> <label><input class="dhx_repeat_radio" type="radio" name="end" />结束于</label><input class="dhx_repeat_date" type="text" name="date_of_end" value="' + scheduler.config.repeat_date_of_end + '" /><br /> </div> </form> </div> <div style="clear:both"> </div>';
