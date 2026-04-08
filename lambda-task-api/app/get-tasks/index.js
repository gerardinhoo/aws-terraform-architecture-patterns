const { DynamoDBClient, ScanCommand } = require("@aws-sdk/client-dynamodb");
const client = new DynamoDBClient({});

exports.handler = async () => {
  try {
    const result = await client.send(new ScanCommand({
      TableName: process.env.TABLE_NAME
    }));

    const tasks = (result.Items || []).map((item) => ({
      id: item.id.S,
      title: item.title.S
    }));

    return {
      statusCode: 200,
      body: JSON.stringify(tasks)
    };
  } catch (error) {
    console.error(error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message })
    };
  }
};
