# NyulibrariesInstitutions

[![NYU](https://github.com/NYULibraries/nyulibraries_stylesheets/blob/master/app/assets/images/nyulibraries_stylesheets/nyu.png)](https://dev.library.nyu.edu)
[![Build Status](https://travis-ci.org/NYULibraries/nyulibraries_institutions.svg)](https://travis-ci.org/NYULibraries/nnyulibraries_institutions)
[![Code Climate](https://codeclimate.com/github/NYULibraries/nyulibraries_institutions/badges/gpa.svg)](https://codeclimate.com/github/NYULibraries/nyulibraries_institutions)
[![Coverage Status](https://coveralls.io/repos/github/NYULibraries/nnyulibraries_institutions/badge.svg?branch=master)](https://coveralls.io/github/NYULibraries/nnyulibraries_institutions?branch=master)

## Usage

```
gem 'nyulibraries_institutions', git: "https://github.com/NYULibraries/nyulibraries_institutions"
```

Automatically loads institution-related helpers to `ActionController` and `ActionView`

### Finding institution from current user

`NyulibrariesStylesheets` refers to a `current_user` method as one of several options to determine `current_institution`. It expects `current_user` to return an object responding to `institution_code`. If either `current_user` or `current_user.institution_code` is not defined in the client application, `current_institution` will default to NYU.
