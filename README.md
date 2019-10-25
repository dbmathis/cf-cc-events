# CF CC Event
Output cloud controller events within a date range with pagination.


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
MacBook-Pro-3 cf-cc-events$ ./cf-cc-events.sh -s 2019-10-22T0:00:00Z -e 2019-10-24T00:00:00Z > 2019-10-22-2019-10-24-events.json

MacBook-Pro-3 cf-cc-events$ head 2019-10-22-2019-10-24-events.json
[
  {
    "metadata": {
      "guid": "a856fe0c-0c65-4c43-9d29-9c655dbaa18d",
      "url": "/v2/events/a856fe0c-0c65-4c43-9d29-9c655dbaa18d",
      "created_at": "2019-10-22T03:16:31Z",
      "updated_at": "2019-10-22T03:16:31Z"
    },
    "entity": {
      "type": "audit.user.organization_manager_add",

MacBook-Pro-3 cf-cc-events$ grep actor_username 2019-10-22-2019-10-24-events.json | wc -l
    1436
```


## Maintainer

* [David Mathis](https://github.com/dbmathis)


## Support

This is a community supported cloud foundry tool. Opening issues for questions, feature requests and/or bugs is the best path to getting "support".


## Known Issues

Need to add isolation segment support.s
