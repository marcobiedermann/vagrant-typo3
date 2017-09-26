#!/usr/bin/env bash

TYPO3_VERSION="8.7.7"

# Download and extract Typo3
curl -L -o typo3_src.tgz get.typo3.org/${TYPO3_VERSION}
tar -xzf typo3_src.tgz
rm -f typo3_src.tgz

# Symlink Typo3 source folder
ln -s typo3_src-${TYPO3_VERSION} typo3_src
ln -s typo3_src/index.php index.php
ln -s typo3_src/typo3 typo3

# Rename .htaccess
cp typo3_src/_.htaccess .htaccess

# Create FIRST_INSTALL file
touch FIRST_INSTALL
