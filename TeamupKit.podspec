Pod::Spec.new do |s|

  s.name         = "TeamupKit"
  s.platform     = :ios, "9.0"
  s.requires_arc = true

  s.version      = "0.2.0"
  s.summary      = "Swift framework for Teamup services."
  s.description  = <<-DESC
  					Swift framework for communicating with Teamup, a service to super charge your fitness business.
                   DESC

  s.homepage          = "https://github.com/amrap-labs/TeamupKit"
  s.license           = "MIT"
  s.author            = { "Merrick Sapsford" => "merrick@sapsford.tech" }
  s.social_media_url  = "http://twitter.com/MerrickSapsford"

  s.source       = { :git => "https://github.com/amrap-labs/TeamupKit.git", :tag => s.version.to_s }
  s.source_files = "Sources/TeamupKit/**/*.{h,m,swift}"
  s.resource_bundle = { 
    'TeamupKit' => [
      'Sources/TeamupKit/Resources/**/*'
    ] 
  }

  s.dependency 'KeychainSwift', '~> 8.0'
  s.dependency 'Alamofire', '~> 4.5.0'

end
