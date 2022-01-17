# S3 Upload & CloudFront Invalidation of last Distribution

If you have your static websites allocated on S3 Buscket / CloadFront, and needs autoupload / replace files on your bucket?
This script is for add on your NPM project for upload files deleting all oldest and creating distribution invalidation for create new cache.

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