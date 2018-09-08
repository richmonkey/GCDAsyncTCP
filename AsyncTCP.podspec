Pod::Spec.new do |s|
  s.name             = "AsyncTCP"
  s.version          = "0.1.1"
  s.summary          = "asynctcp."
  s.description      = "tiny async tcp"
  s.homepage         = "http://developer.gobelieve.io"
  s.license          = 'MIT'
  s.author           = { "houxh" => "houxuehua49@gmail.com" }
  s.source           = { :git => 'git@github.com:richmonkey/async_tcp.git' }
  s.platform         = :ios, '8.0'
  s.requires_arc     = true

  s.public_header_files = 'source/*.h'
  s.source_files        = 'source/*.{h,m}'

end
