class AddIpAddressAndAgentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :ip_addr, :string
    add_column :comments, :agent,   :string
  end
end
