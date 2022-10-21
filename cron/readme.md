## set-theme

* `gsettings` cli utility allow for cinnamon manupulation. See its manual for details.
* Theme names to set are taken directly from `Themes` application. It is possible to locate themes on disk and take names from there,\
  however I did not find them.
* [Kitty themes docs](https://sw.kovidgoyal.net/kitty/kittens/themes/)
* To schedule cron tasks use `crontab` utility. `crontab -e` to edit configuration, `crontab -l` to print current configuration.


  ```shell
  # Custom tasks
  SHELL=/bin/bash
  MAILTO=stub@stub.stub
  PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/home/kkafara/scripts/bin:/home/kkafara/.local/bin

  # Change theme. Check twice an hour.
  01 * * * * /bin/bash -c /home/kkafara/scripts/cron/set-theme.sh
  31 * * * * /bin/bash -c /home/kkafara/scripts/cron/set-theme.sh
  ```
