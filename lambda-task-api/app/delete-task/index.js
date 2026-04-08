const { DynamoDBClient, DeleteItemCommand } = require("@aws-sdk/client-dynamodb");
const client = new DynamoDBClient({});

exports.handler = async (event) => {
  try {
    const id = event.pathParameters.id;

    await client.send(new DeleteItemCommand({
      TableName: process.env.TABLE_NAME,
      Key: {
        id: { S: id }
      }
    }));

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Task deleted"
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
