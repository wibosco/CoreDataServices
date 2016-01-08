Pod::Spec.new do |s|

  s.name         = "CoreDataServices"
  s.version      = "0.2.0"
  s.summary      = "CoreDataServices contains a set of helper classes to abstract away common core data functionality."

  s.homepage     = "http://www.williamboles.me"
  s.license      = { :type => 'MIT', 
  					 :file => 'LICENSE.md' }
  s.author       = "William Boles"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/wibosco/CoreDataServices.git", 
  					 :branch => "master", 
  					 :tag => s.version }

  s.source_files  = "CoreDataServices/**/*.{h,m}"
  s.public_header_files = "CoreDataServices/**/*.{h}"

  s.frameworks = 'UIKit', 'CoreData'

  s.requires_arc = true

end
