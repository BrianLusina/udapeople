# UdaPeople

HR Product

## Getting Started

Instructions for how to get a copy of the project running on your local machine.

### Dependencies

* Git SCM
* SSH client like OpenSSH
* NodeJs v10 or higher (if you plan on compiling locally)
* AWS CLI & AWS ccount
* CircleCI Account (or similar CI server if CircleCI is not for you, in that case, you will have to modify & adapt the config to suit your needs)
* Docker & Docker compose 

### Compiling/Running Locally

The instructions and information that follows should help you build, test and deploy the web application either locally or in CI/CD.

This is a "mono-repository" which means multiple servers or layers exist in the same repository. You'll find the following main folders:

- [`frontend`](./frontend)
- [`backend`](./backend)

#### 1. Install dependencies in both `frontend` and `backend` folders.

From your root folder, use the commands:
```bash
cd frontend
npm i
cd ..
cd backend
npm i
```
> will install dependendencies for both frontend & backend. Note that yarn can be used as well.

#### 2. Create `.env` file for database connection info.

Add a `.env` file to your `backend` folder with the following contents:

```bash
NODE_ENV=local
VERSION=1
TYPEORM_CONNECTION=postgres
TYPEORM_MIGRATIONS_DIR=./src/migrations
TYPEORM_ENTITIES=./src/modules/domain/**/*.entity.ts
TYPEORM_MIGRATIONS=./src/migrations/*.ts

# Things you can change if you wish...
TYPEORM_HOST=localhost
TYPEORM_PORT=5532
TYPEORM_USERNAME=postgres
TYPEORM_PASSWORD=password
TYPEORM_DATABASE=glee
```
> This can also be achieved by running the command cp .env.sample > .env if on a UNIX system

You can use your own Postgres server if you wish or you can use the Docker-Compose template provided in the directory root.

## Running PostgreSQL in Docker-Compose

For convenience, there is a provided template that you can use to easily run a Postgres database for local testing. To run this template, you'll need to install Docker and Docker-Compose.

To start the database, you will use the following commands from your root folder:

```bash
docker-compose up
```

## Compiling the Code

You can compile the code from your root folder using the following:

```bash
cd frontend
npm run build
```

```bash
cd backend
npm run build
```

## Testing, Migrating, Running

Most of the tasks needed to build, test and deploy the application are simplified by "npm scripts" that are found in the `package.json` for either front-end or back-end. For any of these scripts, you will need to `cd` into the respective folder and then run the script using the command `npm run [script name]`. Here are the most relevant scripts:

| Name | Purpose | Notes | 
| :-- | :-- | :-- |
| migrations | Run migration which checks for any migration scripts that have not yet been applied to the db and runs them. |Make sure you have a Postgres database running and your `.env` file is configured correctly. If you get connection errors from the backend when you start it, then chances are your DB is not running or the `.env` doesn't have the correct DB connection information. |
| migrations:revert | Revert last successfully executed migration. | The same connection configuration is needed here as with the `migrations` script above. |
| test | Run all unit tests. | |
| build | Compiles the code. | Drops the compiled code in the `./dist` folder. |
| start | Starts up the application locally. | Make sure you have a Postgres database running and your `.env` file is configured correctly. If you get connection errors from the backend when you start it, then chances are your DB is not running or the `.env` doesn't have the correct DB connection information.|

### Examples:

This should compile the code and then list the result in the `./dist` folder:

```bash
cd frontend
npm run build
cd dist
ls
```

... or revert the last migration that ran:

```bash
cd backend
npm run migrations:revert
```

## Cloud Formation Templates

[CloudFormation](https://aws.amazon.com/cloudformation/) templates can be found [here](./infra). These aid in setting up infrastructure for your running application. Ensure you have the right set of permissions for AWS CLI to use when automating this process. Preferrably, have a configured machine user or a bot that has administrative access to your AWS account. DO NOT share or commit these credentials to a VCS.

Each cloud formation configuration is under a relevant folder.

## CircleCI config

There is a `config.yml` available [here](./circleci/config.yml) to help with configuring CircleCI to fit your needs.

### Built With

- [Circle CI](www.circleci.com) - Cloud-based CI/CD service
- [Amazon AWS](https://aws.amazon.com/) - Cloud services
- [AWS CLI](https://aws.amazon.com/cli/) - Command-line tool for AWS
- [CloudFormation](https://aws.amazon.com/cloudformation/) - Infrastrcuture as code
- [Ansible](https://www.ansible.com/) - Configuration management tool
- [Prometheus](https://prometheus.io/) - Monitoring tool

### License

[License](LICENSE.md)
