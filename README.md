# Wildfly

[![Build Status](https://travis-ci.org/inkatze/wildfly.svg?branch=master)](https://travis-ci.org/inkatze/wildfly)

This role installs Wildfly's application runtime.

## Role Variables

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
    wildfly_download_validate_certs: "yes"
    wildfly_download_url: "{{ wildfly_base_download_url }}/{{ wildfly_version }}/\
                        {{ wildfly_download_file }}"
    wildfly_download_dir: /tmp

    wildfly_install_dir: /opt
    wildfly_dir: "{{ wildfly_install_dir }}/{{ wildfly_name }}"

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
    wildfly_manage_http_port: 9990
    wildfly_manage_https_port: 9993
    wildfly_http_port: 8080
    wildfly_https_port: 8443

    wildfly_enable_ssl: no
    wildfly_keystore_name: my.jks
    wildfly_keystore_path: "{{ wildfly_dir }}/standalone/configuration/\
                            {{ wildfly_keystore_name }}"
    wildfly_keystore_alias: my
    wildfly_keystore_password: "secret"
    wildfly_key_password: "secret"
    wildfly_application_ssl_identity: '
        <server-identities>
            <ssl>
                <keystore path="{{ wildfly_keystore_name }}"
                relative-to="jboss.server.config.dir"
                alias="{{ wildfly_keystore_alias }}"
                keystore-password="{{ wildfly_keystore_password }}"
                key-password="{{ wildfly_key_password }}"/>
            </ssl>
        </server-identities>'
    wildfly_https_listener: '
        <https-listener name="https-server" socket-binding="https"
        security-realm="ManagementRealm"/>'

    # Manually defined variables
    # wildfly_management_user: admin
    # wildfly_management_password: admin

## Example Playbook

    - hosts: servers
      roles:
         - { role: inkatze.wildfly }

## Admin User

It's recommended that you create Wildfly's admin user separately as follows:

    $ ansible-playbook main.yml --extra-vars "wildfly_management_user=admin wildfly_management_password=admin"

## SSL Support

In order to enable SSL for applications and the management interface you have
to set the `wildfly_enable_ssl` variable to `yes` and put the keystore file
into this role files folder.

You can create a self signed keystore file with the following command:

    $ keytool -genkey -alias mycert -keyalg RSA -sigalg MD5withRSA -keystore my.jks -storepass secret  -keypass secret -validity 9999

It's recommended that the first and last name is your hostname. After this file
is created, you have to set the keystore related variable in order to work
correctly.

To create a keystore with your own certificate you need to run the following commands:

    $ cat /etc/ssl/certs/ca-bundle.crt intermediate.crt > allcacerts.crt
    $ openssl verify -CAfile allcacerts.crt certificate.crt
    $ openssl pkcs12 -export -chain -CAfile allcacerts.crt -in certificate.crt -inkey private.key -out my.p12 -name my
    $ keytool -importkeystore -destkeystore my.jks -srckeystore my.p12 -srcstoretype pkcs12 -alias my

The first command will add your intermediate to the openssl's CAs; the order is
important and you may need to put the itermediate file before `ca-bundle.crt`.
The second command is to verify that your certificate is signed by a known CA,
usually if this step fails, the rest of the process will fail too.
The third command is to import the all our certificate files in pkcs12 format.
Finally we use keytool to create the keystore to be used in wildfly.

## Troubleshooting

  - If you're getting a `Connection refused` error in your browser check that
  you have the correct IP address in your `wildfly_bind_address` variable.

## License

BSD
