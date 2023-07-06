# Bitcoin Alerter v2

Messages come from `bitcoinalerter@matthiasclee.com` in the format: `(BTC) $34,567`

Cron for hourly updates:
```
0 5-20 * * * /bin/bash -l -c "cd /full/path/to/bitcoinalerter/app && bundle exec bin/rails runner 'User.connection;User.all.each{|u| u.send_message}'"
```
