wildfly
=======

This role installs Wildfly's application runtime.

Role Variables
--------------

It's important to change the bind addresses to localhost or internal network in
production environments.

Defaults:

    wildfly_version: 9.0.0.Final

    wildfly_base_download_url: http://download.jboss.org/wildfly
    wildfly_name: wildfly-{{ wildfly_version }}
    wildfly_download_file: "{{ wildfly_name }}.tar.gz"
    wildfly_download_url: "{{ wildfly_base_download_url }}/{{ wildfly_version }}/\
                        {{ wildfly_download_file }}"
    wildfly_download_dir: /tmp

    wildfly_install_dir: /opt
    wildfly_dir: "{{ wildfly_install_dir }}/{{ wildfly_name }}"
    wildfly_log_dir: "/var/log/wildfly"
    wildfly_log_file: "console.log"
    wildfly_log: "{{ wildfly_log_dir }}/{{ wildfly_log_file }}"
    wildfly_version_file: "{{ wildfly_dir }}/version"

    wildfly_conf_dir: /etc/wildfly
    wildfly_init_dir: /etc/init.d

    wildfly_bind_address: 0.0.0.0
    wildfly_management_bind_address: 0.0.0.0
    wildfly_manage_port: 9990
    wildfly_http_port: 8080

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: inkatze.wildfly }

License
-------

BSD
