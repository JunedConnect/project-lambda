# Project Lambda

The project builds a complete URL shortener service using **serverless AWS services** with **automated CI/CD pipelines** that deploy infrastructure and frontend code. The setup includes **CloudFront CDN** for global content delivery, **S3 static hosting** for the frontend, and **Lambda functions** for the backend API.

The architecture uses **serverless components** throughout, with **DynamoDB** for data storage, **API Gateway** for REST API management, and **CloudFront** for global content delivery. **Everything is automated**, from infrastructure deployment to frontend updates.

## Key Features

- **Lambda** - Serverless compute for URL shortening logic
- **API Gateway** - RESTful API management and HTTP endpoint handling
- **CloudFront** - Global CDN for fast content delivery and caching
- **S3** - Static website hosting with Origin Access Control (OAC)
- **DynamoDB** - NoSQL database for URL mapping storage with TTL
- **Route53** - DNS management and SSL certificate automation
- **ACM** - SSL/TLS certificate management for secure HTTPS
- **GitHub Actions** - Automated CI/CD for infrastructure and frontend deployment

## Why I Chose Serverless

Serverless means your code runs in response to events, not on constantly running servers. Each URL shortening request triggers a Lambda function that executes, processes the request, and shuts down completely. There's no server to keep warm, no containers to manage, and no idle costs. The entire backend is just functions that wake up when needed and disappear when done. This makes it ideal for applications where requests come and go unpredictably.

This architecture design means I'll be paying pennies in comparison to deploying the same application on a service like ECS. For reference, you can see the difference by comparing this serverless approach with my [ECS-based URL shortener project](https://github.com/JunedConnect/project-blue-green/) that uses containers and always-running infrastructure.

<br>

## Architecture

![Workflow Diagram](https://raw.githubusercontent.com/JunedConnect/project-lambda/main/images/workflow-diagram.png)

<br>

## Directory Structure

```
./
├── frontend/
│   ├── index.html          # Main web interface
│   └── error.html          # Error handling and health check
├── lambda/
│   ├── raw/                # Lambda source code
│   └── zip/                # Lambda deployment package
├── terraform/
│   ├── modules/            # Infrastructure modules
│   └── main.tf             # Root Terraform configuration
└── .github/workflows/      # CI/CD pipelines
```

<br>

## How It All Connects

**What the user sees:**
- Visit your domain → See the URL shortener website
- Enter a long URL → Get a short URL instantly
- Click a short URL → Redirected to the original website

**What happens behind the scenes:**
- **Frontend** served from S3 bucket via CloudFront CDN for fast loading (via caching)
- **API Gateway** directs requests to Lambda functions for URL processing
- **Lambda functions** handle URL shortening and storage using DynamoDB


<br>

## CI/CD Pipeline

The project includes automated GitHub Actions workflows:

- **Terraform Plan** - Reviews infrastructure changes before deployment
- **Terraform Apply** - Deploys AWS infrastructure
- **Terraform Destroy** - Cleans up all AWS resources
- **Frontend Deploy** - Uploads frontend files to S3 and invalidates CloudFront cache

<br>

## How to Use the App

### Web Interface

Access the application through your domain to use the web interface for URL shortening.

### App Functionality

- **URL Shortening**: Enter any long URL and get a shortened version
- **URL Redirection**: Click on shortened URLs to redirect to original URLs
- **Health Monitoring**: Check service status at the health page (`/health`)
- **Error Handling**: Graceful error messages for invalid requests

<br>

## Future Improvements

- **Health check on shortened URLs** - Verify if destination URLs are online before shortening
- **Most popular shortened URLs** - Analytics dashboard showing most accessed short links
- **Separation Concerns** - Dedicated Lambda for each endpoint (shorten, resolve, health)
- **Custom short codes** - Allow users to create custom short URLs (e.g., `yoursite.com/custom`)
- **Bulk URL shortening** - Upload CSV file to shorten multiple URLs at once
- **QR code generation** - Automatically generate QR codes for shortened URLs
- **API rate limiting** - Implement rate limiting to prevent abuse
- **URL preview** - Show preview of destination page before redirecting
- **Admin dashboard** - Management interface to view and manage all shortened URLs

<br>

|Here's what it will look like:|
|-------|
|Main Interface:|
| ![Main App](https://raw.githubusercontent.com/JunedConnect/project-lambda/main/images/website.png) |
|Health Check:|
| ![Health Check](https://raw.githubusercontent.com/JunedConnect/project-lambda/main/images/website-health.png) |
|URL Redirection:|
| ![URL Redirection](https://raw.githubusercontent.com/JunedConnect/project-lambda/main/images/website-redirection.png) |