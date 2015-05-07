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

docker::image{"ubuntu":
    image_tag => "14.04"
}

docker::image{"hello":
    docker_dir => "/vagrant/proj",
    require    => Docker::Image["ubuntu"]
}

docker::run{"hello":
    image   => "hello",
    ports   => ["8080:8080"],
    require => Docker::Image["hello"]
}
