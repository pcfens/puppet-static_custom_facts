puppet-static_custom_facts
==========================

[![Build Status](https://travis-ci.org/pcfens/puppet-static_custom_facts.svg?branch=master)](https://travis-ci.org/pcfens/puppet-static_custom_facts)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with static_custom_facts](#setup)
    - [What static_custom_facts affects](#what-static_custom_facts-affects)
3. [Reference](#reference)
    - [Public Classes](#public-classes)
    - [Private Classes](#private-classes)
    - [Public Defines](#public-defines)
4. [Development - Guide for contributing to the module](#development)

## Description

The `static_custom_facts` module, other than having a long name, manages statically
set custom facts for machines. It was originally written to put static (but not
static enough to be in the certificate) contact information on servers while also
exposing the information in PuppetDB.

Structured facts (hashes and arrays) are supported in addition to traditional
facts (strings, numbers, and booleans).

`static_custom_facts` will only work in Puppet 4.

## Setup

### What static_custom_facts affects

Including `static_custom_facts` will ensure that the custom facts directory is
created. By default, unmanaged files are left alone, but can be purged with the
`purge_unmanaged` parameter.

Where [facts are stored](https://docs.puppet.com/facter/3.6/custom_facts.html#fact-locations)
is based on the operating system.

On a Linux box, this module uses `/opt/puppetlabs/facter/facts.d/`. On Windows
`C:\ProgramData\PuppetLabs\facter\facts.d\` is used.

## Reference

  - [**Public Classes**](#public-classes)
    - [Class: static_custom_facts](#class-static_custom_facts)
  - [**Private Classes**](#private-classes)
    - [Class: static_custom_facts::params](#class-static_custom_factsparams)
  - [**Public Defines**](#public-defines)
    - [Define: static_custom_facts::fact](#define-static_custom_factsfact)

### Public Classes

#### Class: `static_custom_facts`

Sets up the custom fact directory.

**Parameters within `static_custom_facts`**
- `facts_path`: [String] The directory where custom facts should be stored. (defaults to an OS specific path)
- `facts_path_owner`: [String] The owner of the directory created by `facts_path` (defaults to root on Linux)
- `facts_path_group`: [String] The group owning the directory created by `facts_path` (defaults to root on Linux)
- `purge_unmanage`: [Boolean] If set to true, facts managed outside of Puppet, but in the `facts_path` directory
  will be removed (default: false)
- `custom_facts`: [Hash] A set of custom facts that should be automatically created. Commonly used with hiera/lookup.

### Private Classes

#### Class: `static_custom_facts::params`

Sets the default parameters for `static_custom_facts` based on the operating system used.

### Public Defines

#### Define: `static_custom_facts::fact`

Creates a fact with the same name as the resource being created.

**Parameters for `static_custom_facts::fact`**
  - `ensure`: The ensure parameter on the fact itself. (default: present)
  - `value`: The value of the fact itself. Can be a string, array, hash, number, or boolean. (required)

## Development

Pull requests and bug reports are welcome. If you're sending a pull request, please
consider writing tests if applicable.
