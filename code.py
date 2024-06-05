import json
import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    response = ec2.describe_security_groups()

    security_groups = response['SecurityGroups']
    unused_security_groups = []

    for sg in security_groups:
        if sg['GroupName'] == 'default':
            continue
        filters = [{'Name': 'instance.group-id', 'Values': [sg['GroupId']]}]
        instances = ec2.describe_instances(Filters=filters)
        if not instances['Reservations']:
            unused_security_groups.append(sg['GroupId'])

    for sg_id in unused_security_groups:
        try:
            ec2.delete_security_group(GroupId=sg_id)
            print(f"Deleted security group: {sg_id}")
        except Exception as e:
            print(f"Error deleting security group {sg_id}: {e}")

    return {
        'statusCode': 200,
        'body': json.dumps(f"Deleted unused security groups: {unused_security_groups}")
    }
