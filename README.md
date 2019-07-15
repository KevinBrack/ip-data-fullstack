# Full stack application to retrieve information about a given IP address

### Links

[Trello](https://trello.com/b/M8z76pn6/ip-challenge)

[Back End Deployment](https://1gr9avh006.execute-api.us-east-2.amazonaws.com/prod/root)

[Front End Deployment](http://www.investigateip.net.s3-website.us-east-2.amazonaws.com/)

### Tech stack

 - Serverless NodeJS with AWS Lambda endpoints on an API Gateway
 - React app client served statically in an S3 Bucket
 - All AWS resources provisioned through code with Terraform

### Terraform

The Terraform CLI is required to reproduce this project. Installation instructions can be found here https://www.terraform.io/downloads.html

This project requires 2 variables I did not commit to the repository. They can be written in a `secrets.tfvars` file and included with the command to provision aws resources. When ready to provision resources use `terraform apply -var-file="secrets.tfvar"`

 - accountId = [AWS account id]
 - virusTotalKey = [obtained from virustotal.com]

### Summary

This project was a 48 hour take home challenge. I would have loved to spend more time fleshing out the app. I will continue to build this into a portfolio piece I am proud of.

I learned so much during this attempt. Not just Terraform, but all kinds of AWS resources and serverless Node. This is easily one of the most rewarding solo projects I have undertaken to date.