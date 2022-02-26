# Favorite Morrowind Mods

## Description

The repo contains my favorite Morrowind mods. I don't want to loose them again, so I decided to put them into a single repo.

Each mod has its own authors, that are credited both in original source files and README.MD files in mod folder.

I translated (and sometimes added translation support) into Russian all of these mods, so they can be used by Russian fans as well.

## Installation

1. All of the modes **require MGXE** to be installed. Check [that Nexus page](https://www.nexusmods.com/morrowind/mods/41102).

1. Then just copy mod files (`<mod-name>/Data Files/**`) into `<MorrowindRoot>/Data Files` folder.

## Known problems

For some reason extension API doesn't detect Russian version of the Morrowind. For now I hardcoded Russian Language to be loaded by default. Need to find a solution.

Translation files (usually `translation.lua`) must be saved in Windows-1251 encoding to support Russian translation in the game.