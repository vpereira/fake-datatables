require 'faker'
require 'json'

apache_projects = 0.upto(100).collect { |i| 
  { name: "Apache:projects:#{i}" , description: Faker::Quote.famous_last_words }
}
projects = 0.upto(1000).collect { |i| 
  { name: "Project:openSUSE:Leap:#{i}" , description: Faker::Quote.famous_last_words }
}

home_projects = 0.upto(3000).collect { |i|
  { name: "home:user_#{i}:branches:#{Faker::Alphanumeric.alpha(number: 2)}", description: Faker::Quote.yoda }
}

h = { projects: { data: apache_projects + projects + home_projects } }

puts JSON.pretty_generate(h)



