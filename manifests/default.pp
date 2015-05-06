class { "nginx": }

package {"python-pip":
    ensure => "present"
}

package { "bottle":
    provider => "pip",
    ensure   => "0.12.8",
    require  => Package["python-pip"]
}

nginx::resource::upstream { 'hello_app':
  members => [
    'localhost:8080',
  ],
}

nginx::resource::vhost { 'www.example.com':
  proxy => 'http://hello_app',
}

# Sets up Docker support
include "docker"
