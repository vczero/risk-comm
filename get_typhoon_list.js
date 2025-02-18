var trs = $('#listBody .typhoonYearList')
rows = []
for(var i =0; i < trs.length; i++){
	tr = trs[i]
	const rowData = {
        id: $(this).find("td:nth-child(2)").text().trim(),
        chineseName: $(tr).find("td:nth-child(3)").text().trim(),
        englishName: $(tr).find("td:nth-child(4)").text().trim(),
        month: $(tr).find("td:nth-child(5)").text().trim(),
    };
    rows.push(rowData)
}
console.log(rows)
