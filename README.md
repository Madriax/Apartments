<p align="center"><img src="docs/Apartments.png" height="128" alt="Apartments"></p>
<h3 align="center">Apartments</h3>
<p align="center"><i>FiveM script for Apartments</i><p>

<p align="center">
  <a href="https://forthebadge.com">
      <img src="https://forthebadge.com/images/badges/made-with-crayons.svg">
  </a>
  <a href="https://github.com/Madriax/Apartments/issues">
      <img src="https://img.shields.io/github/issues/Madriax/Apartments.svg?style=for-the-badge">
  </a>
  <a href="https://github.com/Madriax/Apartments/stargazers">
      <img src="https://img.shields.io/github/stars/Madriax/Apartments.svg?style=for-the-badge">
  </a>
</p>

<p align="center">
  <a href="#key-features">Key Features</a> •
  <a href="#prerequisites">Prerequisites</a> •
  <a href="#installation">Installation</a> •
  <a href="#usage">Usage</a> •
  <a href="#contribution">Contribution</a> •
  <a href="#members">Members</a> •
  <a href="#license">License</a>
</p>

## Key Features

* You can visit apartments that haven't been purchased yet
* Buy / Sell apartments
* Deposit clean / dirty money
* Withdraw clean / dirty money
* Change the language (FR/EN)

## Prerequisites

* [EssentialMode](https://forum.fivem.net/t/release-essentialmode-base/3665) - pNotify simply implements a Javascript notification library called NOTY.
* [pNotify](https://forum.fivem.net/t/release-pnotify-in-game-js-notifications-using-noty/20659) - EssentiaMode is a base resource which has money and permissions built in.

## Installation

1. Extract the release downloaded [here](https://github.com/Madriax/Apartments/releases) in a folder called **apartments**.
2. Edit `server.cfg` and add `start apartments` in it.
3. Import the SQL file into your database.
4. You're ready to go !

## Usage

* You can **add/remove/change prices/change** locations of apartments in the file `apart_client.lua`.
* Change the locales at the beginning of each file.
* Switch to Async / MySQL.

## Contribution

* Fork the repository, use the development branch and please create pull requests to contribute to this project.
* Follow the same coding style as used in the project. Pay attention to the
  usage of tabs, spaces, newlines and brackets. Try to copy the aesthetics as
  best as you can.
* Write [good commit messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html),
  explain what your patch does, and why it is needed.
* Keep it simple: Any patch that changes a lot of code or is difficult to
  understand should be discussed before you put in the effort.

## Members

* **Alexandre DUVOIS** - *Main author* - *alex.duvois@gmail.com*
* **Yann SEGET** - *Documentation editor* - *dev@leafgard.fr*

### Special Thanks

* **Ykkris** - *[FiveM Profile Page](https://forum.fivem.net/u/ykkris)*
* **Goku_San** - *[FiveM Profile Page](https://forum.fivem.net/u/goku_san)*

[https://github.com/Madriax/Apartments](https://github.com/Madriax/Apartments)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
