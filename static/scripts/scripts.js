function convertWeekToChinese($cn,$isFull) {

   switch ($cn){
       case '7': return $isFull ? "星期日" : "周日";
       case '1': return $isFull ? "星期一" : "周一";
       case '2': return $isFull ? "星期二" : "周二";
       case '3': return $isFull ? "星期三" : "周三";
       case '4': return $isFull ? "星期四" : "周四";
       case '5': return $isFull ? "星期五" : "周五";
       case '6': return $isFull ? "星期六" : "周六";
   }
   return "";
}
function convertMonthToChinese($cn) {
   var text = "";
   switch ($cn){
       case "1": text = "一";break;
       case "2": text = "二";break;
       case "3": text = "三";break;
       case "4": text = "四";break;
       case "5": text = "五";break;
       case "6": text = "六";break;
       case "7": text = "七";break;
       case "8": text = "八";break;
       case "9": text = "九";break;
       case "10": text = "十";break;
       case "11": text = "十一";break;
       case "12": text = "十二";break;
    }
    if(text !== ""){
        text += "月";
    }

    return text;
}


$(function () {
   $("[data-toggle='tooltip']").tooltip();
});