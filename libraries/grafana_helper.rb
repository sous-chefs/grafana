module GrafanaCookbook
  module Helper
    extend ChefVaultCookbook if Kernel.const_defined?("ChefVaultCookbook")

    def self.data_bag_item(data_bag_name, data_bag_item, missing_ok=false)
      raw_hash = Chef::DataBagItem.load(data_bag_name, data_bag_item)
      encrypted = raw_hash.detect do |key, value|
        if value.is_a?(Hash)
          value.has_key?("encrypted_data")
        end
      end
      if encrypted
        if Chef::DataBag.load(data_bag_name).key? "#{data_bag_item}_keys"
          chef_vault_item(data_bag_name, data_bag_item)
        else
          secret = Chef::EncryptedDataBagItem.load_secret
          Chef::EncryptedDataBagItem.new(raw_hash, secret)
        end
      else
        raw_hash
      end
    rescue Chef::Exceptions::ValidationFailed,
        Chef::Exceptions::InvalidDataBagPath,
        Net::HTTPServerException => error
      missing_ok ? nil : raise(error)
    end
  end
end