let upstream = https://github.com/dfinity/vessel-package-set/releases/download/mo-0.11.1-20240411/package-set.dhall sha256:2577daca3a1f10b26d3e2c42221bc9860d02b8fd7e2ef35a9c669ffa27984fc4
let Package =
    { name : Text, version : Text, repo : Text, dependencies : List Text }

let
  -- This is where you can add your own packages to the package-set
  additions =
    [] : List Package

let
  {- This is where you can override existing packages in the package-set

     For example, if you wanted to use version `v2.0.0` of the foo library:
     let overrides = [
         { name = "foo"
         , version = "v2.0.0"
         , repo = "https://github.com/bar/foo"
         , dependencies = [] : List Text
         }
     ]
  -}
  overrides =
    [] : List Package

in  upstream # additions # overrides
