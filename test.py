import boto3
import json

def lambda_handler(event, context):
    client = boto3.client('lambda')

    response = client.invoke(
        FunctionName='RemoveUnusedSecurityGroups',
        InvocationType='RequestResponse'
    )

    response_payload = json.loads(response['Payload'].read().decode('utf-8'))

    return {
        'statusCode': 200,
        'body': json.dumps(response_payload)
    }

