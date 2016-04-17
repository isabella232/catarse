# R&P Instructions

## MEGA SUPER WARNING

I am pretty sure that postgres & postgrest are not set up correctly. I had to give a couple roles additional access to ensure that they could read the appropriate data. And I am pretty sure this isn't right and may be a security risk.

Beyond the demo, this will need to be an area where we need to do some research to eliminate technical debt and risk.

## Settings

All the settings are in a table. `settings`
There's a shortcut to get and set them: `CatarseSettings[:column_name]`

## Translations

Yeah. So this part sucks.

We have forked catarse.js because there are strings hard-coded into the JS.
This is likely a bad way of doing things, but for now we don't have a lot of options.

## Blog

Hosted on tumblr and hacked in.

http://start-io.tumblr.com
username:  ********************
password:  *********************

There's up to a 10 minute cache delay on new articles.

## Other hacks.

There are a couple of manual DB views/stored procs that return the PT name instead of the EN name.
Manually fixed that on the staging DB.


## DEPLOYING TO CONVOX
First we build the apps.

```
# make the convox app
convox apps create catarse

#create postgres and redis services (backed by AWS)
convox services create redis --name=catarse-redis
convox services create postgres --allocated-storage=20 --instance-type=db.t2.small --max-connections={DBInstanceClassMemory/10000000} --name=catarse-postgres

```

Then we need to setup the ENV.

```
convox set env RAILS_ENV=production ... etc ...
```

For whatever reason the process doesn't seem to finish the migration properly.
So we need to manually migrate things. That's okay because convox makes it easy.

```
convox run app rake db:migrate
convox run app rake db:seeed
```
