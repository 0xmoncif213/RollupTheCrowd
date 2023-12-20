const Web3 = require('web3');
let web3 = new Web3(this.nodeUrl);
let fs = require('fs');


function generateNewAccount(){
    let address = web3.eth.accounts.create()
    return address.address
}

function makeRandomString(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}
function getRandomInt(min, max) {
    const randomDecimal = Math.random();
    const randomInt = Math.floor(randomDecimal * (max - min + 1)) + min;
    return randomInt;
}


function write(path , newData){
    var data = fs.readFileSync(path);
    var data= JSON.parse(data);
    data.push(newData);
    fs.writeFile(path, JSON.stringify(data, null), err => {
        if(err) throw err;
        console.log("New test data generated !");
    });  
}


let workload = [];

function genrateWorkload(n){
    for ( var i = 0; i < n; i++ ) {
        let args = {
            hash: makeRandomString(15),
            requester: generateNewAccount(), 
            worker:generateNewAccount(),
            amount: getRandomInt(1, 500), 
            bidHash: makeRandomString(10),
            solutionHash: makeRandomString(13)}
        workload.push(args);
    }
    write("./workload.json",workload)
}


genrateWorkload(3000)


