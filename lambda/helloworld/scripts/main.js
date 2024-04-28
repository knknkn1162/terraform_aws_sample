const output = {"foundation": "Mozilla", "model": "box", "week": 45, "transport": "car", "month": 7}

exports.handler = (event, context, callback) => {
  console.log('Hello, logs!');
  console.log(event);
  console.log(context);
  callback(null, output);
}