Dir['./app/controllers/*.rb'].each { |file| require file }

run App