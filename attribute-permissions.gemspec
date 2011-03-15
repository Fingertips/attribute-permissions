Gem::Specification.new do |spec|
  spec.name = 'attribute-permissions'
  spec.version = '0.9'
  
  spec.author = "Manfred Stienstra"
  spec.email = "manfred@fngtps.com"
  
  spec.description = <<-EOF
    A plugin to manage attribute permissions on ActiveRecord more effectively 
  EOF
  spec.summary = <<-EOF
    Attribute Permissions adds methods to mass-assign attributes to ActiveRecord
    objects. It enables you to circumvent attribute protection with a minimal
    amount of code.
  EOF
  
  spec.files = %w(lib/mass_assignment.rb)
  spec.require_paths = ['lib']
  
  spec.has_rdoc = true
  spec.extra_rdoc_files = ['README', 'LICENSE']
  spec.rdoc_options << "--charset=utf-8"
end
