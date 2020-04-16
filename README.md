# Hadolint GitHub Action

> Action that runs [Hadolint](https://github.com/hadolint/hadolint) Dockerfile linting tool.

[![GitHub Action](https://img.shields.io/badge/GitHub-Action-blue?style=for-the-badge)](https://github.com/features/actions)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg?style=for-the-badge)](http://commitizen.github.io/cz-cli/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg?style=for-the-badge)](https://github.com/semantic-release/semantic-release?style=for-the-badge)

[![GitHub Actions](https://github.com/brpaz/hadolint-action/workflows/CI/badge.svg?style=for-the-badge)](https://github.com/brpaz/hadolint-action/actions)

## Usage

```yml
steps:
    uses: brpaz/hadolint-action@master
```

## Inputs

**`dockerfile`**

The path to the Dockerfile to be tested. By default it will look for a Dockerfile in the current directory.

## 🤝 Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Useful Resources

* [Building actions - GitHub Help](https://help.github.com/en/articles/building-actions)
* [actions/toolkit: The GitHub ToolKit for developing GitHub Actions.](https://github.com/actions/toolkit)
* [Dockerfile Linter action](https://github.com/buddy-works/dockerfile-linter)

## Author

👤 **Bruno Paz**

* Website: [https://github.com/brpaz](https://github.com/brpaz)
* Github: [@brpaz](https://github.com/brpaz)

## 📝 License

Copyright © 2019 [Bruno Paz](https://github.com/brpaz).

This project is [MIT](LICENSE) licensed.
