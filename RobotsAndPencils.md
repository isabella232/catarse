# R&P Instructions

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
convox run app rake db:selenium-webdriver
```
