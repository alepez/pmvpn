Gem::Specification.new do |s|
  s.name        = 'pmvpn'
  s.version     = '0.0.1'
  s.date        = '2013-05-28'
  s.summary     = "Poor Man VPN"
  s.description = "Manage a simple vpn with ssh tunnels"
  s.authors     = ["Alessandro Pezzato"]
  s.email       = 'alessandro@pezzato.net'
  s.homepage    = 'http://pezzato.net/projects/pmvpn.html'
  s.files       << "lib/pmvpn.rb"
  s.files       << "lib/pmvpn/client.rb"
  s.files       << "lib/pmvpn/server.rb"
  s.executables << "pmvpn_client"
  s.executables << "pmvpn_server"
end