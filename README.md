# Script for deploy your static site to S3 and refresh CloudFront Distribution

It is a script that allows you to upload / deploy a static website deploy with a command. For this you need to have the Amazon CLI tool installed. You have to get it on your local machine, in package.json you put the profile name, and the target Backit. What it does is to upload the content and update cache in CloudFront.

## Instalation

***Dependences: Is nedded to do:***
* ***Mac***: `brew install jq`
* ***Linux***: `apt i jq` or `yaml install jq`

Also needs:
* ***AWS Cli*** See this documentatio: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
* ***Profile*** See this documentation: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

```shell
chmod +x ./deploy.sh
```

### Usage

```shell
./deploy.sh <profile_name> <domain_name> <folder_to_upload> <region>
```

In your `package.json` file

```json
...
"scripts": {
    "deploy-dev": "scripts/deploy.sh profile-name domain ./dist",
    ...
}
```

```shell
npm run deploy-dev
```