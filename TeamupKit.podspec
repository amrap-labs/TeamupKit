Pod::Spec.new do |s|

  s.name         = "TeamupKit"
  s.platform     = :ios, "11.0"
  s.requires_arc = true

  s.version      = "0.1.0"
  s.summary      = "An iOS framework for Teamup services."
  s.description  = <<-DESC
  					A framework for communicating with Teamup, a service to super charge your fitness business.
                   DESC

  s.homepage          = "https://github.com/amrap-labs/TeamupKit"
  s.license           = "MIT"
  s.author            = { "Merrick Sapsford" => "merrick@sapsford.tech" }
  s.social_media_url  = "http://twitter.com/MerrickSapsford"

  s.source       = { :git => "https://github.com/amrap-labs/TeamupKit.git", :tag => s.version.to_s }
  s.source_files = "Sources/TeamupKit/**/*.{h,m,swift}"
  s.resource_bundle = { 'TeamupKit' => 'Pod/Resources/**/*' }

  s.dependency 'KeychainSwift', '~> 8.0.0'

end
