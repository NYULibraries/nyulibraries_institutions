# NyulibrariesInstitutions

## Usage

```
gem 'nyulibraries_institutions', git: "https://github.com/NYULibraries/nyulibraries_institutions"
```

Automatically loads institution-related helpers to `ActionController` and `ActionView`

### Finding institution from current user

`NyulibrariesStylesheets` refers to a `current_user` method as one of several options to determine `current_institution`. It expects `current_user` to return an object responding to `institution_code`. If either `current_user` or `current_user.institution_code` is not defined in the client application, `current_institution` will default to NYU.
