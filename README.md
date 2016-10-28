# NyulibrariesInstitutions

[![NYU](https://github.com/NYULibraries/nyulibraries_stylesheets/blob/master/app/assets/images/nyulibraries_stylesheets/nyu.png)](https://dev.library.nyu.edu)
[![Build Status](https://travis-ci.org/NYULibraries/nyulibraries_institutions.svg)](https://travis-ci.org/NYULibraries/nnyulibraries_institutions)
[![Code Climate](https://codeclimate.com/github/NYULibraries/nyulibraries_institutions/badges/gpa.svg)](https://codeclimate.com/github/NYULibraries/nyulibraries_institutions)
[![Coverage Status](https://coveralls.io/repos/github/NYULibraries/nnyulibraries_institutions/badge.svg?branch=master)](https://coveralls.io/github/NYULibraries/nnyulibraries_institutions?branch=master)

## Installation

```
gem 'nyulibraries_institutions', git: "https://github.com/NYULibraries/nyulibraries_institutions"
```

Automatically loads institution-related helpers to your Rails controllers and views.

## Usage

To determine the current institution viewed:

```
current_institution
```

This will use the first of:

1. The institution defined in the querystring with key `institution`.
1. The institution based on IP (`institution_from_ip`).
1. The institution based on the `current_user` (`institution_from_current_user`), assuming this method is defined in the client application.
1. The default institution (`default_institution`) as defined by `default: true` in institutions.yml

To include the stylesheet for the current institution in an ERB template:

```
<%= institutional_stylesheet %>
```

For a list of all institutions in institutions.yml:

```
institutions
```

### Note about `current_user`

The client application may define a `current_user` helper method (available in controllers and views). If this method returns a user object responding to `institution_code`, it will be used for `institution_from_current_user`. Otherwise, it returns `nil`.

## Upgrading from Nyulibraries::Assets

The method `views` has been renamed `institution_views.`
