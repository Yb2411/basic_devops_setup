import os
import json

def lambda_handler(event, context):
    candidate_name = "Yassine" 
    if 'requestContext' in event and 'http' in event['requestContext'] and 'sourceIp' in event['requestContext']['http']:
        source_ip = event['requestContext']['http']['sourceIp']
    else:
        source_ip = "Unknown"

    response = {
        "candidate_name": candidate_name,
        "dynamic_value": source_ip
    }

    return {
        "statusCode": 200,
        "body": json.dumps(response)
    }
