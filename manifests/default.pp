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

include 'upstart'

upstart::job { 'hello':
    description   => 'Example for our Hello',
    version       => '0.0.1',
    respawn       => true,
    respawn_limit => '5 10',
    user          => 'nginx',
    group         => 'nginx',
    chdir         => '/vagrant/proj',
    exec          => '/usr/bin/python app.py',
    require       => Package["bottle"]
}
