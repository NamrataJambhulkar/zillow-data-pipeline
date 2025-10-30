# AWS Lambda function for Zillow data ingestion
# (Code originally written and deployed in AWS Lambda console)

import json
import os
import http.client
import datetime
import boto3
import time

s3 = boto3.client('s3')

def lambda_handler(event, context):
    conn = http.client.HTTPSConnection("zillow56.p.rapidapi.com", timeout=10)

    headers = {
        'x-rapidapi-key': os.environ['RAPIDAPI_KEY'],
        'x-rapidapi-host': "zillow56.p.rapidapi.com"
    }

    cities = ["Los Angeles, CA"]
    statuses = ["forSale", "forRent", "sold"]

    all_data = []

    for city in cities:
        for status in statuses:
            location = city.replace(" ", "%20").replace(",", "%2C")
            url = f"/search?location={location}&status={status}&output=json"

            conn.request("GET", url, headers=headers)
            res = conn.getresponse()
            data = res.read()

            try:
                response_json = json.loads(data.decode("utf-8"))
                all_data.append({
                    "city": city,
                    "status": status,
                    "data": response_json
                })
            except Exception as e:
                print(f"Error for {city} ({status}): {e}")

            time.sleep(12)

    file_name = f"zillow_data_{datetime.datetime.now().strftime('%Y-%m-%d_%H-%M-%S')}.json"

    s3.put_object(
        Bucket="zillow-raw-data-3010",
        Key=file_name,
        Body=json.dumps(all_data, indent=4)
    )

    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': "Successfully fetched and uploaded Zillow data to S3",
            'file_name': file_name
        })
    }
