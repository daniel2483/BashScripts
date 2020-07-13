# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -z "$SSH_AUTH_SOCK" ] ; then
 eval `ssh-agent -s` > /dev/null
 ssh-add /home/x-jrodrigue/.ssh/pdxc_sbx_oc_keypair.pem 2>/dev/null
 ssh-add /home/x-jrodrigue/.ssh/jrodrigue253.pem 2>/dev/null
 ssh-add 2>/dev/null
fi
trap "kill $SSH_AGENT_PID" 0

# Aliases
alias cgi="cd /opt/cloudhost/apache/www/cgi-bin/GTOD_CC"
alias html="cd /opt/cloudhost/apache/www/html"
alias home="cd ~"
