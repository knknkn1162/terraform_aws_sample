const aws = require('aws-sdk');
const conn = new aws.DynamoDB.DocumentClient();
const TableName = 'TestTable';

function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}

exports.handler = async(event, context, callback) => {
  let res = await put(getRandomInt(10000));
  callback(null, res);
}

async function put(num){
  str_num = String(num).padStart(5, '0');
  console.log(str_num);
  var params_put = {
    TableName: TableName,
    Item:{
      Id: str_num,
      Name: `No: ${str_num}`,
      Score: num,
    },
  };
  await conn.put(params_put).promise();
}