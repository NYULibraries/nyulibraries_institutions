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

The client application may define a `current_user` helper method (available in controllers and views). If this method returns a user object responding to `institution_code`, then `NyulibrariesInstitutions` uses this as one of several methods of determining `current_institution`. If it doesn't define this method, or the user object it returns doesn't implement `institution_code`, this option is silently ignored.

## Upgrading from Nyulibraries::Assets

The method `views` has been renamed `institution_views.`
