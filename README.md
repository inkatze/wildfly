wildfly
=======

This role installs Wildfly's application runtime.

Role Variables
--------------

It's important to change the bind addresses to localhost or internal network in
production environments. The management user is also intended for
non-production environments, so you must change these variables for production
or undefine them and the user creation task will be skipped. You can also set
the variable `wildfly_management_user_overwrite` to `no` to avoid the user
creation or override and have the correct change status.

Defaults:

    wildfly_version: 9.0.1.Final

    wildfly_user: wildfly
    wildfly_group: wildfly

    wildfly_base_download_url: http://download.jboss.org/wildfly
    wildfly_name: wildfly-{{ wildfly_version }}
    wildfly_download_file: "{{ wildfly_name }}.tar.gz"
    wildfly_download_url: "{{ wildfly_base_download_url }}/{{ wildfly_version }}/\
                        {{ wildfly_download_file }}"
    wildfly_download_dir: /tmp

    wildfly_install_dir: /opt
    wildfly_dir: "{{ wildfly_install_dir }}/{{ wildfly_name }}"
    wildfly_version_file: "{{ wildfly_dir }}/version"

    wildfly_console_log_dir: "/var/log/wildfly"
    wildfly_console_log_file: "console.log"
    wildfly_console_log: "{{ wildfly_console_log_dir }}/\
                        {{ wildfly_console_log_file }}"

    wildfly_conf_dir: /etc/wildfly
    wildfly_standalone_config_file: standalone.xml
    wildfly_standalone_config_path: "{{ wildfly_dir }}/standalone/configuration/\
                                    {{ wildfly_standalone_config_file }}"
    wildfly_init_dir: /etc/init.d

    wildfly_bind_address: 0.0.0.0
    wildfly_management_bind_address: 0.0.0.0
    wildfly_manage_port: 9990
    wildfly_http_port: 8080

    wildfly_management_user: admin
    wildfly_management_password: admin
    wildfly_management_user_overwrite: yes

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: inkatze.wildfly }

Troubleshooting
---------------

  - If you're getting a `Connection refused` error in your browser check that
  you have the correct IP address in your `wildfly_bind_address` variable.

License
-------

BSD
