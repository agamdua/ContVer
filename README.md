# ContVer

Versioning for continuous delivery of frontend applications (see Explanation & Motivation below).

Includes work-in-progress CLI tool that implements the spec and helps with releases.


## Explanation & Motivation

Frontend applications in this context:

"The application (or part of the application) that is responsible for connecting with the users
and will rarely, if ever, be consumed programmatically in a production environment".

This does not rule out the possibility of using this in applications which are consumed
programmatically, however if they have an API (HTTP/library access/etc) of any sort
the versioning of that API may be better served by SemVer.


## Description of Versioning System

The version is specified as: `Major.Iteration.ReleaseNumber`

In the first interpretation, this will be specifically: `YY.II.R`.

In this model:

* `YY` - year
* `II` - iteration number (for example, sprint number, month number, week number)
* `R` - release number within that iteration


There is a variant if you have dependencies that you need to specify:

`YY.II.R.N` (`Major.Iteration.ReleaseNumber.Dependencies`)

* `N` - number of dependencies

The dependencies could have any semantics you prescribe to it and
would be useful at the related part of the delivery pipeline.

Dependencies are then specified in a `yaml` in a `.release.yml`
(or even `docker-compose.yml` in the future).

One example of such a use case is in a SOA/microservices architecture
where a feature on the frontend application depends on the deployment
of another service(s).

Optional dependencies need to be specified in this number but must be
marked as `optional: true` in the `.release.yml`.

Optional dependencies could be in the case of feature toggles - if for
some reason the dependency which the toggled feature relies on is not ready
to ship then it will not block the frontend application from shipping.


## Examples

#### `YY.MM.R.Dep` --> `16.8.4.1`

Breaking it down:

This application is being shipped:
* in the year of 2016
* in the month of August
* after three other releases already this month
* has one dependency

```yaml
# .release.yml
- major:
  - type: int
  - semantics: year
  - format: YY

- iteration:
  - type: int
  - semantics: month
  - format: MM

- release:
  - type: int

- dep:
  - type: int

- dependencies:
  - service1:
    - version: 1.2.1 
    - repo_url: xyz.git
    - optional: false
```

#### `YY.Q.R.Dep` --> `16.8.4.1`

This application is being shipped:
* in the year of 2016
* in the first quarter
* after three other releases already this quarter
* has one dependency


## Vision

Version numbers are useful for development. Development, IMO, is a
process which doesn't end till one releases to the user.

Coming from using SemVer for most projects, it seemed that it wasn't
really useful.

In a Scrum/Ban system with a focus on Continuous Delivery, it is more useful
to conform to the releases as they are made with the changesets outlining
the "semantics" of the change went in.

The "dependency" "bit" is to be super useful as something that
can serve, apart from information to the users, to a "type checker"
during the release process.
If `N` dependencies need, e.g., deployment then during the deploy step this
can be verified by the build tool being used.
The yaml file can be consumed by the build tool to make sure all
`N` dependencies are either shipped or execute the rollback for the 
whole process.


#### What about SemVer?
SemVer is more useful when things have to be consumed programmatically, by other
developers. A frontend application version number only has significance to the
process, the most important part which is the release/deploy.


## CLI Tool

### Goals
The scope of the tool is in design, at the moment the goals are:

* bump the release number
* validate the dependency file

Optional goals:
* orchestrate the build process (providing the jobs with the right versions and
  triggering the appropriate actions)
* orchestrating the deploy process


The tool is being written in Elixir and possibly ported to Python.
Hang tight.
