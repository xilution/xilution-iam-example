<h1 align="center" style="border-bottom: none;">xilution-web-frontend-example</h1>
<p>
An example demonstrating how to build a web app using Xilution's IAM suite (Elephant, Rhino, Hippo and Zebra) and Coyote.
<p>
<p align="center">
  <a href="https://github.com/xilution/xilution-web-frontend-example/issues">
    <img alt="Issues" src="https://img.shields.io/github/issues/xilution/xilution-web-frontend-example.svg">
  </a>
  <a href="https://github.com/xilution/xilution-web-frontend-example/network">
    <img alt="Forks" src="https://img.shields.io/github/forks/xilution/xilution-web-frontend-example.svg">
  </a>
  <a href="https://github.com/xilution/xilution-web-frontend-example/stargazers">
    <img alt="Stars" src="https://img.shields.io/github/stars/xilution/xilution-web-frontend-example.svg">
  </a>
  <a href="https://github.com/xilution/xilution-web-frontend-example/blob/master/LICENSE">
    <img alt="License" src="https://img.shields.io/github/license/xilution/xilution-web-frontend-example.svg">
  </a>
</p>
<p align="center">
  <a href="https://travis-ci.org/xilution/xilution-web-frontend-example">
    <img alt="Travis" src="https://img.shields.io/travis/xilution/xilution-web-frontend-example.svg">
  </a>
</p>
<p align="center">
  <a href="https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fxilution%2Fxilution-web-frontend-example">
    <img alt="Tweet" src="https://img.shields.io/twitter/url/https/github.com/xilution/xilution-web-frontend-example.svg?style=social">
  </a>
</p>

## Use Case

TODO - Describe the use case

## Features

TODO - add features

## General

### To Install Dependencies

1. Run `yarn install` to download dependencies.

### To Verify The Source Code

1. Run `yarn verify`.

## Prerequisites

1. Install Docker Desktop: https://www.docker.com/products/docker-desktop
1. Install NVM: https://github.com/nvm-sh/nvm
1. Install Yarn: https://yarnpkg.com
1. Install jq: https://stedolan.github.io/jq/
1. Install cURL: https://curl.haxx.se/

