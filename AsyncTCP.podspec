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

  s.subspec 'AsyncTCP' do |sp|
    sp.public_header_files = 'source/*.h'
    sp.source_files        = 'source/*.{h,m}'
    sp.exclude_files       = 'source/SSLAsyncTCP.m'
  end

  s.subspec 'SSLAsyncTCP' do |sp|
    sp.public_header_files = 'source/*.h'
    sp.source_files        = 'source/*.{h,m}'
    sp.exclude_files       = 'source/AsyncTCP.m'
  end  
end
