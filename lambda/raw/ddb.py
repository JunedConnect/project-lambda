import os
import boto3

# Initialise DynamoDB resource
# TABLE_NAME will be provided via Lambda environment variable
_table = None

def get_table():
    """Get DynamoDB table instance"""
    global _table
    if _table is None:
        table_name = os.environ.get("TABLE_NAME")
        if not table_name:
            raise ValueError("TABLE_NAME environment variable not set")
        _table = boto3.resource("dynamodb").Table(table_name)
    return _table

def put_mapping(short_id: str, url: str):
    """Store URL mapping in DynamoDB"""
    table = get_table()
    table.put_item(Item={"id": short_id, "url": url})

def get_mapping(short_id: str):
    """Retrieve URL mapping from DynamoDB"""
    table = get_table()
    resp = table.get_item(Key={"id": short_id})
    return resp.get("Item")
