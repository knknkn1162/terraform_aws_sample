exports.handler = (event, context, callback) => {
  // for output format, see the link,
  // https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-output-format
  const output = {
    'statusCode': 200,
    'body': JSON.stringify({result: 'ok'})
  }
  console.log('Hello, logs!');
  callback(null, output);
}