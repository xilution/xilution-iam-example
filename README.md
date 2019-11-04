<h1>xilution-web-frontend-example</h1>
<p>
An example demonstrating how to build a web app using...
<p>
<ul>
    <li>
        Xilution's IAM Suite (<a href="https://products.xilution.com/api/catalog/basics/elephant">Elephant</a>, <a href="https://products.xilution.com/api/catalog/basics/hippo">Hippo</a>, <a href="https://products.xilution.com/api/catalog/basics/rhino">Rhino</a>, <a href="https://products.xilution.com/api/catalog/basics/zebra">Zebra</a>)
    </li>
    <li>
        Xilution's Static Content Hosting Service (<a href="https://products.xilution.com/api/catalog/content-delivery/coyote">Fox</a>)
    </li>
</ul>
<p>
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
<p>
  <a href="https://travis-ci.org/xilution/xilution-web-frontend-example">
    <img alt="Travis" src="https://img.shields.io/travis/xilution/xilution-web-frontend-example.svg">
  </a>
</p>
<p>
  <a href="https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fxilution%2Fxilution-web-frontend-example">
    <img alt="Tweet" src="https://img.shields.io/twitter/url/https/github.com/xilution/xilution-web-frontend-example.svg?style=social">
  </a>
</p>

## Time Requirement

I will take about thirty (30) minutes to run through this example.

## Use Case

**As:** a frontend app builder who creates apps for multiple clients.

**I want:** a web app that restricts access to only known users.

**So that:** I can build a pet data management web app for one of my clients.

## Xilution Product Hierarchy

Here's a quick overview of the Xilution products highlighted in this example.
For a complete directory of Xilution products, see https://prod.products.xilution.com/.

```text
                 +------------------+
                 | Xilution Account |
                 +--------+---------+
                          |
                          v
                   +------+-------+
                   | Organization +--------------+
                   +------+-------+              |
                          |                      |
                          v                      |
               +----------+----------+           |
               |    [ Elephant ]     |           |
               | Sub-Organization(s) |           |
               +----------+----------+           |
                          |                      |
                          v                      |
          +--------------------------------+     |
          |               |                |     |
          v               v                v     v
    +-----+-----+   +-----+-----+      +---+-----+---+
    | [ Hippo ] |   | [ Rhino ] |      | [ Coyote ]  |
    | Client(s) |   |  User(s)  |      | Instance(s) |
    +-----------+   +-----------+      +-------------+
```

