# Serverless URL Shortener

This project demonstrates how to build a **serverless URL shortener** using AWS Lambda, API Gateway, and CloudFront. The architecture provides **high availability, automatic scaling, and cost-effective** URL shortening services with a modern web interface and robust API endpoints.

The project builds a complete URL shortener service using **serverless AWS services** with **automated CI/CD pipelines** that deploy infrastructure and frontend code. The setup includes **CloudFront CDN** for global content delivery, **S3 static hosting** for the frontend, and **Lambda functions** for the backend API.

The architecture uses **serverless components** throughout, with **DynamoDB** for data storage, **API Gateway** for REST API management, and **CloudFront** for global content delivery. **Everything is automated**, from infrastructure deployment to frontend updates, making it easy to maintain and scale the application.

## Key Features

- **Lambda** - Serverless compute for URL shortening logic
- **API Gateway** - RESTful API management and HTTP endpoint handling
- **CloudFront** - Global CDN for fast content delivery and caching
- **S3** - Static website hosting with Origin Access Control (OAC)
- **DynamoDB** - NoSQL database for URL mapping storage with TTL
- **Route53** - DNS management and SSL certificate automation
- **ACM** - SSL/TLS certificate management for secure HTTPS
- **GitHub Actions** - Automated CI/CD for infrastructure and frontend deployment

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
- **Terraform Apply** - Deploys AWS infrastructure (Lambda, API Gateway, CloudFront, S3, Route53)
- **Frontend Deploy** - Uploads frontend files to S3 and invalidates CloudFront cache
- **Terraform Destroy** - Cleans up all AWS resources when done

<br>

## How to Use the App

### Web Interface

Access the application through your domain to use the web interface for URL shortening.

**Features:**
- Clean, modern interface for URL shortening
- Real-time URL generation and copying
- Health check page accessible at `/health`
- Error handling for invalid URLs

### App Functionality

- **URL Shortening**: Enter any long URL and get a shortened version
- **URL Redirection**: Click on shortened URLs to redirect to original URLs
- **Health Monitoring**: Check service status at the health page
- **Error Handling**: Graceful error messages for invalid requests

<br>

## Future Improvements

- **Health check on shortened URLs** - Verify if destination URLs are online before shortening
- **Most popular shortened URLs** - Analytics dashboard showing most accessed short links
- **Separation of Lambda functions** - Dedicated Lambda for each endpoint (shorten, resolve, health)
- **Custom short codes** - Allow users to create custom short URLs (e.g., `yoursite.com/custom`)
- **Bulk URL shortening** - Upload CSV file to shorten multiple URLs at once
- **QR code generation** - Automatically generate QR codes for shortened URLs
- **API rate limiting** - Implement rate limiting to prevent abuse
- **API Gateway throttling** - Built-in request throttling
- **URL preview** - Show preview of destination page before redirecting
- **Admin dashboard** - Management interface to view and manage all shortened URLs

<br>

|Here's what it will look like:|
|-------|
|Main Interface:|
| ![Main App](https://raw.githubusercontent.com/JunedConnect/project-lambda/main/images/Website.png) |
|Health Check:|
| ![Health Check](https://raw.githubusercontent.com/JunedConnect/project-lambda/main/images/website-health.png) |
|URL Redirection:|
| ![URL Redirection](https://raw.githubusercontent.com/JunedConnect/project-lambda/main/images/Website-Redirection.png) |