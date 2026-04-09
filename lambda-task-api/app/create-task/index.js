const { DynamoDBClient, PutItemCommand } = require("@aws-sdk/client-dynamodb");
const client = new DynamoDBClient({});

exports.handler = async (event) => {
  try {
    const body = JSON.parse(event.body);

    const task = {
      id: Date.now().toString(),
      title: body.title
    };

    await client.send(new PutItemCommand({
      TableName: process.env.TABLE_NAME,
      Item: {
        id: { S: task.id },
        title: { S: task.title }
      }
    }));

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Testing ci cd",
        task
      })
    };
  } catch (error) {
    console.error(error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message })
    };
  }
};
