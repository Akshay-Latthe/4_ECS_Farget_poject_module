# Applicetion deployment with AWS ECS Frget with Terraform Modules

This project is designed to deploy WordPress on Amazon Elastic Container Service (ECS) using modular components for easy deployment and maintenance.

# Requirements  are as follows:
### We need to setup the following: 
#### 1.  VPC with two public, two private and two database subnetes.
#### 2.	Setup one ECS in  private sub nets. Install Word Press in the location /var/www/html.
#### 3.	Word Press on ECS with load balancing and should be auto-scaling.
#### 4.	In order to access Word Press you need to use AWS ALB deployed into the public sub nets.
#### 5.	And EFS Drive should be mounted to the machine at location /var/www/html/wp-content/uploads.
#### 6.	Minimum One MySQL should be deployed into db private subnet and Word Press needs to use that database.
#### 7.	MySQL DB should be deployed into db private subnet and attached with Redis Elastic cash.
#### 8.	word press Docker image is pushed to aws ECR from Docker Hub and used in AWS ECS cluster.
#### 9.	Domain also we have to use for hosting word press web. By (route53, SSL certificate, hosted zone )

## STEPS AS PER FOLLOWING:

#### 1) First create AWS ECR REPO for this task by manually on aws account 
#### 2) Use the docker file for the creating docker image of wordress and use docker commands as per the below steps & push that docker image to  AWS ECR .
#### 3) VPC – NETWORKING two public, two private, and two database sub nets.
#### 4) Create RDS for Myslq in database sub nets
#### 5) Create Redis Elastic cash and attach to RDS database in  database subnets.
#### 6) LOAD BALANCER – APPLICATION with target group in public subnets
#### 7) Auto scale with the rules – 
####     1) Scale up CPU utilization is more than 50% = CPU utilization > 50%
####     2) Scale down CPU utilization is less than 30% = CPU utilization < 30%
#### 8) Create EFS for aws ECS (EFS IS COMMON STORAGE FOR ALL WORDPRESS SERVERS)
#### 9) PRIVATE SUBNETS WITH AUTO SCALING for ECS cluster
#### 10) Create IMA roles AND Polices as per the terraform code and as per the # "REFERRED DOCUMENTATION" : 
#### 11) Creating ECS cluster should use:
####          1) WordPress image from ECR which is created in abouve steps, 
####          2) AWS EFS at location of "/var/www/html/wp-content/" in docker image of wordpress. EFS which is created in abouve steps,
####          3) It should use the Application Load Balancer which is created in abouve steps
####          4) It should use the Auto scaling and Target group which is created in abouve steps of 
####           It is attached using the following terraform code 
####          5) It should content service and with minimum CPU and storage required run Docker image 
####          6) Secretes from secrete manager used in this for rds and wordpress image in ECS
#### 12) Create a Domain; also, we have to use it for hosting WordPress web. By (Route53, SSL certificate, hosted zone) and attach it to the auto-scaling group.


# How to deploy a three-tier architecture with AWS ECS in AWS using Terraform?

### What is Terraform?

Terraform is an open-source infrastructure as a code (IAC) tool that allows to creation, manage & deploy the production-ready environment. Terraform codifies cloud APIs into declarative configuration files. Terraform can manage both existing service providers and custom in-house solutions.

![1](https://github.com/Akshay-bl/2_WORDPRESS_HOSTING/blob/main/1.png)


## In this tutorial, I will deploy a three-tier application in AWS using Terraform Architecture looks like blow.

![2](https://github.com/Akshay-bl/3_wordpress_with_ECS_cluster/blob/main/2.png)

## Prerequisites:

* Basic knowledge of AWS ECS, ECR, AWS IAM,RDS, EFS, VPC, ROUTE53, AWS ACM, AWS SECRETE MANAGER, AUTO SCALING, LOAD BALANCER 
* Basic knowledge of Terraform & Docker 
* AWS account
* AWS Access & Secret Key
* DockerHub account 

## Installation Prerequisites :

* AWS CLI is installed and configured with aws account
* Terraform installed and configured
* Docker installed and configured

> In this project, I have used some variables also that I will discuss later in this article.

## Steps:

**Step 1: - Clone the git repository**   

===========================================================================

**Step 2:- First create AWS ECR REPO for this task by manually on aws account**

===========================================================================

**Step 3:-  Go to "docker" directory and in that  Docker file as per Git repo**

*We use this to docker image of the Wordpress on AWS ECS. We push that on AWS ECR. This DOCKER IMAGE we are using in the ECS group.*

  ## steps:

Run docker comands :
#imp coamands most used 
1) build docker image form docker file 

docker build -t <name_of_image> .  

2) port mapping and runing docker container

docker run -td --name <container_name> -p 80:80 <name_of_image>  

3) Go inside the docker container

docker exec -it <conatainer_name> /bin/bash   (enter inside the docker conatainer)

4) chek this container runing properly 

===========================================================================

**Step 4:-  push docker image to  AWS ECR REPO** 

push docker image to  AWS ECR REPO you created USING AWS ECR REPO COMANDS FOR>> in aws ECR 

commands in AWS ECR "VIEW PUSH COMMANDS" which ECR registry is creted in "Step 2"

>>LOGIN , BUILD IMAGE , TAG IMAGE , PUSH IMAGE TO ECR REPO

===========================================================================

**Step 5:- Go to "3_WORPDRESS_WITH_ECS_CLUSTER" directory and in that  TERRAFORM files as per Git repo THEN RUN THIS TERRFORM CODE WITH REQUIRED CHANGES**

