#!/usr/bin/env bash

THIS="$(pwd)"

_cleanup() {
  echo -e "#!/usr/bin/env bash" >> /tmp/deploy_cleanup.sh
  echo -e "rm -rf ${THIS}" >> /tmp/deploy_cleanup.sh
  echo -e "crontab -l | sed '/# REF:deploy_cleanup:REF/Q' | crontab -" >> /tmp/deploy_cleanup.sh
  chmod +x /tmp/deploy_cleanup.sh
  echo -e "$(crontab -l)\n# REF:deploy_cleanup:REF\n* * * * *\t/tmp/deploy_cleanup.sh" | crontab -
}

_bash_overrides() {
  cp -r bashrc_overrides ~/.bashrc_overrides
  echo -e "if [ -f ~/.bashrc_overrides/_all ]; then\n  . ~/.bashrc_overrides\nfi" >> ~/.bashrc
}
