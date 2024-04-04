# a puppet version of out setup of nginx for web static
exec { 'apt-update':
  command => '/usr/bin/env apt-get -y update',
}

exec { 'install-nginx':
  command => '/usr/bin/env apt-get -y install nginx',
}

exec { 'add-nginx-configuration':
  command => '/usr/bin/env sed -i "/listen \[::\]:80 default_server/ a\\
              rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;
              add_header X-Served-By \"\$HOSTNAME\";
              error_page 404 /custom_404.html;" /etc/nginx/sites-available/default',
  require => Exec['install-nginx'],
  notify  => Service['nginx'],
}

exec { 'create-custom-404-page':
  command => '/usr/bin/env bash -c "echo \"Ceci n\'est pas une page\" > /var/www/html/custom_404.html"',
}

service { 'nginx':
  ensure  => 'running',
  enable  => true,
}

file { '/data/web_static/releases/test/index.html':
  ensure  => file,
  content => "<html>\n<head>\n</head>\n<body>\nHolberton School\n</body>\n</html>",
}

file { '/data/web_static/current':
  ensure  => link,
  target  => '/data/web_static/releases/test/',
}

file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "# Your Nginx configuration content here",
  notify  => Service['nginx'],
}

exec { 'chown-data-directory':
  command => '/usr/bin/env chown -R ubuntu:ubuntu /data/',
}