### for IAM ROLES CHECK , TASK DEIFNATION , Route 53, DNS AND OTHER CONFIAGETON, AUTO SCALING POLICY 
### ENTER THE RDS PASSWORD AND USERNAME BY Console as per below (senistive)

##db_user = "" {enter mysql rds user name through console as you wish }
##db_password = "" {enter password for mysql rds through console as you wish minimum length is 8 don't use special characters }

## STEPS: 
* go to the "3_wordpress_with_ECS_cluster" directory

## RUN Follwing commands: 

* "terraform init" is to initialize the working directory and downloading plugins of the provider

* "terraform plan" is to create the execution plan for our code

## ENTER THE RDS PASSOWRD AND USERNAME BY Console as per below (senistive)

##db_user           = "" {enter mysql rds user name through console as you wish }
##db_password       = "" {enter password for mysql rds through console as you wish minimum length is 8 don't use special characters }

* "terraform apply" is to create the actual infrastructure. 

## ENTER THE RDS PASSWORD AND USERNAME BY Console as per below (sensitive)

##db_user           = "" {enter mysql rds user name through console as you wish }
##db_password       = "" {enter password for mysql rds through console as you wish minimum length is 8 don't use special characters }

### **NOTE : It will ask you to provide the Access Key and Secret Key in order to create the infrastructure. So, instead of hard coding the Access Key and Secret Key, it is better to apply at the run time.**

===========================================================================

**Step 6:- "For Troubleshooting & Debugging The problems if there is** 
### Access ECS CONTAINER BY BELOW COMMANDS 
#steps :
### 1) run 1st command using <cluster_name> and <service_name> and <region>
### 2) aws ecs update-service --service analec-staging-ibcrm-window-service --cluster analec-staging-ecs-cluster --region us-west-2 --enable-execute-command
##this command will show something output wait if {not showing any output then you are doing wrong something }
### 3)stop all task in that cluster and wait till it runs a new task 
### 4)take  <task_ID> of the new task and pest in the below command and run the command.
### 5) aws ecs execute-command --region us-west-2 --cluster <cluster_name> --task <task_ID> --command "/bin/bash" --interactive

### COMMANDS REFERENCE   

aws ecs update-service --service <service_name> --cluster <cluster_name> --region <region> --enable-execute-command

aws ecs execute-command --region <region> --cluster <cluster_name> --task <task_ID> --command "/bin/bash" --interactive

---------------------------------------------------------------------------

## REFERENCE  EXAMPLE HOW TO USE THESE 

### COMMANDS :

Exmple: aws ecs update-service --service GameDay-Service --cluster GameDay-Cluster  --region us-east-1 --enable-execute-command

Exmple: aws ecs execute-command --region us-east-1 --cluster GameDay-Cluster --task  ************bb1c0fc080c87661  --command "/bin/bash"  --interacti

===========================================================================

**Step 7:- ONCE YOU INSIED EC2 OR ECS SERVER THEN :**
 WE HAVE TO CHECK RDS IS CONNECTED TO ECS CLUSTER BY FOLLWING CONADS 
We have to install netcat as per below 
Install Netcat Steps:

apt-get update && apt-get install -y netcat
RUN THIS  COMAND TO CHECK RDS IS CONNECTED TO ECS / EC2
1) nc -z -v <hostname> <port>
  <hostname> = endpoint of RDS
2) enter DBname <DBname>
3) enter Masterusername  <Masterusername>
4) enter Masterpassword  <Masterpassword>

example:

1) nc -z -v awswp.c****kx.us-east-1.rds.amazonaws.com 3306
Endpoint of RDS  "awswp.c*******kx.us-east-1.rds.amazonaws.com"
2) DBname  wpdb
3) Masterusername  "admin"
4) Masterpassword   adminadmin


**Step 8:- Verify the resources**

* Terraform will create below resources

  * VPC
  * Public Subnets, Private Subnets, RDS Subnets
  * Route Table
  * Internet Gateway
  * Route Table Association
  * Security Groups for Web & RDS instances
  * Basstion Host EC2
  * EFS Storage
  * Application Load Balancer with target group
  * ECS CLUSETER AND TASKS for autoscalig 
  * RDS instance 
  * Redis Cache instances are created 
  * Route53 and ACM with DNS for "domain name"

===========================================================================

**Step 9:- Verify DNS is workig ON incognito mode"**

Once the resource creation finishes you can get the DNS  in AWS ACCOUNT ON ROUTE53 ACCESS THAT "

That’s it now, you have learned how to create various resources in AWS using Terraform.


# "REFERRED DOCUMENTATION" :

## Reference links

https://medium.com/@bradford_hamilton/deploying-containers-on-amazons-ecs-using-fargate-and-terraform-part-2-2e6f6a3a957f

===================================================== 
### Secret Manager Policy
### AWS ROLE FOR cloudwatch_full_access_role ECS clutser  
https://docs.aws.amazon.com/mediaconnect/latest/ug/iam-policy-examples-asm-secrets.html

========================================================================
### ECS Execute Policy 
### This policy grants permission for executing ECS commands.
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html

====================================================
### aws ecs fargate can't fetch secret manager  
https://stackoverflow.com/questions/55568371/aws-ecs-fargate-cant-fetch-secret-manager
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/secrets-app-secrets-manager.html

====================================================

### EFS Access Policy ===
This policy allows access to Elastic File System (EFS).
https://docs.aws.amazon.com/efs/latest/ug/accessing-fs-create-access-point.html
ECS Logging with Cloudwatch 
1 Attach Policy
https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-using-import-tool-cli-cloudwatch-iam-role.html



