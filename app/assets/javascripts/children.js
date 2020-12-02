var formObj = '';
 
var zeroFormat = function(v, n) {
    vl = String(v).length;
    if (n > vl) {
        return (new Array((n - vl) + 1).join(0)) + v;
    } else {
        return v;
    }
};
 
var ageCalculator = function(year, month, day) {
    var dateObj  = new Date(),
        today    = parseInt('' + dateObj.getFullYear() + zeroFormat(dateObj.getMonth() + 1, 2) + zeroFormat(dateObj.getDate(), 2)),
        birthday = parseInt('' + year + zeroFormat(month, 2) + zeroFormat(day, 2));
 
    formObj.age.value = parseInt((today - birthday) / 10000);
};
 
var changeDate = function(mode) {
    var tYear   = formObj.year,
        tMonth  = formObj.month,
        tDays   = formObj.days,
        selectY = tYear.options[tYear.selectedIndex].value,
        selectM = tMonth.options[tMonth.selectedIndex].value,
        selectD = tDays.options[tDays.selectedIndex].value,
        dateObj,
        gDate,
        i;
 
    if (mode === 'date') {
        dateObj = new Date(selectY, selectM, 0);
        gDate   = dateObj.getDate();
 
        tDays.length = 0;
 
        for (i = 1 ;i <= gDate; i++) {
            tDays.options[i] = new Option(i, i);
        }
 
        tDays.removeChild(tDays.options[0]);
 
        if (selectD > tDays.length) {
            tDays.options[tDays.length - 1].selected = true;
        } else {
            tDays.options[selectD - 1].selected = true;
        }
    }
 
    ageCalculator(selectY, selectM, selectD);
};
 
formObj = document.form1;
 
// 年の選択変更時
formObj.year.onchange = function() {
    changeDate('date');
};
 
// 月の選択変更時
formObj.month.onchange = function() {
    changeDate('date');
};
 
// 日の選択変更時
formObj.days.onchange = function() {
    changeDate('age');
};