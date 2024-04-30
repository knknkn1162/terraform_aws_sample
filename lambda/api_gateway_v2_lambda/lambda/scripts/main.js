exports.handler = (event, context, callback) => {
  // for output format, see the link,
  // see https://docs.aws.amazon.com/ja_jp/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html#http-api-develop-integrations-lambda.response
  const output = {
    'statusCode': 200,
    'body': JSON.stringify({result: 'ok'})
  }
  console.log('Hello, logs!');
  callback(null, output);
}