// file export = ip_root_payload.zip
// Having trouble figuring out how to
// actually have this be the root "/" endpoint
// Renaming /root for the time being

exports.handler = (event, context, callback) => {
  var responseBody = { event: event, context: context, foo: "from 02_ip_scan" };

  var response = {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Origin": "*"
    },
    body: JSON.stringify(responseBody),
    isBase64Encoded: false
  };
  callback(null, response);
};
