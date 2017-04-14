function convertWeekToChinese($cn,$isFull) {

   switch ($cn){
       case 'sunday': return $isFull ? "星期日" : "周日";
       case 'monday': return $isFull ? "星期一" : "周一";
       case 'tuesday': return $isFull ? "星期二" : "周二";
       case 'wednesday': return $isFull ? "星期三" : "周三";
       case 'thursday': return $isFull ? "星期四" : "周四";
       case 'friday': return $isFull ? "星期五" : "周五";
       case 'saturday': return $isFull ? "星期六" : "周六";
   }
   return "";
}
function convertMonthToChinese($cn) {
   var text = "";
   switch ($cn){
       case "january": text = "一";break;
       case "february": text = "二";break;
       case "march": text = "三";break;
       case "april": text = "四";break;
       case "may": text = "五";break;
       case "june": text = "六";break;
       case "july": text = "七";break;
       case "august": text = "八";break;
       case "september": text = "九";break;
       case "october": text = "十";break;
       case "november": text = "十一";break;
       case "december": text = "十二";break;
    }
    if(text !== ""){
        text += "月";
    }

    return text;
}

$(function () {
   $("[data-toggle='tooltip']").tooltip();
});