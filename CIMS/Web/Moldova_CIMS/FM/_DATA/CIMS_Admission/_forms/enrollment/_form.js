function admissionIsUnique(frm){
frm.admissionIsUnique = false;
var input="id="+frm.getKeyValue()+",TeamId="+frm.getValue("TeamId")+",Year="+frm.getValue("Year");

//frm.alert(input);
frm.getElement('lblMessage').hide(); 

frm.loadInfo("checkIsUnique",input,
   function(res){
     if (res.r == "1") {
       frm.admissionIsUnique=false;
       frm.getElement('lblMessage').show().text("Admission for selected college and year already exists. Please, change settings.");
     } else {
        frm.admissionIsUnique = true;
     }
}
);
}