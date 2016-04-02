Pod::Spec.new do |s|

  s.name         = "CoreDataServices"
  s.version      = "2.0.3"
  s.summary      = "CoreDataServices contains a set of helper classes/extensions to abstract out a lot of the boilerplate that you get with Core Data."

  s.homepage     = "http://www.williamboles.me"
  s.license      = { :type => 'MIT', 
  					 :file => 'LICENSE.md' }
  s.author       = "William Boles"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/wibosco/CoreDataServices.git", 
  					 :branch => "master", 
  					 :tag => s.version }

  s.source_files  = "CoreDataServices/**/*.swift"
	
  s.requires_arc = true

  s.dependency 'ConvenientFileManager', '~> 2.0'
	
  s.frameworks = 'CoreData'
  
end
