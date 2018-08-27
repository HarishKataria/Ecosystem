Pod::Spec.new do |s|
  s.name = 'Ecosystem'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'A framework to build complex-interconnected object trees'
  s.homepage = 'https://github.com/harishkataria/Ecosystem'
  s.authors = { 'Harish Kataria' => 'hkatariajob@gmail.com' }
  s.source = { :git => 'https://github.com/harishkataria/Ecosystem.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Source/**/*.swift'
end
