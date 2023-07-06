# Bitcoin Alerter v2

Due to A2P 10DLC registration requirements, Bitcoin Alerter is unable to operate over traditional SMS, and will be moving towards SMS over email by sending mail to carrier email-to-text gateways.

Cron for hourly updates:
```
0 * * * * /bin/bash -l -c "cd /full/path/to/bitcoinalerter/app && bundle exec bin/rails runner 'User.connection;User.all.each{|u| u.send_message}'"
```
