import json
import hashlib
import time
import os
from ddb import put_mapping, get_mapping

def lambda_handler(event, context):
    """
    Lambda handler for URL Shortener API
    Handles different HTTP methods and paths
    """
    
    # Log the entire event for debugging
    print(f"=== LAMBDA INVOKED ===")
    print(f"Full event: {json.dumps(event, indent=2)}")
    print(f"Context: {context}")
    
    # Extract HTTP method and path
    http_method = event.get('httpMethod', 'GET')
    path = event.get('path', '/')
    path_parameters = event.get('pathParameters', {})
    
    print(f"Received request: {http_method} {path}")
    print(f"Path parameters: {path_parameters}")
    
    # Handle CORS preflight
    if http_method == 'OPTIONS':
        print("Handling CORS preflight request")
        cors_response = {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type'
            },
            'body': ''
        }
        print(f"CORS response: {cors_response}")
        return cors_response
    
    # Route requests based on path
    if path == '/healthz':
        print("Routing to health check")
        return handle_health()
    elif path == '/shorten' and http_method == 'POST':
        print("Routing to shorten")
        return handle_shorten(event)
    elif path_parameters and 'short_id' in path_parameters:
        # Handle path parameters (for API Gateway with {short_id})
        short_id = path_parameters['short_id']
        print(f"Extracted short_id from path parameters: {short_id}")
        return handle_resolve(short_id)
    elif path.startswith('/') and len(path) > 1 and path not in ['/healthz', '/shorten']:
        # Extract short_id from path (remove leading slash)
        short_id = path[1:]
        print(f"Routing to resolve with short_id: {short_id}")
        return handle_resolve(short_id)
    else:
        print("No matching route found")
        not_found_response = {
            'statusCode': 404,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({'error': 'Not found'})
        }
        print(f"404 response: {not_found_response}")
        return not_found_response

def handle_health():
    """Health check endpoint"""
    print("=== HEALTH CHECK ===")
    print("Processing health check request")
    
    response = {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json'
        },
        'body': json.dumps({
            'status': 'ok',
            'ts': int(time.time())
        })
    }
    
    print(f"Health check response: {response}")
    return response

def handle_shorten(event):
    """Handle URL shortening requests"""
    print("=== SHORTEN URL ===")
    print("Processing URL shortening request")
    
    try:
        # Parse request body
        body_str = event.get('body', '{}')
        print(f"Raw request body: {body_str}")
        
        if not body_str or body_str.strip() == '':
            body_str = '{}'
        
        body = json.loads(body_str)
        url = body.get('url')
        
        print(f"Parsed request body: {body}")
        print(f"URL to shorten: {url}")
        
        if not url:
            print("ERROR: No URL provided")
            error_response = {
                'statusCode': 400,
                'headers': {
                    'Access-Control-Allow-Origin': '*',
                    'Content-Type': 'application/json'
                },
                'body': json.dumps({'error': 'url required'})
            }
            print(f"Error response: {error_response}")
            return error_response
        
        # Generate short code
        short = hashlib.sha256(url.encode()).hexdigest()[:8]
        print(f"Generated short code: {short}")
        
        # Store mapping in DynamoDB
        print(f"Storing mapping: {short} -> {url}")
        put_mapping(short, url)
        print("Successfully stored in DynamoDB")
        
        response = {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({
                'short': short,
                'url': url
            })
        }
        
        print(f"Shorten response: {response}")
        return response
        
    except Exception as e:
        print(f"ERROR in handle_shorten: {str(e)}")
        return {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({'error': str(e)})
        }

def handle_resolve(short_id):
    """Handle URL resolution requests"""
    print("=== RESOLVE URL ===")
    print(f"Processing URL resolution for short_id: {short_id}")
    
    try:
        # Get mapping from DynamoDB
        print(f"Looking up short_id: {short_id}")
        item = get_mapping(short_id)
        print(f"DynamoDB response: {item}")
        
        if not item:
            print(f"ERROR: Short ID {short_id} not found")
            not_found_response = {
                'statusCode': 404,
                'headers': {
                    'Access-Control-Allow-Origin': '*',
                    'Content-Type': 'application/json'
                },
                'body': json.dumps({'error': 'not found'})
            }
            print(f"Resolve 404 response: {not_found_response}")
            return not_found_response
        
        # Return redirect response
        redirect_url = item['url']
        print(f"Found URL: {redirect_url}")
        
        # Add protocol if missing
        if not redirect_url.startswith(('http://', 'https://')):
            redirect_url = 'https://' + redirect_url
            print(f"Added protocol, new URL: {redirect_url}")
        
        print(f"Returning 302 redirect to: {redirect_url}")
        
        response = {
            'statusCode': 302,
            'headers': {
                'Location': redirect_url,
                'Access-Control-Allow-Origin': '*'
            },
            'body': ''
        }
        
        print(f"Redirect response: {response}")
        return response
        
    except Exception as e:
        print(f"ERROR in handle_resolve: {str(e)}")
        error_response = {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({'error': str(e)})
        }
        print(f"Resolve error response: {error_response}")
        return error_response
