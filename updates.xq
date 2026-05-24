(: 1. إضافة عضو جديد :)
insert node <membre id="M011" categorieRef="C1">
              <nom>Bouaziz</nom>
              <prenom>Amira</prenom>
              <email>a.bouaziz@club.dz</email>
            </membre>
into//membres,

(: 2. تغيير معامل مسابقة :)
replace value of node //concours[@id="CO2"]/@coefficient with "2.5",

(: 3. حذف مشارك انسحب من مسابقة :)
delete node  //concours[@id="CO1"]//participant[@membreRef="M003"]