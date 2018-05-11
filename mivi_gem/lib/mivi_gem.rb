# frozen_string_literal: true

require 'json'
# Class for fetching custom attributes from given JSON
class MiviGem
  # Extract custom attributes from a given JSON
   #
   # Example:
   #   >> MiviGem.fetch_values("file_name.json")
   #   => {:phone_number=>"000000000",
   #       :email_address=>"dhruv@test.com",
   #       :name=>"Mr. Dhruv Sharma",
   #       :product_name=>"PRODUCT NAME"}
   #
   # Arguments:
   #   file_name: (String)
  def self.fetch_values(file_name)
    file = File.read file_name
    parsed_data = JSON.parse file
    product_name = ''
    parsed_data['included'].each do |tag|
      product_name = tag['attributes']['name'] if tag['type'] == 'products'
    end
    custom_attributes(
      att: parsed_data['data']['attributes'],
      product_name: product_name
    )
  end

  # Logic for returning custom defined attributes from the json
  def self.custom_attributes(att:, product_name:)
    {
      phone_number: att['contact-number'],
      email_address: att['email-address'],
      name: att['title'] + '. ' +
        att['first-name'].capitalize + ' ' +
        att['last-name'].capitalize,
      product_name: product_name
    }
  end
end
