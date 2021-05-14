# Registration Desk

This repository contains the source code for the app to be used at the registration desk of the [Kirpal Sagar Charitable Hospital](https://kirpal-sagar.org/en/kirpal-charitable-hospital-en/).

![KSCH Registration Desk](doc/img/registration-desk.png)

## Context

The Registration Desk is used by nurses and clerks.
The tasks they need to do there are around the patient registration and billing.

![Context diagram](doc/img/context.png)

The app depends upon the [Backend](https://github.com/ksch-workflows/backend) for the reading and writing of its data.
For this purpose, it is accessing the [REST API](https://www.redhat.com/en/topics/api/what-is-a-rest-api) of the backend.

## Architecture

The following section gives an overview of the code in this repository.
For the big picture view, please refer to the [K.S.C.H. Workflows architecture documentation](https://ksch-workflows.github.io/arc42/).

### Technology

The Registration Desk app is a single-page web application, powered by [Flutter Web](https://flutter.dev/web).

### Code structure

TBD

## Development

For local development the Registration Desk app can be started like this:

```
flutter run -d chrome
```

## Deployment

### Testing

For demos and quality assurance, the Registration Desk app is deployed on GitHub Pages:

https://ksch-workflows.github.io/registration-desk

This gets automatically updated with every change on the repository with the help of [GitHub Actions](https://dev.to/janux_de/automatically-publish-a-flutter-web-app-on-github-pages-3m1f).

### Production

There is no production deployment, yet.
It is planned that the Registration Desk web app is packaged together with a web server in a [Docker image](https://searchitoperations.techtarget.com/definition/Docker-image) so that it can be started with [Docker Compose](https://docs.docker.com/compose/).

## License

K.S.C.H. Workflows is maintained by [KS-plus e.V.](https://ks-plus.org/en/welcome/),
a non-profit association dedicated to supporting the [Kirpal Sagar](https://kirpal-sagar.org/en/welcome/) project.

It is licensed under the [Apache License Version 2.0](https://github.com/ksch-workflows/ksch-workflows/blob/master/LICENSE).
