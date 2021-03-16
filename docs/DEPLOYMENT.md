# Deployment

Deployment strategy is really up to you, however for the deployment of this project [Blue Green Deployment strategy](https://semaphoreci.com/blog/blue-green-deployment) has been implemented.

This has been setup to be automated, with a few things that will need to be manually done by the user:

## Prerequisites

For the initial setup there are a couple of things that may need to be done manually. The below have been scoped to different cloud providers.

### AWS 

This is if using AWS as the cloud provider, these are the steps required. However, when using other cloud providers, the steps will more or less be the same with minor additions and takeaways

#### Key Pair

Create and download a new key pair in AWS for CircleCI(or your preferred CI) to use to work with AWS resources. Name this key pair whatever you want so that it works with your Cloud Formation templates. 

### IAM user

Setup AWS machine/bot user with programmatic access. This is a necessary step, as the CI server will need API access via the aws cli to execute commands such as setting up infrastructure or tearing it down upon failure of deployment. You can limit the 
scope of permissions to those which you need. Once you have this user setup, AWS console will provided the `aws_secret_access_key` & `aws_access_key_id` which you should setup as environment variables in the CI provider:

```env
AWS_ACCESS_KEY_ID=(from IAM user with programmatic access)
AWS_SECRET_ACCESS_KEY= (from IAM user with programmatic access)
AWS_DEFAULT_REGION=(your default region in aws)
TYPEORM_CONNECTION=postgres
TYPEORM_MIGRATIONS_DIR=./src/migrations
TYPEORM_ENTITIES=./src/modules/domain/**/*.entity.ts
TYPEORM_MIGRATIONS=./src/migrations/*.ts
TYPEORM_HOST={your postgres database hostname in RDS}
TYPEORM_PORT=5532 (or the port from RDS if it’s different)
TYPEORM_USERNAME={your postgres database username in RDS}
TYPEORM_PASSWORD={your postgres database password in RDS}
TYPEORM_DATABASE={your postgres database name in RDS}
```

Note that for this project, the environment variables above have been added to the `udapeople-ctx` which is a container for environment variables that can be used across projects in CircleCI.
You can scope these to the project (if using CircleCI as the CI provider) or you can use the same approach. As long as the job that requires these steps has access to these environment variables

### RDS PostgreSQL instance

Add a PostgreSQL database in RDS that has public accessibility. Take note of the connection details (hostname, username, password). As long as you marked "Public Accessibility" as "yes", you won't need to worry about VPC settings or security groups.

### CloudFront Ditribution Primer

At the very end of the pipeline, you will need to make a switch from the old infrastructure to the new as this is using the Blue Green Deployment strategy. We will use CloudFormation and CloudFront to accomplish this. 

However, for this to work, you must do a few things manually:

1. Create an S3 Bucket with the name that combines your deployment & a random string or a string that is memorable

2. Run the [cloud formation template](../infra/web/cloudfront.yaml) locally and use the string from step 1 as the Workflow ID parameter.

Once that is done, subsequent executions of that template will modify the same CloudFront distribution to make the blue-to-green switch without fail.


### Prometheus Server

A great article on setting up Monitoring with Prometheus on an EC2 instance: https://codewizardly.com/prometheus-on-aws-ec2-part1/