* [Elephant](https://products.xilution.com/api/catalog/basics/elephant)
* [Hippo](https://products.xilution.com/api/catalog/basics/hippo)
* [Rhino](https://products.xilution.com/api/catalog/basics/rhino)
* [Coyote](https://products.xilution.com/api/catalog/content-delivery/coyote)

When you create a Xilution Account, an Organization record is created for you.
This is referred to as your "Account Organization" in the instructions below.
As a frontend app builder who supports multiple clients, you can create multiple Sub-Organizations via Xilution Elephant.
One for each client you support.
This allows you to separate client resource management and billing from your Account Organization and other Sub-Organizations.

Xilution Hippo is part of Xilution's IAM suite and manages Sub-Organization clients.
A client is a reference to a web or mobile application.
In this example, you'll create one Sub-Organization client.

Xilution Rhino is part of Xilution's IAM suite and manages Sub-Organization users.
In this example, you'll create one Sub-Organization user.

Xilution Coyote is a static content hosting service.
You can associate Coyote instances with your Account Organization and/or Sub-Organizations.
In this example, you'll associated a Coyote instance with a Sub-Organization.

## Implemented Solution

When you complete this example, you will create a single page web app that integrates with the API created in [xilution-graphql-backend-example](https://github.com/xilution/xilution-graphql-backend-example).

```text
                           +-------------------+
                     +---->+     [ Hippo ]     |
                     |     | Client Management |
    +--------+       |     +-------------------+
    |  IAM   +-------+
    | Client +-------+
    +-+----+-+       |      +-----------+
      ^    |         +----->+ [ Zebra ] |
      |    |                |   Auth    |
      |    |                +--+-----+--+
      |    |                   ^     ^
      |    |                   |     |
      |    v                   |     |
    +-+----+-+                 |     |
    |  Web   +-----------------+  +--+--+
    | Client +------------------->+ API |
    +---+----+                    +-----+
        ^
        |
        |                +------------------------+
        +----------------+       [ Coyote ]       |
                         | Static Content Hosting |
                         +------------------------+
```

* [Hippo](https://products.xilution.com/api/catalog/basics/hippo)
* [Zebra](https://products.xilution.com/api/catalog/basics/zebra)
* [Coyote](https://products.xilution.com/api/catalog/content-delivery/coyote)

The Web Client forwards unauthenticated requests to the Xilution IAM Client.
The Xilution IAM Client is part of the Xilution IAM Suite and provides turn-key user authentication, registration and password management services.
The Xilution IAM Client works with [@xilution/xilution-iam-react](https://github.com/xilution/xilution-iam-react) to execute an [Oauth 2.0 Authorization Code](https://oauth.net/2/grant-types/authorization-code/) authentication flow.
The Xilution IAM Client interfaces with Xilution Hippo to retrieve some display information about the Web Client and interfaces with Xilution Zebra to authenticate a user.
Zebra is part of Xilution's IAM suite and is used to authenticate and authorize Rhino users and Hippo clients.
Once authenticated, the IAM Client forwards back to the Web Client with an authorization code which is used by [@xilution/xilution-iam-react](https://github.com/xilution/xilution-iam-react) to retrieve an access token from Zebra.

The Web Client is a [Single Page Application](https://en.wikipedia.org/wiki/Single-page_application).
The site consists of a one HTML file, one JavaScript file and one `favicon.ico` file.
This "static content" is used to render the web app in an end user's browser and is built from the source code and dependencies found in this repo.
Xilution Coyote makes the Web Client's static content available on the public web.

## Features

* Xilution's IAM Suite ([Elephant](https://products.xilution.com/api/catalog/basics/elephant), [Hippo](https://products.xilution.com/api/catalog/basics/hippo), [Rhino](https://products.xilution.com/api/catalog/basics/rhino) and [Zebra](https://products.xilution.com/api/catalog/basics/zebra)) for identity and access management.
* Xilution [Coyote](https://products.xilution.com/api/catalog/integration/coyote) for static content hosting.
* Xilution IAM Client provides turn key user authentication and registration services.
* [React](https://reactjs.org/) single page web application.
    * [react-admin](https://github.com/marmelab/react-admin) React component to manage Pet data.
    * [@xilution/xilution-iam-react](https://github.com/xilution/xilution-iam-react) React component which interacts with the Xilution IAM Client to restricts Pet data access to only known users.

## Prerequisites

1. Create a Xilution Account
    1. Open [https://prod.register.xilution.com](https://prod.register.xilution.com) to create a Xilution **Prod** account.
        * :mega: A valid credit card :credit_card: must be associated with your Xilution Account to use Xilution Products in Prod.
          Use the [Prod environment Xilution Admin Portal](https://prod.portal.xilution.com) to add a Credit Card to your Xilution Account.
    1. Open [https://test.register.xilution.com](https://test.register.xilution.com) to create a Xilution **Test** account.
        * Xilution Test and Prod accounts are not synchronized.
        * Some Xilution products have usage and time to live restrictions in our Test environment.
          See [product documentation](https://test.products.xilution.com/) for complete restriction details.
1. Run through https://github.com/xilution/xilution-graphql-backend-example to create a GraphQL enabled API.
1. Install OpenSSL: https://www.openssl.org/

## General

### To Install Dependencies

1. Run `yarn install` to download dependencies.

### To Verify The Source Code

1. Run `yarn verify`.

## Set Up

The following instructions are enabled via a large suite of scripts found in the [scripts](./scripts) folder of this repo.
You can see the changes made to your account via the scripts through our product portals.
You'll authenticate to the portals with your Xilution Account username and password.

| Portal   | Prod                                                      | Test                                                      |
|----------|-----------------------------------------------------------|-----------------------------------------------------------|
| Account  | https://prod.portal.xilution.com/                         | https://test.portal.xilution.com/                         |
| Elephant | https://prod.portal.elephant.basics.xilution.com/         | https://test.portal.elephant.basics.xilution.com/         |
| Rhino    | https://prod.portal.rhino.basics.xilution.com/            | https://test.portal.rhino.basics.xilution.com/            |
| Hippo    | https://prod.portal.hippo.basics.xilution.com/            | https://test.portal.hippo.basics.xilution.com/            |
| Coyote   | https://prod.portal.coyote.content-delivery.xilution.com/ | https://test.portal.coyote.content-delivery.xilution.com/ |
| Fox      | https://prod.portal.fox.integration.xilution.com/         | https://test.portal.fox.integration.xilution.com/         |

### API

This example integrates with the API created in https://github.com/xilution/xilution-graphql-backend-example.
We recommend running through it before moving on with the rest of this example.

### Environment Variables

1. Run `touch .env` to create a new environment variables file.
1. Run `echo "XILUTION_ENVIRONMENT={environment}" >>.env` to add your environment preference to the environment variables file (.env).
    * {environment} is a Xilution environment. One of 'test' or 'prod'. Should be the same environment you used in [xilution-graphql-backend-example](https://github.com/xilution/xilution-graphql-backend-example). 
1. Run `echo "XILUTION_SUB_ORGANIZATION_ID={sub-organization-id}" >>.env`.
    * {sub-organization-id} is found in the `.env` file created when you ran through [xilution-graphql-backend-example](https://github.com/xilution/xilution-graphql-backend-example). 

### Account Organization Authentication

1. Run `yarn xln:authentication:token-from-user-credentials`.
    * You will be prompted for your Xilution Account username and password.
    * The access token saved to the environment variables file will expire in one hour.

### Account Organization Product Activation

Note: Requires Account Organization Authentication

1. Run `yarn xln:elephant:activate-for-account-organization`.
1. Run `yarn xln:hippo:activate-for-account-organization`.
1. Run `yarn xln:rhino:activate-for-account-organization`.
1. Run `yarn xln:coyote:activate-for-account-organization`.

* Run `yarn xln:{product-name}:show-activation-for-account-organization` to see the status of an account organization's product activation.
    * {product-name} is one of `elephant`, `hippo` or `rhino`.
* Run `yarn xln:{product-name}:deactivate-for-account-organization` to deactivate a product for an account organization.

### Sub-Organization Product Activation

Note: Requires Account Organization Authentication

1. Run `yarn xln:hippo:activate-for-sub-organization`.
1. Run `yarn xln:zebra:activate-for-sub-organization`.

* Run `yarn xln:{product-name}:show-activation-for-sub-organization` to see the status of a Sub-Organization's product activation.
    * {product-name} is one of `hippo`, `zebra` or `coyote`.
* Run `yarn xln:{product-name}:deactivate-for-sub-organization` to deactivate a product for a Sub-Organization.

### Add an IAM User to Sub-Organization

Note: Requires Account Organization Authentication

1. Run `yarn xln:rhino:sign-up-iam-user {email} {username}`.
    * {email} is the new user's email address. Enter an email address that you have access to.
    * {username} is the new user's username.
    * A verification code will be emailed to the email address you entered when signing up the new user.
1. Run `yarn xln:rhino:verify-user-email {username} {code}` to verify the new user's email.
    * {username} is the new user's username.
    * {code} is the verification code the you received in your email inbox.

* To see the Sub-Organization's users run, `yarn xln:rhino:show-users`.
* To delete a Sub-Organization's user run, `yarn xln:rhino:delete-user {user-id}`.

### Add Clients to the Sub-Organization

Note: Requires Account Organization Authentication

1. Run `yarn xln:hippo:create-iam-client`.
1. Run `yarn xln:hippo:create-web-client`.

* To see the Sub-Organization's clients run, `yarn xln:hippo:show-clients`.
* To delete a Sub-Organization's client run, `yarn xln:hippo:delete-client {client-id}`.

### Update the Sub-Organization's IAM Client ID

1. Run `yarn xln:elephant:update-iam-client-id`.

## Running Locally

### Connect to a Locally Hosted API

1. Run `echo API_BASE_URL=http://localhost:3123`.
1. Run `export $(grep -v '^#' .env | xargs)` to export the environment variables saved to the environment variables file into your current terminal session.
1. Run `yarn start-connected-to-locally-hosted-api`.
    * An instance of [xilution-graphql-backend-example](https://github.com/xilution/xilution-graphql-backend-example) must be running locally to start the app connected to a locally hosted API.
1. Open http://localhost:3124 in a browser to view the running web application.
    * When you first access the app, you will be redirected to Xilution's IAM client where you can sign up a new user for your application. Once the new user is created, the IAM client will redirect you to a Sign In page.
1. `Ctrl-c` to stop.

### Connect to a Fox Hosted API

An instance of [xilution-graphql-backend-example](https://github.com/xilution/xilution-graphql-backend-example) must be running on [Fox](https://products.xilution.com/api/catalog/integration/fox) to start the app connected to a Fox hosted API.

1. Run `echo API_BASE_URL=https://{fox-instance-id}.{environment}.fox.integration.xilution.com >>.env`.
    * {fox-instance-id} is the ID of the Fox instance you created in [xilution-graphql-backend-example](https://github.com/xilution/xilution-graphql-backend-example).
1. Run `export $(grep -v '^#' .env | xargs)` to export the environment variables saved to the environment variables file into your current terminal session.
1. Run `yarn start-connected-to-locally-hosted-api` or `yarn start-connected-to-fox-hosted-api`.
1. Open http://localhost:3124 in a browser to view the running web application.
    * When you first access the app, you will be redirected to Xilution's IAM client where you can sign up a new user for your application. Once the new user is created, the IAM client will redirect you to a Sign In page.
1. `Ctrl-c` to stop.

## Host on Xilution Coyote

The following instructions describe how to host this example on Xilution Coyote.
An instance of [xilution-graphql-backend-example](https://github.com/xilution/xilution-graphql-backend-example) must be running on [Fox](https://products.xilution.com/api/catalog/integration/fox) to start the app connected to a Fox hosted API.

### Create a Coyote Instance

Note: Requires Account Organization Authentication

A Coyote Instance contains data that instructs Coyote on how to host your content.

1. Run `yarn xln:coyote:create-instance`.

* To see your instances, run `yarn xln:coyote:show-instances`.
* To delete a instance, run `yarn xln:coyote:delete-instance {coyote-instance-id}`

### Provision the Coyote Instance

Note: Requires Account Organization Authentication

Provisioning a Coyote Instance makes your content available on the public internet.

1. Run `yarn xln:coyote:provision-instance`, to provision the Coyote instance.
1. Run `yarn xln:coyote:show-instance-status`, to see the status of your Coyote instance.
    * It can take up to 2 minutes to fully provision your Fox instance.
    * Provisioning is complete when you see the following.
        ```json
        {
           "status": "CREATE_COMPLETE"
        }
       ```

### Upload Your Content to your Provisioned Coyote Instance

Note: Requires Account Organization Authentication

This example must be built before you can deploy it to your provisioned Coyote instance.

1. Run `echo API_BASE_URL=https://{fox-instance-id}.{environment}.fox.integration.xilution.com >>.env`.
    * {fox-instance-id} is the ID of the Fox instance you created in [xilution-graphql-backend-example](https://github.com/xilution/xilution-graphql-backend-example).
1. Run `yarn build` to build the example.
1. Run `yarn xln:coyote:upload-instance-content` to upload the built content to your provisioned Coyote instance.

### List Your Coyote Instance Content

Note: Requires Account Organization Authentication

The instance must be provisioned before your content is publicly available.

1. Run `yarn xln:coyote:list-instance-content` to view the content published to your Coyote instance.

### Access Your Content Hosted on Coyote

Note: Requires Account Organization Authentication

1. Run `cat .env | grep XILUTION_COYOTE_INSTANCE_ID` to see your Coyote Instance ID.
1. Open https://{coyote-instance-id}.prod.coyote.content-delivery.xilution in a browser.

### Deprovision the Coyote Instance

Note: Requires Account Organization Authentication

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

Note: Requires Account Organization Authentication

1. Run `yarn xln:coyote:delete-instance {coyote-instance-id}`, to delete the Coyote instance.

---
Copyright 2019 Teapot, LLC.  
Xilution is a DBA of Teapot, LLC.
