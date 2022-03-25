# Hadolint Action

> GitHub Action that runs [Hadolint](https://github.com/hadolint/hadolint) Dockerfile linting tool.

[![GitHub Action](https://img.shields.io/badge/GitHub-Action-blue?style=for-the-badge)](https://github.com/features/actions)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg?style=for-the-badge)](http://commitizen.github.io/cz-cli/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg?style=for-the-badge)](https://github.com/semantic-release/semantic-release?style=for-the-badge)

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/hadolint/hadolint-action/CI?style=for-the-badge)](https://github.com/hadolint/hadolint-action/action)

## Usage

Add the following step to your workflow configuration:

```yml
steps:
  - uses: actions/checkout@v2 
  - uses: hadolint/hadolint-action@v1.6.0
    with:
      dockerfile: Dockerfile
```

## Inputs

| Name               | Description                               | Default          |
|------------------- |------------------------------------------ |----------------- |
| dockerfile         | The path to the Dockerfile to be tested   | ./Dockerfile     |
| recursive          | Search for specified dockerfile           | false            |
|                    | recursively, from the project root        |                  |
| config             | Custom path to a Hadolint config file     | ./.hadolint.yaml |
| output-file        | A sub-path where to save the              |                  |
|                    | output as a file to                       |                  |
| no-color           | Don't create colored output               |                  |
| no-fail            | Never fail the action                     |                  |
| verbose            | Output more information                   |                  |
| format             | The output format. One of [tty \| json \| | tty              |
|                    | checkstyle \| codeclimate \|              |                  |
|                    | gitlab_codeclimate \| codacy \| sarif]    |                  |
| failure-threshold  | Rule severity threshold for pipeline      | info             |
|                    | failure. One of [error \| warning \|      |                  |
|                    | info \| style \| ignore]                  |                  |
| override-error     | List of rules to treat with 'error'       |                  |
|                    | severity                                  |                  |
| override-warning   | List of rules to treat with 'warning'     |                  |
|                    | severity                                  |                  |
| override-info      | List of rules to treat with 'info'        |                  |
|                    | severity                                  |                  |
| override-style     | List of rules to treat with 'style'       |                  |
|                    | severity                                  |                  |
| ignore             | Comma-separated list of Hadolint rules to | <none>           |
|                    | ignore.                                   |                  |
| trusted-registries | List of urls of trusted registries        |                  |

## Hadolint Configuration

To configure Hadolint (for example ignore rules), you can create an `.hadolint.yaml` file in the root of your repository. Please check the Hadolint [documentation](https://github.com/hadolint/hadolint#configure).

## 🤝 Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 💛 Support the project

If this project was useful to you in some form, We would be glad to have your support. It will help keeping the project alive.

The sinplest form of support is to give a ⭐️ to this repo.

This project was originally created by [Bruno Paz](https://github.com/sponsors/brpaz) and incorporated into the Hadolint organization. If you appreciate the work done on this action, Bruno would be happy with your [sponsorship](https://github.com/sponsors/brpaz).

## Author

👤 **Bruno Paz**

* Website: [https://github.com/brpaz](https://github.com/brpaz)
* Github: [@brpaz](https://github.com/brpaz)

## 📝 License

[MIT](LICENSE)
