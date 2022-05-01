# Bitcoin Alerter v2

Bitcoin Alerter is a tool to get on-demand and hourly updates on the prices of your favorite cryptos and Nasdaq stocks.

## How to use:

To start, text `register` to [(928) 756-0859](sms:+19287560859)
You can now use the following commands to customize your messages:

* `subscribe [ticker]` - add [ticker] to your price updates
* `unsubscribe [ticker]` - remove [ticker] from your price updates
* `start [hour]` - begin sending hourly updates at [hour] PST (24-hour time)
* `end [hour]` - stop sending hourly updates at [hour] PST (24-hour time)
* `toggle hourly messages` - toggles sending hourly updates
* `p` or `price` - get an on-demand price update
* `register` - register your phone number
* `unregister` - unregister your phone number
 

Cron for hourly updates:
```
0 * * * * /bin/bash -l -c "cd /full/path/to/bitcoinalerter/app && bundle exec bin/rails runner 'User.connection;User.all.each{|u| u.send_message}'"
```
