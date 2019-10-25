# CF CC Event



## Installation

### Install dependency jq.

#### jq: https://stedolan.github.io/jq/download

### Install hunter
```
$ git clone https://github.com/dbmathis/cf-cc-events.git
$ cd cf-cc-events
$ chmod +x cf-cc-event.sh
```


## Login
```
$ cf login -a api.<system domain>
```


## Usage
```
Usage:
  cf-cc-events.sh -s <date> -e <date>

  -s|--startdate <text> ISO-8601 date
  -e|--enddate   <text> ISO-8601 date
  -h|--help
Examples:
  $ cf-cc-events.sh -s "2019-10-23T00:00:00Z" -e 2019-10-24T00:00:00Z
```


## Examples
Run for a few days:
```
Text
```


## Maintainer

* [David Mathis](https://github.com/dbmathis)


## Support

This is a community supported cloud foundry tool. Opening issues for questions, feature requests and/or bugs is the best path to getting "support".


## Known Issues

Need to add isolation segment support.s
