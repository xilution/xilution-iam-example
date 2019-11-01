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

```text
             +------------------+
             | Xilution Account |
             +--------+---------+
                      |
                      v
               +------+-------+
               | Organization |
               +------+-------+
                      |
                      v
           +----------+----------+
           |    [ Elephant ]     |
           | Sub Organization(s) |
           +----------+----------+
                      |
                      v
      +--------------------------------+
      |               |                |
      v               v                v
+-----+-----+   +-----+-----+   +------+-------+
| [ Hippo ] |   | [ Rhino ] |   |  [ Coyote ]  |
| Client(s) |   |  User(s)  |   | Instances(s) |
+-----------+   +-----------+   +--------------+
```

TODO - explain this graph

* Xilution [Elephant](https://products.xilution.com/basics/elephant) is part of Xilution's IAM suite and is used to manage sub-organizations.
* Xilution [Hippo](https://products.xilution.com/basics/hippo) is part of Xilution's IAM suite and is used to manage sub-organization clients.
* Xilution [Rhino](https://products.xilution.com/basics/rhino) is part of Xilution's IAM suite and is used to manage sub-organization users.
* Xilution [Coyote](https://products.xilution.com/content-delivery/coyote) is a static content hosting service.

```text
                       +-------------+
                 +---->+  [ Hippo ]  |
                 |     | Client Mgmt |
+--------+       |     +-------------+
|  IAM   +-------+
| Client +-------+
+-+----+-+       |      +-----------+
  ^    |         +----->+ [ Zebra ] |
  |    |                |   Auth    |
  |    |                +-----+-----+
  |    |                      ^
  |    |                      |
  |    v                      |
+-+----+-+                 +--+--+
|  Web   +---------------->+ API |
| Client |                 +-----+
+---+----+
    ^
    |
    |                +------------------------+
    +----------------+       [ Coyote ]       |
                     | Static Content Hosting |
                     +------------------------+
```

TODO - explain this graph

* Xilution [Zebra](https://products.xilution.com/basics/zebrah) is part of Xilution's IAM suite and is used to authenticate and authorize Rhino users and Hippo clients.

## Features

TODO - add features

## Prerequisites

1. Run through https://github.com/xilution/xilution-graphql-backend-example to create a GraphQL enabled API.

## General

### To Install Dependencies

1. Run `yarn install` to download dependencies.

### To Verify The Source Code

1. Run `yarn verify`.

## Set Up

### API

This example integrates with the API created in https://github.com/xilution/xilution-graphql-backend-example.
We recommend running through it before moving on with the rest of this example.

### Environment Variables

1. Run `touch .env` to create a new environment variables file.
1. Run `echo "XILUTION_ENVIRONMENT={environment}" >> .env` to add your environment preference to the environment an variables file (.env).
    * {environment} is a Xilution environment. One of 'test' or 'prod'. Should be the same environment you used in `xilution-graphql-backend-example`. 
1. Run `echo "XILUTION_SUB_ORGANIZATION_ID={sub-organization-id}" >> .env`.
    * {sub-organization-id} is found in the `.env` file created when you ran through `xilution-graphql-backend-example`. 

### Account Organization Authentication

1. Run `yarn xln:authentication:token-from-user-credentials`.
    * You will be prompted for your Xilution account username and password.
    * The access token saved to the environment variables file will expire in one hour.

### Account Organization Product Activation

Note: Requires Account Organization Authentication

1. Run `yarn xln:elephant:activate-for-account-organization`.
1. Run `yarn xln:hippo:activate-for-account-organization`.
1. Run `yarn xln:rhino:activate-for-account-organization`.

* Run `yarn xln:{product-name}:show-activation-for-account-organization` to see the status of an account organization's product activation.
    * {product-name} is one of `elephant`, `hippo` or `rhino`.
* Run `yarn xln:{product-name}:deactivate-for-account-organization` to deactivate a product for an account organization.

### Sub-Organization Product Activation

Note: Requires Account Organization Authentication

1. Run `yarn xln:hippo:activate-for-sub-organization`.
1. Run `yarn xln:zebra:activate-for-sub-organization`.
1. Run `yarn xln:coyote:activate-for-sub-organization`.

* Run `yarn xln:{product-name}:show-activation-for-sub-organization` to see the status of a sub-organization's product activation.
    * {product-name} is one of `hippo`, `zebra` or `coyote`.
* Run `yarn xln:{product-name}:deactivate-for-sub-organization` to deactivate a product for a sub-organization.

### Add an IAM User to Sub-Organization

Note: Requires Account Organization Authentication

1. Run `yarn xln:rhino:sign-up-iam-user {email} {username}`.
    * {email} is the new user's email address. Enter an email address that you have access to.
    * {username} is the new user's username.
    * A verification code will be emailed to the email address you entered when signing up the new user.
1. Run `yarn xln:rhino:verify-user-email {username} {code}` to verify the new user's email.
    * {username} is the new user's username.
    * {code} is the verification code the you received in your email inbox.

* To see the sub-organization's users run, `yarn xln:rhino:show-users`.
* To delete a sub-organization's user run, `yarn xln:rhino:delete-user {user-id}`.

TODO - make a note about needing a credit card in Prod.

### Add Clients to the Sub-Organization

Note: Requires Account Organization Authentication

1. Run `yarn xln:hippo:create-iam-client`.
1. Run `yarn xln:hippo:create-web-client`.

* To see the sub-organization's clients run, `yarn xln:hippo:show-clients`.
* To delete a sub-organization's client run, `yarn xln:hippo:delete-client {client-id}`.

### Update the Sub-Organization's IAM Client ID

1. Run `yarn xln:elephant:update-iam-client-id`.

## Running Locally

1. Run `export $(grep -v '^#' .env | xargs)` to export the environment variables saved to the environment variables file into your current terminal session.
1. Run `yarn start-connected-to-locally-hosted-api` or `yarn start-connected-to-fox-hosted-api`.

    1. Open `http://localhost:3124` to view the running web application.
    1. `Ctrl-c` to stop.

TODO - Describe how to register a new user through the IAM client.
TODO - need to explain how to log out of the web client and IAM client.
TODO - https://{sub-organization-id}.{environment}.iam.xilution.com

## Docker

### To build the Docker image

This tags your docker image as `xilution-web-frontend-example`.

1. Run `yarn docker:build`.

### To run the Docker image locally

1. Run `yarn docker:start`.

    * Open `http://localhost:3124` to view the running web application.

### To stop the Docker image

1. Run `yarn docker:stop`.

### To publish the Docker image to Docker Hub

You'll need a [Docker Hub](https://hub.docker.com/) account to execute the following.

1. Run `yarn docker:publish` to push the image to your Docker Hub account.

## Xilution Coyote

The following instructions describe how to host this example on Xilution Coyote

### Create a Coyote Instance

A Coyote Instance contains data that instructs Coyote on how to host your content.

1. Run `yarn xln:coyote:create-instance`.

* To see your instances, run `yarn xln:coyote:show-instances`.
* To delete a instance, run `yarn xln:coyote:delete-instance {instance-id}`

### Provision the Coyote Instance

Provisioning a Coyote Instance makes your content available on the public internet.

1. Run `yarn xln:provision-coyote-instance`, to provision the Coyote instance.
1. Run `yarn xln:show-coyote-instance-status`, to see the status of your Coyote instance.
    * It can take up to 2 minutes to fully provision your Fox instance.
    * Provisioning is complete when you see the following.
        ```json
        {
           "status": "CREATE_COMPLETE"
        }
       ```

### Upload Your Content to your Provisioned Coyote Instance

This example must be built before you can deploy it to your provisioned Coyote instance.

1. Run `yarn build` to build the example.
1. Run `yarn xln:coyote:upload-instance-content` to upload the built content to your provisioned Coyote instance.

### List Your Coyote Instance Content

the instance needs to be provisioned before your content is publicly available.

1. Run `yarn xln:list-instance-content` to view the content published to your Coyote instance.

### Access Your Content Hosted on Coyote

1. Run `cat .env | grep XILUTION_INSTANCE_ID` to see your Coyote Instance ID.
1. Open `https://{instance-id}.prod.coyote.content-delivery.xilution` in a browser.

### Deprovision the Coyote Instance

Deprovisioning a Coyote Instance deletes the instance's content and takes it offline.

1. Run `yarn xln:coyote:deprovision-instance`, to deprovision the Coyote instance.
1. Run `yarn xln:coyote:show-instance-status`, to see the status of your Coyote instance.
    * It can take up to 2 minutes to fully deprovision your Fox instance.
    * Deprovisioning is complete when you see the following.
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
