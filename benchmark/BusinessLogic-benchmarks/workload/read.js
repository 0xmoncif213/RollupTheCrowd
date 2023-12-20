const fs = require('fs'); 



var data = fs.readFileSync("./workload.json");
var data= JSON.parse(data);


console.log(data[0][0].amount);