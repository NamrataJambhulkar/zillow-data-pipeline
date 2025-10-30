import http.client
import json

# Connect to RapidAPI Zillow56
conn = http.client.HTTPSConnection("zillow56.p.rapidapi.com")

headers = {
    'x-rapidapi-key': "d71744bbbamsh1ab1fe70c9f464ep14918cjsnd8eea99e6e02",
    'x-rapidapi-host': "zillow56.p.rapidapi.com"
}

# Example request
conn.request("GET", "/search?location=Los%20Angeles%2C%20CA&output=json", headers=headers)

res = conn.getresponse()
data = res.read()

# Convert to JSON
try:
    response_json = json.loads(data.decode("utf-8"))
except json.JSONDecodeError:
    print("Response not in JSON format.")
    print(data.decode("utf-8"))
    exit()

# Save locally for inspection
with open("sample_response.json", "w") as f:
    json.dump(response_json, f, indent=4)

print("Sample response saved as sample_response.json")
