class CreateOrganisationsRelationships < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :organisation, index: true
    add_reference :users, :organisation, index: true
  end
end