1. Create a Xilution Account
    1. Open [https://prod.register.xilution.com](https://prod.register.xilution.com) to create a Xilution Prod account.
    1. Open [https://test.register.xilution.com](https://test.register.xilution.com) to create a Xilution Test account.
    
    * Note: Xilution Test and Prod accounts are not synchronized.

## Set Up

1. Set Up an API

This example integrates with the API created in https://github.com/xilution/xilution-graphql-backend-example.
We recommend running through it before moving on with the rest of this example.

1. Create an environment variables file.

    1. Run `touch .env` to create a new environment variables file.
    1. Run `echo "XILUTION_ENVIRONMENT={environment}" >> .env` to add your environment preference to the environment an variables file (.env).
        * {environment} is a Xilution environment. One of 'test' or 'prod'. Should be the same environment you used in `xilution-graphql-backend-example`. 
    1. Run `echo "XILUTION_SUB_ORGANIZATION_ID={sub-organization-id}" >> .env`.
        * {sub-organization-id} is found in the `.env` file created when you ran through `xilution-graphql-backend-example`. 

1. Get an Access Token with your Xilution Account Credentials

    1. Run `yarn xln:authentication:token-from-user-credentials`.
        * Note: You will be prompted for your Xilution account username and password.
        * Note: The access token saved to the environment variables file will expire in one hour.

1. Activate Rhino

    Xilution [Rhino](https://products.xilution.com/basics/rhino) is part of Xilution's IAM suite and is used to manage sub-organization users.

    1. Run `yarn xln:rhino:activate`.
    
    * To see the Rhino activation status, run `yarn xln:rhino:show-activation` to see the Rhino activation status.
    * To deactivate Rhino, run `yarn xln:rhino:deactivate`.

1. Add an IAM User to the Sub-Organization

    1. Run `yarn xln:rhino:sign-up-iam-user {email} {username}`.
        * {email} is the new user's email address. Enter an email address that you have access to.
        * {username} is the new user's username.
        * A verification code will be emailed to the email address you entered when signing up the new user.
    
    * To see the sub-organization's users run, `yarn xln:rhino:show-users`.
    * To delete a sub-organization's user run, `yarn xln:rhino:delete-user {user-id}`.
    
    * TODO - make a note about needing a credit card in Prod.

1. Verify the New User's Email Address

    1. Run `yarn xln:rhino:verify-user-email {username} {code}`.
        * {username} is the new user's username.
        * {code} is the verification code the you received in your email inbox.

1. Activate Hippo For Account and Sub Organization

    Xilution [Hippo](https://products.xilution.com/basics/hippo) is part of Xilution's IAM suite and is used to manage sub-organization clients.

    1. Run `yarn xln:hippo:activate-for-account-organization`.

    * To see the Hippo activation status, run `yarn xln:hippo:show-activation-for-account-organization` to see the Hippo activation status.
    * To deactivate Hippo, run `yarn xln:hippo:deactivate-for-account-organization`.

    1. Run `yarn xln:hippo:activate-for-sub-organization`.

    * To see the Hippo activation status, run `yarn xln:hippo:show-activation-for-sub-organization` to see the Hippo activation status.
    * To deactivate Hippo, run `yarn xln:hippo:deactivate-for-sub-organization`.

1. Add a Clients to the Sub-Organization

    1. Run `yarn xln:hippo:create-iam-client`.
    1. Run `yarn xln:hippo:create-web-client`.

    * To see the sub-organization's clients run, `yarn xln:hippo:show-clients`.
    * To delete a sub-organization's client run, `yarn xln:hippo:delete-client {client-id}`.

1. Update the Sub Organization's IAM Client ID

    1. Run `yarn xln:elephant:update-iam-client-id`.

## Running Locally

1. Run `export $(grep -v '^#' .env | xargs)`.

    * Requires the Set Up step to be complete.

1. Run `yarn start-connected-to-locally-hosted-api` or `yarn start-connected-to-fox-hosted-api`.

    1. Open `http://localhost:3124` to view the running web application.
    1. `Ctrl-c` to stop.

## Docker

### To build the Docker image
This tags your docker image as `xilution-web-frontend-example`.

1. Run `yarn docker:build`.

### To run the Docker image locally

1. Run `yarn docker:start`.

    1. Open `http://localhost` to view the running web application.

### To stop the Docker image

1. Run `yarn docker:stop`.

### To publish the Docker image to Docker Hub
You'll need a [Docker Hub](https://hub.docker.com/) account to execute the following.

1. Run `yarn docker:publish` to push the image to your Docker Hub account.

## Xilution Coyote
The following instructions describe how to host this example on Xilution Coyote
Xilution [Coyote](https://products.xilution.com/content-delivery/coyote) is a static content hosting service.

### Activate Coyote

Coyote must be activated on your Xilution Account before it's available for use.

1. Run `yarn xln:coyote:activate`.

* To see the Coyote activation status, run `yarn xln:coyote:show-activation` to see the Coyote activation status.
* To deactivate Coyote, run `yarn xln:coyote:deactivate`.

### Create a Coyote Instance
A Coyote Instance contains data that instructs Coyote on how to host your content.
You provision a Coyote Instance to make your content available.
Likewise, you deprovision a Coyote Instance to take your content offline.

1. Run `yarn xln:coyote:create-instance`.

* To see your instances, run `yarn xln:coyote:show-instances`.
* To delete a instance, run `yarn xln:coyote:delete-instance {instance-id}`

### Provision the Coyote Instance

1. Run `yarn xln:provision-coyote-instance`, to provision the Coyote instance.
1. Run `yarn xln:show-coyote-instance-status`, to see the status of your Coyote instance.
It can take up to 2 minutes to fully provision your Fox instance.
Provisioning is complete when you see the following.
    ```json
    {
       "status": "CREATE_COMPLETE"
    }
   ```

### Upload Your Content to your Provisioned Coyote Instance
This example must be built before you can deploy it to your provisioned Coyote instance.

1. Run `yarn xln:coyote:upload-instance-content` to upload the built content to your provisioned Coyote instance.

### List Your Coyote Instance Content

1. Run `yarn xln:list-instance-content` to view the content published to your Coyote instance.
Note: the instance needs to be provisioned before your content is publicly available.

### Access Your Content Hosted on Coyote


1. Run `cat .env | grep XILUTION_INSTANCE_ID` to see your Coyote Instance ID.
1. Open `https://{instance-id}.prod.coyote.content-delivery.xilution` in a browser.

### Deprovision the Coyote Instance

1. Run `yarn xln:coyote:deprovision-instance`, to deprovision the Coyote instance.
1. Run `yarn xln:coyote:show-instance-status`, to see the status of your Coyote instance.
It can take up to 2 minutes to fully deprovision your Fox instance.
Deprovisioning is complete when you see the following.
    ```json
    {
       "status": "NOT_FOUND"
    }
   ```

### Delete the Coyote Instance

1. Run `yarn xln:coyote:delete-instance {instance-id}`, to delete the Coyote instance.

---
Copyright 2019 Teapot, LLC.  
Xilution is a DBA of Teapot, LLC.
