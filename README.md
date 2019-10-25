# xilution-iam-example

## Prerequisites

1. Install Docker Desktop: https://www.docker.com/products/docker-desktop
1. Install NVM: https://github.com/nvm-sh/nvm
1. Install Yarn: https://yarnpkg.com

The following are required if you want to follow the "Xilution Coyote" instructions below.

1. Create Xilution Account(s)
    1. Open [https://prod.regiser.xilution.com](https://prod.regiser.xilution.com) to create a Prod Xilution account.
    1. Open [https://test.regiser.xilution.com](https://test.regiser.xilution.com) to create a Test Xilution account.
    * Note: Xilution Test and Prod accounts are not synchronized.
1. Install the Xilution CLI: https://docs.xilution.com/cli/
1. Install jq: https://stedolan.github.io/jq/

## General

### To download this repo

1. Run `git clone @xilution/xilution-iam-example`, to download this repo.

### To download repo dependencies

1. Run `yarn install` to download dependencies.

### To verify the source code

1. Run `yarn verify`.

### To run the server and make live updates

1. Run `yarn start`.
    1. Open `http://localhost:3000` to view the running web application.
    1. `Ctrl-c` to stop.

## Docker

### To build the Docker image
This tags your docker image as `xilution-iam-example`.

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

1. Run `yarn xln:show-activation` to see the status of your Coyote activation.

    1. If the Coyote activation does not exist or is inactive, run `yarn xln:activate` to activate Xilution Coyote.
    2. Conversely, you can run `yarn xln:deactivate` to deactivate Xilution Coyote.

### Create a Coyote Instance
A Coyote Instance contains data that instructs Coyote on how to host your content.
You provision a Coyote Instance to make your content available.
Likewise, you deprovision a Coyote Instance to take your content offline.

1. Run `yarn xln:show-instances` to see your Coyote instances.
    1. If you don't have a `xilution-iam-example` Coyote instance, run `yarn xln:create-instance` to create a new Coyote instance.
    Take note of the `id` of the new instance.
    You'll need it in the next step to provision the instance.

### Provision the Coyote Instance

1. Run `yarn xln:provision-instance`, to provision the Coyote instance.
1. Run `yarn xln:show-instance-status`, to see the status of your Coyote instance.
It can take up to 2 minutes to fully provision your Coyote instance.
Provisioning is complete when you see the following.
    ```json
    {
       "status": "CREATE_COMPLETE"
    }
   ```

### Upload Your Content to your Provisioned Coyote Instance
This example must be built before you can deploy it to your provisioned Coyote instance.

1. Run `yarn xln:upload-instance-content` to upload the built content to your provisioned Coyote instance.

### List Your Coyote Instance Content

1. Run `yarn xln:list-instance-content` to view the content published to your Coyote instance.
Note: the instance needs to be provisioned before your content is publicly available.

### Access Your Content Hosted on Coyote

1. Open `https://{your-instance-id}.prod.coyote.content-delivery.xilution` in a browser.

### Deprovision the Coyote Instance

1. Run `yarn xln:deprovision-instance`, to deprovision the Coyote instance.
1. Run `yarn xln:show-instance-status`, to see the status of your Coyote instance.
It can take up to 2 minutes to fully deprovision your Coyote instance.
Deprovisioning is complete when you see the following.
    ```json
    {
       "status": "NOT_FOUND"
    }
   ```

### Delete the Coyote Instance

1. Run `yarn xln:delete-instance`, to delete the Coyote instance.

---
Copyright 2019 Teapot, LLC.  
Xilution is a DBA of Teapot, LLC.
