# Bitcoin Alerter v2

Cron for hourly updates:
```
0 * * * * /bin/bash -l -c "cd /full/path/to/bitcoinalerter/app && bundle exec bin/rails runner 'User.connection;User.all.each{|u| u.send_message}'"
```
